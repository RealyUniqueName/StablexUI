package ru.stablex.ui.widgets;

import nme.display.DisplayObject;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.Lib;



/**
* Scroll container.
* ...IN PROGRESS...
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
    //container for content. Content is scrolled by moving this container
    public var box : Box;

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
        this.box = cast super.addChild( UIBuilder.create(Box) );
        this.box.name = 'scrollContainer';
    }//function new()


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
                this.tween(2, {scrollX:this.scrollX + lastDx * 20, scrollY:this.scrollY + lastDy * 20}, 'Quint.easeOut');
            }else if( this.vScroll ){
                this.tween(2, {scrollY:this.scrollY + lastDy * 20}, 'Quint.easeOut');
            }else{
                this.tween(2, {scrollX:this.scrollX + lastDx * 20}, 'Quint.easeOut');
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


    /**
    * Destroy widget
    *
    */
    override public function free(r:Bool = true) : Void {
        if( r ){
            super.removeChild(this.box);
            this.box.free(r);
        }else{
            super.removeChild(this.box);
        }
        super.free(r);
    }//function free()


    /**
    * add child to display list. Adds to `.box` display list
    *
    */
    override public function addChild (child:DisplayObject) : DisplayObject {
        return this.box.addChild(child);
    }//function addChild()


    /**
    * Add child to display list at specified index. Adds to `.box` display list
    *
    */
    override public function addChildAt (child:DisplayObject, idx:Int) : DisplayObject {
        return this.box.addChildAt(child, idx);
    }//function addChildAt()


    /**
    * Remove child from display list. Removes from `.box` display list
    *
    */
    override public function removeChild (child:DisplayObject) : DisplayObject {
        return this.box.removeChild(child);
    }//function removeChild()


    /**
    * Remove child from display list at specified index. Removes from `.box` display list
    *
    */
    override public function removeChildAt (idx:Int) : DisplayObject {
        return this.box.removeChildAt(idx);
    }//function removeChildAt()


    /**
    * Set child index.
    *
    */
    override public function setChildIndex (child:DisplayObject, idx:Int) : Void {
        this.box.setChildIndex(child, idx);
    }//function setChildIndex()


    /**
    * Swap children in display list
    *
    */
    override public function swapChildren (child1:DisplayObject, child2:DisplayObject) : Void {
        this.box.swapChildren(child1, child2);
    }//function swapChildren()


    /**
    * Swap children at specified indexes
    *
    */
    override public function swapChildrenAt (idx1:Int, idx2:Int) : Void {
        this.box.swapChildrenAt(idx1, idx2);
    }//function swapChildrenAt()


}//class Scroll