package ru.stablex.ui.widgets;

import flash.display.DisplayObject;
import ru.stablex.Err;
import ru.stablex.ui.events.WidgetEvent;
import ru.stablex.ui.misc.SizeTools;
import ru.stablex.ui.UIBuilder;


/**
* Children of this box are aligned relative to box bounds
*/
class Box extends Widget{

    //Should we arrange children vertically (true) or horizontally (false). True by default.
    public var vertical : Bool = true;
    //Setter for padding left, right, top, bottom.
    public var padding (never,set) : Float;
    //padding left
    public var paddingLeft   : Float = 0;
    //padding right
    public var paddingRight  : Float = 0;
    //padding top
    public var paddingTop    : Float = 0;
    //padding bottom
    public var paddingBottom : Float = 0;
    //Distance between children
    public var childPadding : Float = 0;
    /**
    * This should be like 'left,top' or 'bottom' or 'center,middle' etc.
    * Horizontal: left, right, center. Vertical: top, bottom, middle.
    * Use any other value to cancel alignment
    */
    public var align : String = 'center,middle';
    //set size depending on content size
    public var autoSize (never,set) : Bool;
    //set width depending on content width
    public var autoWidth                     : Bool = true;
    //set height depending on content height
    public var autoHeight                    : Bool = true;
    //if this is set to true, all children will be set to equal size to fit box size
    public var unifyChildren : Bool = false;
    /** should children' positions be convertent to int numbers? Use this to workaround problem of blurry images */
    public var intPositions : Bool = false;
    /** indicates if currently processing child resizing event */
    private var _processingChildResize : Bool = false;
    /** dirty hack for new openfl */
    #if ((openfl >= '2.0.0') && (openfl < '3.0.0') && (!flash))
        private var lastUnifyFrame    : Int = -1;
        private var lastUnifyChildren : Int = -1;
        private var lastUnifyCount    : Int = 0;
    #end

/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/

    /**
    * get object width
    *
    */
    @:noCompletion private function _objWidth (obj:DisplayObject) : Float {
        return SizeTools.width(obj);
    }//function _objWidth()


    /**
    * get object height
    *
    */
    @:noCompletion private function _objHeight (obj:DisplayObject) : Float {
        return SizeTools.height(obj);
    }//function _objHeight()


    /**
    * Set object x
    *
    */
    @:noCompletion private function _setObjX (obj:DisplayObject, x:Float) : Void {
        SizeTools.setX(obj, x);

        if( this.intPositions ){
            obj.x = Std.int(obj.x);
        }
    }//function _setObjX()


    /**
    * Set object y
    *
    */
    @:noCompletion private function _setObjY (obj:DisplayObject, y:Float) : Void {
        SizeTools.setY(obj, y);

        if( this.intPositions ){
            obj.y = Std.int(obj.y);
        }
    }//function _setObjY()


/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/


    /**
    * Refresh widgets. Re-apply skin box and realigns children
    *
    */
    override public function refresh() : Void {
        if( this.autoWidth || this.autoHeight ){
            var w : Float = (this.autoWidth ? this._calcWidth() : this._width);
            var h : Float = (this.autoHeight ? this._calcHeight() : this._height);

            if( this._width != w || this._height != h ){
                this.resize(w, h, true);
            }
        }//if( autoSize )

        super.refresh();

        if( this.layout == null ){
            this.alignElements();
        }
    }//function refresh()


    /**
    * Set width based on content width
    *
    */
    @:noCompletion private function _calcWidth () : Float {
        //if this is vertical box, set width = max child width
        if( this.vertical ){

            var w      : Float = 0;
            var child  : DisplayObject;
            var childW : Float = 0;

            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                if( child.visible ){
                    childW = this._objWidth(child);
                    if( childW > w ){
                        w = childW;
                    }
                }
            }

            return w + this.paddingLeft + this.paddingRight;
        //if this is horizontal box set width = sum children width
        }else{
            var w : Float = this.paddingLeft + this.paddingRight;
            var child : DisplayObject;
            var visibleChildren : Int = 0;

            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                if( child.visible ){
                    w += this._objWidth(child);
                    visibleChildren ++;
                }
            }

            return w + (visibleChildren - 1) * this.childPadding;
        }
    }//function _calcWidth()


    /**
    * Set height based on content height
    *
    */
    @:noCompletion private function _calcHeight () : Float {
        //if this is vertical box, set height = sum child height
        if( this.vertical ){

            var h : Float = this.paddingTop + this.paddingBottom;
            var child : DisplayObject;
            var visibleChildren : Int = 0;

            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                if( child.visible ){
                    h += this._objHeight(child);
                    visibleChildren ++;
                }
            }

            return h + (visibleChildren - 1) * this.childPadding;

        //if this is horizontal box set height = max child height
        }else{

            var h      : Float = 0;
            var childH : Float = 0;
            var child  : DisplayObject;

            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                if( child.visible ){
                    childH = this._objHeight(child);
                    if( childH > h ){
                        h = childH;
                    }
                }
            }

            return h + this.paddingTop + this.paddingBottom;
        }
    }//function _calcHeight()


    /**
    * Set widget size based on % of parent's size (if width or height is defined in %)
    *
    */
    override private function _resizeWithPercent(parent : Widget) {
        var newWidth  = (
            this._widthUsePercent
                ? parent.contentWidth * this._widthPercent / 100
                : this._width
        );
        var newHeight = (
            this._heightUsePercent
                ? parent.contentHeight * this._heightPercent / 100
                : this._height
        );

        if (this.minWidthByContent) {
            newWidth = Math.max(newWidth, this._calcWidth());
        }
        if (this.minHeightByContent) {
            newHeight = Math.max(newHeight, this._calcHeight());
        }

        this.resize(newWidth, newHeight, true);
    }//function _resizeWithPercent


    /**
    * Align elements according to this.align
    *
    */
    public function alignElements () : Void {
        if( this.unifyChildren ){
            this._unifyChildren();
        }

        //если нет дочерних элементов
        if( this.numChildren == 0 ) return;

        var alignments : Array<String> = this.align.split(',');

        //выравниваем
        for(align in alignments){
            switch(align){
                case 'top'    : this._vAlignTop();
                case 'middle' : this._vAlignMiddle();
                case 'bottom' : this._vAlignBottom();
                case 'left'   : this._hAlignLeft();
                case 'center' : this._hAlignCenter();
                case 'right'  : this._hAlignRight();
            }
        }
    }//function alignElements()


    /**
    * Set all children equal size
    *
    */
    @:noCompletion private function _unifyChildren () : Void {
        #if ((openfl >= '2.0.0') && (openfl < '3.0.0') && (!flash))
            if (UIBuilder.frameTime == this.lastUnifyFrame && this.numChildren == this.lastUnifyChildren && this.lastUnifyCount > 1) {
                return;
            }
            if (this.lastUnifyFrame != UIBuilder.frameTime || this.numChildren != this.lastUnifyChildren) {
                this.lastUnifyCount = 1;
            } else {
                this.lastUnifyCount ++;
            }
            this.lastUnifyFrame    = UIBuilder.frameTime;
            this.lastUnifyChildren = this.numChildren;
        #end

        var visibleChildren : Int = 0;
        for(i in 0...this.numChildren){
            if( this.getChildAt(i).visible ){
                visibleChildren ++;
            }
        }

        var child : DisplayObject;

        //if this is vertical box
        if( this.vertical ){
            var childWidth  : Float = this._width - this.paddingLeft - this.paddingRight;
            var childHeight : Float = (this._height - this.paddingTop - this.paddingBottom - this.childPadding * (visibleChildren - 1)) / visibleChildren;

            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                if( Std.is(child, Widget) ){
                    cast(child, Widget).removeEventListener(WidgetEvent.RESIZE, this._onChildResize);
                    cast(child, Widget).resize(childWidth, childHeight);
                    cast(child, Widget).addUniqueListener(WidgetEvent.RESIZE, this._onChildResize);
                }
            }

        //if this is horizontal box
        }else{
            var childWidth  : Float = (this._width - this.paddingLeft - this.paddingRight - this.childPadding * (visibleChildren - 1)) / visibleChildren;
            var childHeight : Float = this._height - this.paddingTop - this.paddingBottom;

            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                if( Std.is(child, Widget) ){
                    cast(child, Widget).removeEventListener(WidgetEvent.RESIZE, this._onChildResize);
                    cast(child, Widget).resize(childWidth, childHeight);
                    cast(child, Widget).addUniqueListener(WidgetEvent.RESIZE, this._onChildResize);
                }
            }
        }
    }//function _unifyChildren()


    /**
    * Align top
    *
    */
    @:noCompletion private function _vAlignTop () : Void {
        //vertical box
        if( this.vertical ){
            var lastY : Float = this.paddingTop;
            var child : DisplayObject;

            for(i in 0...this.numChildren){
                child   = this.getChildAt(i);
                if( !child.visible ) continue;
                this._setObjY(child, lastY);
                lastY += this._objHeight(child) + this.childPadding;
            }

        //horizontal box
        }else{
            for(i in 0...this.numChildren){
                this._setObjY(this.getChildAt(i), this.paddingTop);
            }
        }
    }//function _vAlignTop()


    /**
    * Align middle
    *
    */
    @:noCompletion private function _vAlignMiddle () : Void {
        //vertical box
        if(this.vertical){
            //count sum children height
            var height          : Float = 0;
            var child           : DisplayObject;
            var visibleChildren : Int = 0;

            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                if( !child.visible ) continue;
                visibleChildren ++;
                height += this._objHeight(child);
            }

            //add padding
            height += (visibleChildren - 1) * this.childPadding;

            //arrange elements
            var lastY : Float = (this.h - paddingTop - paddingBottom - height) / 2 + paddingTop;

            for(i in 0...this.numChildren){
                child   = this.getChildAt(i);
                if( !child.visible ) continue;
                this._setObjY(child, lastY);
                lastY   += this._objHeight(child) + this.childPadding;
            }

        //horizontal box
        }else{
            var child : DisplayObject;
            for(i in 0...this.numChildren){
                child   = this.getChildAt(i);
                this._setObjY(child, (this.h - paddingTop - paddingBottom - this._objHeight(child)) / 2 + paddingTop);
            }
        }
    }//function _vAlignMiddle()


    /**
    * Align bottom
    *
    */
    @:noCompletion private function _vAlignBottom () : Void {
        //vertical box
        if( this.vertical ){
            var lastY : Float = this.h - this.paddingBottom;
            var child : DisplayObject;

            for(i in 0...this.numChildren){
                child   = this.getChildAt(this.numChildren - 1 - i);
                if( !child.visible ) continue;
                this._setObjY(child, lastY - this._objHeight(child));
                lastY   = child.y - this.childPadding #if html5 - (Std.is(child, flash.text.TextField) ? 2 : 0) #end;
            }

        //horizontal box
        }else{
            var child : DisplayObject;
            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                this._setObjY(child, this.h - this.paddingBottom - this._objHeight(child));
            }
        }
    }//function _vAlignBottom()


    /**
    * Align left
    *
    */
    @:noCompletion private function _hAlignLeft () : Void {
        //vertical box
        if(this.vertical){
            for(i in 0...this.numChildren){
                this._setObjX(this.getChildAt(i), this.paddingLeft);
            }

        //horizontal box
        }else{
            var lastX : Float = this.paddingLeft;
            var child : DisplayObject;

            for(i in 0...this.numChildren){
                child   = this.getChildAt(i);
                if( !child.visible ) continue;
                this._setObjX(child, lastX);
                lastX   += this._objWidth(child) + this.childPadding;
            }
        }
    }//function _hAlignLeft()


    /**
    * Align right
    *
    */
    @:noCompletion private function _hAlignRight () : Void {
        //vertical box
        if(this.vertical){
            var child : DisplayObject;
            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                this._setObjX(child, this.w - this.paddingRight - this._objWidth(child));
            }

        //horizontal box
        }else{
            var lastX : Float = this.w - this.paddingRight;
            var child : DisplayObject;

            for(i in 0...this.numChildren){
                child = this.getChildAt(this.numChildren - 1 - i);
                if( !child.visible ) continue;
                this._setObjX(child, lastX - this._objWidth(child));
                lastX = child.x #if html5 - (Std.is(child, flash.text.TextField) ? 2 : 0) #end - this.childPadding;
            }
        }
    }//function _hAlignRight()


    /**
    * Align center
    *
    */
    @:noCompletion private function _hAlignCenter () : Void {
        //vertical box
        if(this.vertical){
            var child : DisplayObject;
            for(i in 0...this.numChildren){
                child   = this.getChildAt(i);
                this._setObjX(child, (this.w - paddingLeft - paddingRight - this._objWidth(child)) / 2 + paddingLeft);
            }

        //horizontal box
        }else{
            //sum children width
            var child           : DisplayObject;
            var width           : Float = 0;
            var visibleChildren : Int = 0;

            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                if( !child.visible ) continue;
                visibleChildren ++;
                width += this._objWidth(child);
            }

            //add padding
            width += (visibleChildren - 1) * this.childPadding;

            //arrange elements
            var lastX : Float = (this.w -paddingLeft - paddingRight - width) / 2 + paddingLeft;

            for(i in 0...this.numChildren){
                child   = this.getChildAt(i);
                if( !child.visible ) continue;
                this._setObjX(child, lastX);
                lastX += this._objWidth(child) + this.childPadding;
            }
        }
    }//function _hAlignCenter()


    /**
    * Add child
    *
    */
    override public function addChild (child:DisplayObject) : DisplayObject {
        super.addChild(child);
        if( Std.is(child, Widget) ){
            cast(child, Widget).addUniqueListener(WidgetEvent.RESIZE, this._onChildResize);
            this._onChildResize();
        }
        return child;
    }//function addChild()


    /**
    * Add child at specified index
    *
    */
    override public function addChildAt (child:DisplayObject, idx:Int) : DisplayObject {
        super.addChildAt(child, idx);
        if( Std.is(child, Widget) ){
            cast(child, Widget).addUniqueListener(WidgetEvent.RESIZE, this._onChildResize);
            this._onChildResize();
        }
        return child;
    }//function addChildAt()


    /**
    * Remove child
    *
    */
    override public function removeChild (child:DisplayObject) : DisplayObject {
        super.removeChild(child);
        child.removeEventListener(WidgetEvent.RESIZE, this._onChildResize);
        if( !this.destroyed ){
            this._onChildResize();
        }
        return child;
    }//function removeChild()


    /**
    * Remove child at specified index
    *
    */
    override public function removeChildAt (idx:Int) : DisplayObject {
        var child : DisplayObject = super.removeChildAt(idx);
        child.removeEventListener(WidgetEvent.RESIZE, this._onChildResize);
        if( !this.destroyed ){
            this._onChildResize();
        }
        return child;
    }//function removeChild()


    /**
    * Handle child resizing
    *
    */
    @:noCompletion private function _onChildResize (e:WidgetEvent = null) : Void {
        if (_processingChildResize) return;
        _processingChildResize = true;

        if( this.created ){
            if( this.autoWidth || this.autoHeight ){
                if( e != null ){
                    var child : Widget = (Std.is(e.currentTarget, Widget) ? cast(e.currentTarget, Widget) : null);
                    if(
                        child != null && child.visible != false
                        && !(this.autoWidth && child._widthUsePercent)
                        && !(this.autoHeight && child._heightUsePercent)
                    ){
                        this.refresh();
                    }
                }else{
                    this.refresh();
                }
            }else{
                if (this.layout == null) {
                    this.alignElements();
                } else {
                    this.applyLayout();
                }
            }
        }

        _processingChildResize = false;
    }//function _onChildResize()


/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

    /**
    * Get the height of the content
    *
    */
    @:noCompletion override private function get_contentHeight() : Float {
      return h - paddingTop - paddingBottom;
    }//function get_content Height


    /**
    * Get the width of the content
    *
    */
    @:noCompletion override private function get_contentWidth() : Float {
      return w - paddingLeft - paddingRight;
    }//function get_contentWidth()


    /**
    * Setter for autoSize
    *
    */
    @:noCompletion private function set_autoSize (as:Bool) : Bool {
        return this.autoWidth = this.autoHeight = as;
    }//function set_autoSize()


    /**
    * If width is set, disable autoWidth
    *
    */
    @:noCompletion override private function set_w(w:Float) : Float {
        this.autoWidth = false;
        return super.set_w(w);
    }//function set_w()


    /**
    * If width is set, disable autoWidth
    *
    */
    @:noCompletion override private function set_widthPt(wp:Float) : Float {
        this.autoWidth = false;
        return super.set_widthPt(wp);
    }//function set_widthPt()


    /**
    * If height is set, disable autoHeight
    *
    */
    @:noCompletion override private function set_heightPt(hp:Float) : Float {
        this.autoHeight = false;
        return super.set_heightPt(hp);
    }//function set_heightPt()


    /**
    * If height is set, disable autoHeight
    *
    */
    override function set_h(h:Float) : Float {
        this.autoHeight = false;
        return super.set_h(h);
    }//function set_h()


    /**
    * Setter for padding
    *
    */
    @:noCompletion private function set_padding (p:Float) : Float {
        this.paddingTop = this.paddingBottom = this.paddingRight = this.paddingLeft = p;
        return p;
    }//function set_padding()

}//class Box
