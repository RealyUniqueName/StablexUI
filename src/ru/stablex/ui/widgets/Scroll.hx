package ru.stablex.ui.widgets;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TouchEvent;
import flash.Lib;
import ru.stablex.ui.events.ScrollEvent;
import ru.stablex.ui.events.WidgetEvent;



/**
* Scroll container.
* First child of this widget will be used as container for scrolled content.
* When scrolling is about to start, <type>ru.stablex.ui.events.ScrollEvent</type>.BEFORE_SCROLL is dispatched.
* Handle this event to cancel scrolling if needed.
*/
class Scroll extends Widget{

    /**
    * :TODO:
    * On cpp application segfaults if scrolling is performed while resizing scroll widget
    */

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
    public var box (get_box,never) : Widget;

    //determine how far mouse wheel deltas will scroll the content
    public var wheelScrollSpeed : Float = 10;

    //scroll position along x axes
    public var scrollX (get_scrollX,set_scrollX) : Float;
    //scroll position along y axes
    public var scrollY (get_scrollY,set_scrollY) : Float;
    //vertical scroll bar
    public var vBar (default,set_vBar) : Slider;
    //horizontal scroll bar
    public var hBar (default,set_hBar) : Slider;
    /**
    * For neko and html5 targets onMouseDown dispatched several times (depends on display list depth)
    * We want to process it only once
    */
    private var _processingDrag : Bool = false;


    /**
    * Constructor
    *  `.overflow` = false by default
    */
    public function new () : Void {
        super();
        this.overflow = false;

        this.vBar = UIBuilder.create(Slider, {
            vertical : true,
            right    : 0,
            top      : 0,
            heightPt : 100,
            w        : 10,
            slider   : {widthPt : 100}
        });
        this.hBar = UIBuilder.create(Slider, {
            vertical : false,
            bottom   : 0,
            left     : 0,
            widthPt  : 100,
            h        : 10,
            slider   : {heightPt : 100}
        });

        this.addUniqueListener(MouseEvent.MOUSE_WHEEL, this._beforeScroll);
        this.addUniqueListener(MouseEvent.MOUSE_DOWN, this._beforeScroll);
    }//function new()


    /**
    * Getter for `.box`
    *
    */
    @:noCompletion private function get_box () : Widget {
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
    }//function get_box()


    /**
    * Setter for .scrollX
    *
    */
    @:noCompletion private function set_scrollX (x:Float) : Float {
        if( this.box._width > this._width ){
            if( x > 0 ) x = 0;
            if( x + this.box._width < this._width ) x = this._width - this.box._width;

            this.box.left = x;

            if( this.hBar != null && Math.abs(this.hBar.value + x) >= 1 ) this.hBar.value = -x;
        }

        return x;
    }//function set_scrollX()


    /**
    * Getter for .scrollX
    *
    */
    @:noCompletion private function get_scrollX () : Float {
        return this.box.left;
    }//function get_scrollX()


    /**
    * Setter for .scrollY
    *
    */
    @:noCompletion private function set_scrollY (y:Float) : Float {
        if( this.box._height > this._height ){
            if( y > 0 ) y = 0;
            if( y + this.box._height < this._height ) y = this._height - this.box._height;

            this.box.top = y;

            if( this.vBar != null && Math.abs(this.vBar.value - y) >= 1 ) this.vBar.value = y;
        }

        return y;
    }//function set_scrollY()


    /**
    * Getter for .scrollY
    *
    */
    @:noCompletion private function get_scrollY () : Float {
        return this.box.top;
    }//function get_scrollY()


    /**
    * Setter for '.vBar'
    *
    */
    @:noCompletion private function set_vBar(bar:Slider) : Slider {
        if( bar == null && this.vBar != null ){
            this.vBar.free();
        }
        return this.vBar = bar;
    }//function set_vBar()


    /**
    * Setter for '.hBar'
    *
    */
    @:noCompletion private function set_hBar(bar:Slider) : Slider {
        if( bar == null && this.hBar != null ){
            this.hBar.free();
        }
        return this.hBar = bar;
    }//function set_hBar()


    /**
    * Refresh container too
    *
    */
    override public function refresh () : Void {
        this.box.refresh();
        super.refresh();

        //vertical bar
        if( this.vBar != null ){
            this.addChildAt(this.vBar, 1);
            this.vBar.min = (this.h - this.box.h < 0 ? this.h - this.box.h : 0);
            this.vBar.max = 0;
            var k : Float = this.vBar.h / this.box.h;
            if( k > 1 ) k = 1;
            this.vBar.slider.h = this.h * k;
            this.vBar.refresh();
            this.vBar.addUniqueListener(WidgetEvent.CHANGE, this._onVBarChange);
        }
        //verticalhorizontal bar
        if( this.hBar != null ){
            this.addChildAt(this.hBar, 1);
            this.hBar.max = -(this.w - this.box.w < 0 ? this.w - this.box.w : 0);
            this.hBar.min = 0;
            var k : Float = this.hBar.w / this.box.w;
            if( k > 1 ) k = 1;
            this.hBar.slider.w = this.hBar.w * k;
            this.hBar.refresh();
            this.hBar.addUniqueListener(WidgetEvent.CHANGE, this._onHBarChange);
        }
    }//function refresh()


    /**
    * On `.vBar` value change
    *
    */
    private function _onVBarChange (e:WidgetEvent) : Void {
        if( Math.abs(this.scrollY - this.vBar.value) >= 1 ){
            this.tweenStop();
            this.scrollY = this.vBar.value;
        }
    }//function _onVBarChange()


    /**
    * On `.hBar` value change
    *
    */
    private function _onHBarChange (e:WidgetEvent) : Void {
        if( Math.abs(this.scrollX + this.hBar.value) >= 1 ){
            this.tweenStop();
            this.scrollX = -this.hBar.value;
        }
    }//function _onHBarChange()


    /**
    * When user want to scroll, dispatch ScrollEvent.BEFORE_SCROLL
    *
    */
    private function _beforeScroll(e:MouseEvent) : Void {
        //if clicked on bars
        if(
            e.target == this.vBar || e.target == this.hBar
            || (this.vBar != null && e.target == this.vBar.slider)
            || (this.hBar != null && e.target == this.hBar.slider)
        ) return;

        this.addUniqueListener(ScrollEvent.BEFORE_SCROLL, this._startScroll);

        var e : ScrollEvent = new ScrollEvent(ScrollEvent.BEFORE_SCROLL, e);
        this.dispatchEvent(e);
    }//function _beforeScroll()


    /**
    * Start scrolling
    *
    */
    private function _startScroll(e:ScrollEvent) : Void {
        this.removeEventListener(ScrollEvent.BEFORE_SCROLL, this._startScroll);

        //scrolling cancaled
        if( e.canceled ) return;

        //scrolling by drag
        if( e.srcEvent.type == MouseEvent.MOUSE_DOWN && this.dragScroll ){
            this._dragScroll( e.srcAs(MouseEvent) );
        //scrolling by mouse wheel
        }else if( e.srcEvent.type == MouseEvent.MOUSE_WHEEL && this.wheelScroll ){
            this._wheelScroll( e.srcAs(MouseEvent) );
        }
    }//function _startScroll()


    /**
    * Start scroll by drag
    *
    */
    private function _dragScroll (e:MouseEvent) : Void {

        if( this._processingDrag ) return;
        this._processingDrag = true;

        var dx       : Float = this.mouseX - this.scrollX;
        var dy       : Float = this.mouseY - this.scrollY;
        var lastX    : Float = this.mouseX;
        var lastY    : Float = this.mouseY;
        var lastDx   : Float = 0;
        var lastDy   : Float = 0;
        var startX   : Float = this.mouseX;
        var startY   : Float = this.mouseY;
        var scrolled : Bool = false;
        //allowed scroll directions
        var vScroll : Bool = (this.vScroll && this.box.h > this.h);
        var hScroll : Bool = (this.hScroll && this.box.w > this.w);

        //stop previous scrolling
        this.tweenStop(["scrollX", "scrollY"], false, true);

        //Looks like html5 target does not respect .mouseChildren
        #if html5
            var blocker : Sprite = new Sprite();
            blocker.graphics.beginFill(0x000000, 0);
            blocker.graphics.drawRect(0, 0, this.w, this.h);
            blocker.graphics.endFill();
        #end

        //follow mouse pointer
        var fn = function(e:Event) : Void {
            if( scrolled ){
                if( hScroll ) this.scrollX = this.mouseX - dx;
                if( vScroll ) this.scrollY = this.mouseY - dy;

            //if user realy wants to scroll instead of interacting with content,
            //disable processing mouse events by children
            }else if(
                (hScroll && !scrolled && Math.abs(this.mouseX - startX) >= 5)
                || (vScroll && !scrolled && Math.abs(this.mouseY - startY) >= 5)
            ){
                #if html5 this.addChild(blocker); #end
                scrolled = true;
                this.box.mouseEnabled = false;
                this.box.mouseChildren = false;
                this.dispatchEvent(new WidgetEvent(WidgetEvent.SCROLL_START));
            }

            lastDx = this.mouseX - lastX;
            lastDy = this.mouseY - lastY;

            lastX = this.mouseX;
            lastY = this.mouseY;
        }//fn()

        //follow pointer
        this.addUniqueListener(Event.ENTER_FRAME, fn);

        //stop following
        var fnStop : MouseEvent->Void = null;
        fnStop = function(e:MouseEvent) : Void {
            this._processingDrag = false;

            this.removeEventListener(Event.ENTER_FRAME, fn);
            Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, fnStop);

            if( scrolled ){
                var finish : Void->Void = function() : Void {
                    this.dispatchEvent(new WidgetEvent(WidgetEvent.SCROLL_STOP));
                };

                //go-go!
                if( vScroll && hScroll ){
                    this.tween(2, {scrollX:this.scrollX + lastDx * 20, scrollY:this.scrollY + lastDy * 20}, 'Expo.easeOut').onComplete(finish);
                }else if( vScroll ){
                    this.tween(2, {scrollY:this.scrollY + lastDy * 20}, 'Expo.easeOut').onComplete(finish);
                }else{
                    this.tween(2, {scrollX:this.scrollX + lastDx * 20}, 'Expo.easeOut').onComplete(finish);
                }

                #if html5 if( blocker.parent == this) this.removeChild(blocker); #end
                this.box.mouseEnabled  = true;
                this.box.mouseChildren = true;
            }
        }//fnStop()

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
            this.scrollX += e.delta * wheelScrollSpeed;

        //scroll vertically
        }else if( this.vScroll ){
            this.tweenStop();
            this.scrollY += e.delta * wheelScrollSpeed;
        }
    }//function _wheelScroll()


}//class Scroll