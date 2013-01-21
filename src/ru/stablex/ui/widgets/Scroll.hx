package ru.stablex.ui.widgets;

import nme.display.DisplayObject;
import nme.events.MouseEvent;



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
    public var scrollX (default,_setScrollX) : Float = 0;
    //scroll position along y axes
    public var scrollY (default,_setScrollY) : Float = 0;


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
        return this.scrollX = this.box.left = x;
    }//function _setScrollX()


    /**
    * Setter for .scrollY
    *
    */
    private function _setScrollY (y:Float) : Float {
        if( y > 0 ) y = 0;
        if( y + this.box._height < this._height ) y = this._height - this.box._height;
        return this.scrollY = this.box.top = y;
    }//function _setScrollY()


    /**
    * Refresh container too
    *
    */
    override public function refresh () : Void {
        this.box.refresh();
        super.refresh();

        if( this.wheelScroll ){
            this.addUniqueListener(MouseEvent.MOUSE_WHEEL, this._wheelScroll);
        }else{
            this.removeEventListener(MouseEvent.MOUSE_WHEEL, this._wheelScroll);
        }
    }//function refresh()


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
            this.scrollX += e.delta * 10;
        //scroll vertically        
        }else if( this.vScroll ){
            this.scrollY += e.delta * 10;
        }
    }//function _wheelScroll()


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