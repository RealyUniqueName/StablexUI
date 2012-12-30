package ru.stablex.ui.widgets;

import ru.stablex.ui.UIBuilder;
import nme.events.MouseEvent;
import nme.events.MouseEvent;


/**
* Simple button
*/
class Button extends Box{

    //wether button is currently pressed
    public var pressed (default,null) : Bool = false;
    //Wether mouse pointer is currently over this button
    public var hovered (default,null) : Bool = false;
    //button label
    public var label : Text;


    /**
    * We use wrappers so if we assign another functions to instance methods like .onPress, we don't need to reaply eventListeners
    * {
    */

        /**
        * wrapper for hover
        *
        */
        static private function _onHover (e:MouseEvent) : Void {
            cast(e.currentTarget, Button).onHover(e);
        }//function _onHover()


        /**
        * wrapper for hout
        *
        */
        static private function _onHout (e:MouseEvent) : Void {
            cast(e.currentTarget, Button).onHout(e);
        }//function _onHout()


        /**
        * wrapper for press
        *
        */
        static private function _onPress (e:MouseEvent) : Void {
            cast(e.currentTarget, Button).onPress(e);
        }//function _onPress()


        /**
        * wrapper for release
        *
        */
        static private function _onRelease (e:MouseEvent) : Void {
            cast(e.currentTarget, Button).onRelease(e);
        }//function _onRelease()
    /*
    * } wrappers
    **/


    /**
    * Constructor
    *
    */
    public function new () : Void{
        super();

        this.buttonMode    = true;
        this.mouseChildren = false;

        //process interactions with mouse pointer
        this.addEventListener(MouseEvent.MOUSE_OVER, Button._onHover);
        this.addEventListener(MouseEvent.MOUSE_OUT, Button._onHout);
        this.addEventListener(MouseEvent.MOUSE_DOWN, Button._onPress);
        this.addEventListener(MouseEvent.MOUSE_OUT, Button._onRelease);
        this.addEventListener(MouseEvent.MOUSE_UP, Button._onRelease);

        this.pressed = false;
        this.hovered = false;

        this.label = cast(this.addChild(UIBuilder.create(Text)), Text);

        this.align = "center,middle";
    }//function new()


    /**
    * Refresh widget. Also refreshes button label
    *
    */
    override public function refresh () : Void {
        this.label.refresh();
        super.refresh();
    }//function refresh()


    /**
    * Process pressing
    *
    */
    public dynamic function onPress (e:MouseEvent) : Void {
        var btn : Button = cast(e.currentTarget, Button);

        //if button is already pressed, do nothing
        if( btn.pressed ) return;

        btn.y ++;

        btn.pressed = true;
    }//function onPress()


    /**
    * Process releasing
    *
    */
    public dynamic function onRelease (e:MouseEvent) : Void {
        var btn : Button = cast(e.currentTarget, Button);

        //if button is pressed
        if( btn.pressed ){
            btn.y --;
            btn.pressed = false;
        }
    }//function onRelease()


    /**
    * Process hover
    *
    */
    public dynamic function onHover (e:MouseEvent) : Void {

    }//function ononHover()


    /**
    * Process hout
    *
    */
    public dynamic function onHout (e:MouseEvent) : Void {

    }//function onHout()
}//class Button