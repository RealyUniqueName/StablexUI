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
    public var paddingLeft   : Float = 0;
    public var paddingRight  : Float = 0;
    public var paddingTop    : Float = 0;
    public var paddingBottom : Float = 0;
    //Distance between children
    public var childPadding : Float = 0;
    /**
    * This should be like 'left,top' or 'bottom' or 'center,middle' etc.
    * Vertical: left, right, center. Horizontal: top, bottom, middle.
    */
    public var align : String = 'center,middle';


    /**
    * Setter for padding
    *
    */
    private function _setPadding (p:Float) : Float {
        this.paddingTop = this.paddingBottom = this.paddingRight = this.paddingLeft = p;
        return p;
    }//function _setPadding()


    /**
    * Refresh widgets. Realigns children
    *
    */
    override public function refresh() : Void {
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