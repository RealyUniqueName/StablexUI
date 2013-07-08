package ru.stablex.ui.widgets;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import ru.stablex.ui.events.WidgetEvent;



/**
* Progress bar
*
*/
class Progress extends Widget{
    //Maximum value.
    public var max (default,set_max) : Float = 100;
    //current value
    @:isVar public var value (get_value,set_value) : Float = 0;
    private var _value : Float = 0;
    //bar
    public var bar : Widget;
    //Whether user can click/tap/slide progress bar to change value
    public var interactive (default,set_interactive) : Bool = false;
    //Visualize progress bar changes smoothly
    public var smoothChange : Bool;


    /**
    * Constructor
    *
    */
    public function new () : Void {
        super();
        this.bar = cast this.addChild(UIBuilder.create(Widget));
        this.bar.heightPt = 100;
    }//function new()


    /**
    * Set initial bar size on creation is complete.
    *
    */
    override public function onCreate () : Void {
        super.onCreate();
        this._setBarWidth(this.value, this.max);
    }//function onCreate()


    /**
    * Setter for `.max`
    *
    */
    @:noCompletion private function set_max (m:Float) : Float {
        if( this.created ){
            this._setBarWidth(this.value, m);
        }
        return this.max = m;
    }//function set_max()


    /**
    * Setter for `.value`
    *
    */
    @:noCompletion private function set_value (v:Float) : Float {
        this._setBarWidth(v, this.max);
        this._value = v;
        if( this.created ){
            this.dispatchEvent(new WidgetEvent(WidgetEvent.CHANGE));
        }
        return v;
    }//function set_value()


    /**
    * Getter for `.value`
    *
    */
    @:noCompletion private function get_value () : Float {
        return this._value;
    }//function set_value()


    /**
    * Set bar width based on provided values
    *
    */
    private inline function _setBarWidth (value:Float, max:Float) : Void {
        if( !this.smoothChange ){
            this.bar.widthPt = 100 * (max <= 0 || value <= 0 ? 0 : value / max);
        }else{
            this.bar.tween(0.1, {widthPt: 100 * (max <= 0 || value <= 0 ? 0 : value / max)}, "Quad.easeIn");
        }
    }//function _setBarWidth()


    /**
    * Setter `interactive`.
    *
    */
    @:noCompletion private function set_interactive (interactive:Bool) : Bool {
        if( interactive ){
            this.addUniqueListener(MouseEvent.MOUSE_DOWN, this._slide);
        }else{
            this.removeEventListener(MouseEvent.MOUSE_DOWN, this._slide);
        }
        return this.interactive = interactive;
    }//function set_interactive



    /**
    * Change value on click/tap/slide
    *
    */
    private function _slide (e:MouseEvent) : Void {
        var dx : Float = this.mouseX;

        var fn : Event->Void = function(e:Event) : Void {
            var newValue:Float = Math.min((this.mouseX / this._width) * this.max, this.max);
            if( newValue != this.value ){
                if( newValue < 0 ){
                    newValue = 0;
                }else if( newValue > this.max ){
                    newValue = max;
                }
                this.value = newValue;
            }
        };

        var fnRelease : MouseEvent->Void = null;
        fnRelease = function(e:MouseEvent) : Void {
            this.removeEventListener(Event.ENTER_FRAME, fn);
            Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, fnRelease);
        };

        this.addEventListener(Event.ENTER_FRAME, fn);
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, fnRelease);
    }//function _slide()

}//class Progress