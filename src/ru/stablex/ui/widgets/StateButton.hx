package ru.stablex.ui.widgets;

import flash.events.MouseEvent;
import ru.stablex.ui.events.WidgetEvent;
import ru.stablex.ui.misc.BtnState;
import ru.stablex.ui.skins.Skin;



/**
* State button. Iterate through defined states with each click.
* Simple case: toggle button
* See samples/toggles on <a href="https://github.com/RealyUniqueName/StablexUI" target="_blank">GitHub</a>
*
* @dispatch <type>ru.stablex.ui.events.WidgetEvent</type>.CHANGE - on state change
*/
class StateButton extends Button{

    //change states on click
    public var cycleStates(default,set) : Bool;
    //object to define button states
    public var states : DynamicList<BtnState>;
    //defines states order. Only states defined in this array will apear on button clicking
    public var order : Array<String>;
    //current state
    public var state(get,set) : String;
    //current state index in this.order array
    private var _currentIdx (default,set) : Int = 0;


    /**
    * Constructor
    *
    */
    public function new () : Void {
        super();

        this.states = new DynamicList(BtnState);
        this.cycleStates = true;
    }//function new()


    /**
    * Setter for `._currentIdx`
    * @dispatch <type>ru.stablex.ui.events.WidgetEvent</type>.CHANGE
    */
    @:noCompletion private function set__currentIdx(idx:Int) : Int {
        if( idx != this._currentIdx ){
            this._currentIdx = idx;
            if( this.created ){
                this.dispatchEvent(new WidgetEvent(WidgetEvent.CHANGE));
            }
        }
        return idx;
    }//function set__currentIdx()


    /**
    * Getter for `.state`
    *
    */
    @:noCompletion private function get_state () : String {
        //order must be defined
        if( this.order == null || this.order.length == 0 ) return null;

        return this.order[ this._currentIdx ];
    }//function get_state()


    /**
    * Setter for state
    *
    */
    @:noCompletion private function set_state (s:String) : String {
        this.set(s);
        return s;
    }//function set_state()


    /**
    * Setter for cycleStates
    *
    */
    @:noCompletion private function set_cycleStates (cycleStates:Bool) : Bool {
        if( this.cycleStates != cycleStates ){
            if( cycleStates ){
                this.addEventListener(MouseEvent.CLICK, this.nextState);
            }else{
                this.removeEventListener(MouseEvent.CLICK, this.nextState);
            }
            this.cycleStates = cycleStates;
        }

        return cycleStates;
    }//function set_cycleStates()


    /**
    * Set next state
    *
    */
    public function nextState (e:MouseEvent = null) : Void {
        //order must be defined
        if( !this.cycleStates || this.order == null || this.order.length == 0 ) return;

        if( this.order.length <= this._currentIdx + 1 ){
            this._currentIdx = 0;
        }else{
            this._currentIdx ++;
        }

        this.updateState();
    }//function nextState()


    /**
    * Set specified state
    *
    */
    public function set (state:String) : Void {
        //if order is not defined, do nothing
        if( this.order == null || this.order.length == 0 ) return;

        //find state index
        for(i in 0...this.order.length){
            if( this.order[i] == state ){
                this._currentIdx = i;
                break;
            }
        }

        if( this.created ){
            this.updateState();
        }
    }//function set()


    /**
    * Apply icon/text/skin of current state
    *
    */
    public function updateState() : Void {
        //if order is not defined, do nothing
        if( this.order != null && this.order.length > 0 ){
            var state : BtnState = this.states.get(this.state);

            this.label.text = (state.text == null ? (this.text == null ? this.state : this.text) : state.text);
            if( state.skin != null ){
                this.skin = state.skin;
            }
            if( state._ico != null ){
                if( this._icoHovered != null ) this._icoHovered.visible = false;
                if( this._icoPressed != null ) this._icoPressed.visible = false;
                this.ico = state._ico;
                this.ico.visible = true;
            }

            if( this.created ){
                this.refresh();
            }
        }
    }//function updateState()


    /**
    * On initialization is complete, set first state
    *
    */
    override public function onInitialize() : Void {
        this.updateState();
        super.onInitialize();
    }//function onInitialize()

}//class StateButton
