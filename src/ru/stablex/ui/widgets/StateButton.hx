package ru.stablex.ui.widgets;

import nme.events.MouseEvent;
import ru.stablex.ui.misc.BtnState;
import ru.stablex.ui.skins.Skin;



/**
* State button. Iterate through defined states with each click.
* Simple case: toggle button
* See samples/stateButtons on <a href="https://github.com/RealyUniqueName/StablexUI" target="_blank">GitHub</a>
*/
class StateButton extends Button{
    

    //object to define button states
    public var states : DynamicList<BtnState>;
    //defines states order. Only states defined in this array will apear on button clicking
    public var order : Array<String>;
    //current state
    public var state(default,null) : String;
    //current state index in this.order array
    private var _currentIdx : Int = 0;


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

        this.refresh();
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

        this.refresh();
    }//function set()


    /**
    * Refresh button
    *
    */
    override public function refresh () : Void {
        //if order is not defined, do nothing
        if( this.order != null && this.order.length > 0 ){
            this.state = this.order[ this._currentIdx ];
            var state : BtnState = Reflect.getProperty(this.states, this.state);

            this.label.text = (state.text == null ? this.state : state.text);
            if( state.skin != null ){
                this.skin = state.skin;
            }
            if( state._ico != null ){
                this.ico = state._ico;
            }
        }

        super.refresh();
    }//function refresh()
}//class StateButton
