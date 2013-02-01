package ru.stablex.ui.widgets;

import nme.display.DisplayObject;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.Lib;



/**
* Scroll container.
* First child of this widget will be used as container for scrolled content.
*/
class Scroll extends Widget{

    //allow vertical scrolling
    public var vScroll : Bool = true;
    //allow horizontal scrolling
    public var hScroll : Bool = true;
    //allow scrolling by mouse wheel
    public var wheelScroll : Bool = true;
    /**
    * Modifier to scroll horizontally instead of vertically, when using mouse wheel
    * Possible values: shift, alt, ctrl
    * Note for flash: some browsers reserve shift+wheel, alt+wheel, ctrl+wheel combinations
    */
    public var hScrollKey : String = 'alt';
    //allow scrolling by dragging
    public var dragScroll : Bool = true;
    /**
    * Container for content. Content is scrolled by moving this container.
    * This is always the first child of Scroll widget
    */
    public var box (_getBox,never) : Widget;

    //scroll position along x axes
    public var scrollX (_getScrollX,_setScrollX) : Float;
    //scroll position along y axes
    public var scrollY (_getScrollY,_setScrollY) : Float;


    /**
    * Constructor
    *  `.overflow` = false by default
    */
    public function new () : Void {
        super();
        this.overflow = false;
    }//function new()


    /**
    * Getter for `.box`
    *
    */
    private function _getBox () : Widget {
        if( this.numChildren == 0 ){
            Err.trigger('Scroll widget must have at least one child.');
            return null;
        }else{

            var child : DisplayObject = this.getChildAt(0);
            if( !Std.is(child, Widget) ){
                Err.trigger('Instance of Widget must be the first child for Scroll widget');
            }
            return cast(child, Widget);
        }
    }//function _getBox()


    /**
    * Setter for .scrollX
    *
    */
    private function _setScrollX (x:Float) : Float {
        if( x > 0 ) x = 0;
        if( x + this.box._width < this._width ) x = this._width - this.box._width;
        return this.box.left = x;
    }//function _setScrollX()


    /**
    * Getter for .scrollX
    *
    */
    private function _getScrollX () : Float {
        return this.box.left;
    }//function _getScrollX()


    /**
    * Setter for .scrollY
    *
    */
    private function _setScrollY (y:Float) : Float {
        if( y > 0 ) y = 0;
        if( y + this.box._height < this._height ) y = this._height - this.box._height;
        return this.box.top = y;
    }//function _setScrollY()


    /**
    * Getter for .scrollY
    *
    */
    private function _getScrollY () : Float {
        return this.box.top;
    }//function _getScrollY()


    /**
    * Refresh container too
    *
    */
    override public function refresh () : Void {
        this.box.refresh();
        super.refresh();

        //mouse wheel scrolling
        if( this.wheelScroll ){
            this.addUniqueListener(MouseEvent.MOUSE_WHEEL, this._wheelScroll);
        }else{
            this.removeEventListener(MouseEvent.MOUSE_WHEEL, this._wheelScroll);
        }

        //dragging
        if( this.dragScroll ){
            this.addUniqueListener(MouseEvent.MOUSE_DOWN, this._dragScroll);
        }else{
            this.removeEventListener(MouseEvent.MOUSE_DOWN, this._dragScroll);
        }
    }//function refresh()


    /**
    * Start scroll by drag
    *
    */
    private function _dragScroll (e:MouseEvent) : Void {
        var dx : Float = this.mouseX - this.scrollX;
        var dy : Float = this.mouseY - this.scrollY;
        var lastX  : Float = this.mouseX;
        var lastY  : Float = this.mouseY;
        var lastDx : Float = 0;
        var lastDy : Float = 0;

        //stop previous scrolling
        this.tweenStop();

        var fn = function(e:Event) : Void {
            if( this.hScroll ) this.scrollX = this.mouseX - dx;
            if( this.vScroll ) this.scrollY = this.mouseY - dy;

            lastDx = this.mouseX - lastX;
            lastDy = this.mouseY - lastY;

            lastX = this.mouseX;
            lastY = this.mouseY;
        }

        //follow pointer
        this.addUniqueListener(Event.ENTER_FRAME, fn);

        var fnStop : MouseEvent->Void = null;
        fnStop = function(e:MouseEvent) : Void {
            this.removeEventListener(Event.ENTER_FRAME, fn);
            Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, fnStop);

            //go-go!
            if( this.vScroll && this.hScroll ){
                this.tween(2, {scrollX:this.scrollX + lastDx * 20, scrollY:this.scrollY + lastDy * 20}, 'Expo.easeOut');
            }else if( this.vScroll ){
                this.tween(2, {scrollY:this.scrollY + lastDy * 20}, 'Expo.easeOut');
            }else{
                this.tween(2, {scrollX:this.scrollX + lastDx * 20}, 'Expo.easeOut');
            }
        }

        //stop scrolling
        Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, fnStop);
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, fnStop);
    }//function _dragScroll()


    /**
    * Scroll by wheel
    *
    */
    private function _wheelScroll (e:MouseEvent) : Void {
        //scroll horizontally
        if(
            this.hScroll
            && (
                (e.altKey && this.hScrollKey == 'alt')
                || (e.shiftKey && this.hScrollKey == 'shift')
                || (e.ctrlKey && this.hScrollKey == 'ctrl')
            )
        ){
            this.tweenStop();
            this.scrollX += e.delta * 10;
        //scroll vertically
        }else if( this.vScroll ){
            this.tweenStop();
            this.scrollY += e.delta * 10;
        }
    }//function _wheelScroll()


}//class Scroll