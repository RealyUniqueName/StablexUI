package ru.stablex.ui.widgets;

import nme.events.MouseEvent;
import ru.stablex.ui.events.WidgetEvent;
import ru.stablex.ui.misc.BtnState;
import ru.stablex.ui.skins.Skin;



/**
* State button. Iterate through defined states with each click.
* Simple case: toggle button
* See samples/toggles on <a href="https://github.com/RealyUniqueName/StablexUI" target="_blank">GitHub</a>
*/
class StateButton extends Button{


    //object to define button states
    public var states : DynamicList<BtnState>;
    //defines states order. Only states defined in this array will apear on button clicking
    public var order : Array<String>;
    //current state
    public var state(_getState,_setState) : String;
    //current state index in this.order array
    private var _currentIdx (default,_setCurrentIdx) : Int = 0;


    /**
    * Constructor
    *
    */
    public function new () : Void {
        super();

        this.states = new DynamicList(BtnState);

        //change states on click
        this.addEventListener(MouseEvent.CLICK, this.nextState);
    }//function new()


    /**
    * Setter for `._currentIdx`
    * @dispatch <type>ru.stablex.ui.events.WidgetEvent</type>.CHANGE
    */
    private function _setCurrentIdx(idx:Int) : Int {
        if( idx != this._currentIdx ){
            this._currentIdx = idx;
            if( this.created ){
                this.dispatchEvent(new WidgetEvent(WidgetEvent.CHANGE));
            }
        }
        return idx;
    }//function _setCurrentIdx()


    /**
    * Getter for `.state`
    *
    */
    private function _getState () : String {
        //order must be defined
        if( this.order == null || this.order.length == 0 ) return null;

        return this.order[ this._currentIdx ];
    }//function _getState()


    /**
    * Setter for state
    *
    */
    private function _setState (s:String) : String {
        this.set(s);
        return s;
    }//function _setState()


    /**
    * Set next state
    *
    */
    public function nextState (e:MouseEvent = null) : Void {
        //order must be defined
        if( this.order == null || this.order.length == 0 ) return;

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
                this.ico = state._ico;
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
