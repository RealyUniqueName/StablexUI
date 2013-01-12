package ru.stablex.ui.widgets;

import nme.display.DisplayObject;
import ru.stablex.Err;


/**
* Children of this box are aligned relative to box bounds
*/
class Box extends Panel{

    //Should we arrange children vertically (true) or horizontally (false). True by default.
    public var vertical : Bool = true;
    //Setter for padding left, right, top, bottom.
    public var padding (never,_setPadding) : Float;
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
    * Vertical: left, right, center. Horizontal: top, bottom, middle.
    */
    public var align : String = 'center,middle';
    //set size depending on content size
    public var autoSize (never,_setAutoSize) : Bool;
    //set width depending on content width
    public var autoWidth                     : Bool = true;
    //set height depending on content height
    public var autoHeight                    : Bool = true;


    /**
    * Setter for autoSize
    *
    */
    private function _setAutoSize (as:Bool) : Bool {
        return this.autoWidth = this.autoHeight = as;
    }//function _setAutoSize()


    /**
    * If width is set, disable autoWidth
    *
    */
    override private function _setWidth(w:Float) : Float {
        this.autoWidth = false;
        return super._setWidth(w);
    }//function _setWidth()


    /**
    * If width is set, disable autoWidth
    *
    */
    override private function _setWpt(wp:Float) : Float {
        this.autoWidth = false;
        return super._setWpt(wp);
    }//function _setWpt()


    /**
    * If height is set, disable autoHeight
    *
    */
    override private function _setHpt(hp:Float) : Float {
        this.autoHeight = false;
        return super._setHpt(hp);
    }//function _setHpt()


    /**
    * If height is set, disable autoHeight
    *
    */
    override function _setHeight(h:Float) : Float {
        this.autoHeight = false;
        return super._setHeight(h);
    }//function _setHeight()


    /**
    * Setter for padding
    *
    */
    private function _setPadding (p:Float) : Float {
        this.paddingTop = this.paddingBottom = this.paddingRight = this.paddingLeft = p;
        return p;
    }//function _setPadding()


    /**
    * Refresh widgets. Re-apply skin box and realigns children
    *
    */
    override public function refresh() : Void {
        if( this.autoWidth ) this._calcWidth();
        if( this.autoHeight ) this._calcHeight();

        super.refresh();
        this.alignElements();
    }//function refresh()


    /**
    * on resize refresh widget
    *
    */
    override public function onResize() : Void {
        super.onResize();
        this.alignElements();
    }//function onResize()


    /**
    * Set width based on content width
    *
    */
    private function _calcWidth () : Void {
        //if this is vertical box, set width = max child width
        if( this.vertical ){

            var w : Float = 0;
            var child : DisplayObject;

            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                if( Std.is(child, Widget) && cast(child, Widget)._width > w ){
                    w = cast(child, Widget)._width;
                }else if( child.width > w ){
                    w = child.width;
                }
            }

            this._width = w + this.paddingLeft + this.paddingRight;
        //if this is horizontal box set width = sum children width
        }else{

            var w : Float = this.paddingLeft + this.paddingRight + (this.numChildren - 1) * this.childPadding;
            var child : DisplayObject;

            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                if( Std.is(child, Widget) ){
                    w += cast(child, Widget)._width;
                }else if( child.width > w ){
                    w = child.width;
                }
            }

            this._width = w;
        }
    }//function _calcWidth()


    /**
    * Set width based on content width
    *
    */
    private function _calcHeight () : Void {
        //if this is vertical box, set height = sum children height
        if( this.vertical ){

            var h : Float = this.paddingTop + this.paddingBottom + (this.numChildren - 1) * this.childPadding;
            var child : DisplayObject;

            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                if( Std.is(child, Widget) ){
                    h += cast(child, Widget)._height;
                }else if( child.height > h ){
                    h = child.height;
                }
            }

            this._height = h;

        //if this is horizontal box set height = sum children height
        }else{

            var h : Float = 0;
            var child : DisplayObject;

            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                if( Std.is(child, Widget) && cast(child, Widget)._height > h ){
                    h = cast(child, Widget)._height;
                }else if( child.height > h ){
                    h = child.height;
                }
            }

            this._height = h + this.paddingTop + this.paddingBottom;
        }
    }//function _calcHeight()


    /**
    * Align elements according to this.align
    *
    */
    public function alignElements () : Void {
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
                default : Err.trigger('Unknown alignment: ' + align);
            }
        }
    }//function alignElements()


    /**
    * Align top
    *
    */
    private function _vAlignTop () : Void {
        //vertical box
        if( this.vertical ){
            var lastY : Float = this.paddingTop;
            var child : DisplayObject;

            for(i in 0...this.numChildren){
                child   = this.getChildAt(i);
                if( !child.visible ) continue;
                child.y = lastY;
                lastY   += (Std.is(child, Widget) ? cast(child, Widget).h : child.height) + this.childPadding;
            }

        //horizontal box
        }else{
            for(i in 0...this.numChildren){
                this.getChildAt(i).y = this.paddingTop;
            }
        }
    }//function _vAlignTop()


    /**
    * Align middle
    *
    */
    private function _vAlignMiddle () : Void {
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
                height += (Std.is(child, Widget) ? cast(child, Widget).h : child.height);
            }

            //add padding
            height += (visibleChildren - 1) * this.childPadding;

            //arrange elements
            var lastY : Float = (this.h - height) / 2;

            for(i in 0...this.numChildren){
                child   = this.getChildAt(i);
                if( !child.visible ) continue;
                child.y = lastY;
                lastY   += (Std.is(child, Widget) ? cast(child, Widget).h : child.height) + this.childPadding;
            }

        //horizontal box
        }else{
            var child : DisplayObject;
            for(i in 0...this.numChildren){
                child   = this.getChildAt(i);
                child.y = (this.h - (Std.is(child, Widget) ? cast(child, Widget).h : child.height)) / 2;
            }
        }
    }//function _vAlignMiddle()


    /**
    * Align bottom
    *
    */
    private function _vAlignBottom () : Void {
        //vertical box
        if( this.vertical ){
            var lastY : Float = this.h - this.paddingBottom;
            var child : DisplayObject;

            for(i in 0...this.numChildren){
                child   = this.getChildAt(this.numChildren - 1 - i);
                if( !child.visible ) continue;
                child.y = lastY - (Std.is(child, Widget) ? cast(child, Widget).h : child.height);
                lastY   = child.y - this.childPadding;
            }

        //horizontal box
        }else{
            var child : DisplayObject;
            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                child.y = this.h - this.paddingBottom - (Std.is(child, Widget) ? cast(child, Widget).h : child.height);
            }
        }
    }//function _vAlignBottom()


    /**
    * Align left
    *
    */
    private function _hAlignLeft () : Void {
        //vertical box
        if(this.vertical){
            for(i in 0...this.numChildren){
                this.getChildAt(i).x = this.paddingLeft;
            }

        //horizontal box
        }else{
            var lastX : Float = this.paddingLeft;
            var child : DisplayObject;

            for(i in 0...this.numChildren){
                child   = this.getChildAt(i);
                if( !child.visible ) continue;
                child.x = lastX;
                lastX   += (Std.is(child, Widget) ? cast(child, Widget).w : child.width) + this.childPadding;
            }
        }
    }//function _hAlignLeft()


    /**
    * Align right
    *
    */
    private function _hAlignRight () : Void {
        //vertical box
        if(this.vertical){
            var child : DisplayObject;
            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                child.x = this.w - this.paddingRight - (Std.is(child, Widget) ? cast(child, Widget).w : child.width);
            }

        //horizontal box
        }else{
            var lastX : Float = this.w - this.paddingRight;
            var child : DisplayObject;

            for(i in 0...this.numChildren){
                child = this.getChildAt(this.numChildren - 1 - i);
                if( !child.visible ) continue;
                child.x = lastX - (Std.is(child, Widget) ? cast(child, Widget).w : child.width);
                lastX = child.x - this.childPadding;
            }
        }
    }//function _hAlignRight()


    /**
    * Align center
    *
    */
    private function _hAlignCenter () : Void {
        //vertical box
        if(this.vertical){
            var child : DisplayObject;
            for(i in 0...this.numChildren){
                child   = this.getChildAt(i);
                child.x = (this.w - (Std.is(child, Widget) ? cast(child, Widget).w : child.width)) / 2;
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
                width += (Std.is(child, Widget) ? cast(child, Widget).w : child.width);
            }

            //add padding
            width += (visibleChildren - 1) * this.childPadding;

            //arrange elements
            var lastX : Float = (this.w - width) / 2;

            for(i in 0...this.numChildren){
                child   = this.getChildAt(i);
                if( !child.visible ) continue;
                child.x = lastX;
                lastX   += (Std.is(child, Widget) ? cast(child, Widget).w : child.width) + this.childPadding;
            }
        }
    }//function _hAlignCenter()
}//class Box