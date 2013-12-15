package ru.stablex.ui.widgets;

import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.geom.Point;
import ru.stablex.Err;


/**
* Simple Bitmap. Bitmap is drawn using .graphics.beginBitmapFill()
*/

class Bmp extends Widget{
    //Asset ID or path to bitmap
    public var src (get_src,set_src): String;
    @:noCompletion public var _src : String = null;
    //Should we use smoothing?
    public var smooth : Bool = true;
    /** Does image should be scaled to actual size of widget? */
    public var stretch : Bool = false;
    /** keep aspect ratio if `.stretch` is set to true? */
    public var keepAspect : Bool = false;
    //set size depending on bitmap size
    public var autoSize (never,set_autoSize) : Bool;
    //set width depending on bitmap width
    public var autoWidth : Bool = true;
    //set height depending on bitmap height
    public var autoHeight : Bool = true;
    /**
    * Use this property instead of `.src`, if you need to directly assign BitmapData instance.
    * `.bitmapData` will be set to null automatically, if you set `.src`.
    * `.src` will be set to null automatically, if you set `.bitmapData`
    */
    public var bitmapData (get_bitmapData,set_bitmapData) : BitmapData;
    @:noCompletion private var _bitmapData : BitmapData = null;
    /**
    * If you want to draw just a portion of the bitmap. Specify top/left corner of
    * desired source rectangle by `.xOffset` and `.yOffset` and widht/height for
    * that rectangle will be taken from `.w` and `.h` of this widget. If `.autoSize` is true,
    * width and height will be taken from `.xOffset` and `.yOffset` to bitmap right border
    * and bottom border respectively
    */
    public var xOffset (default, set_xOffset) : Int = 0;
    // y offset for drawing a portion of the bitmap
    public var yOffset (default, set_yOffset) : Int = 0;
    /**
    * When `.xOffset` or `.yOffset` is set, this property is changed to true.
    * To draw full image on next refresh set this property to false again.
    */
    public var drawPortion : Bool = false;

/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/

    /**
    * Apply scaling transformations to matrix
    *
    */
    static private inline function _applyScalingToMx (mx:Matrix, bmp:BitmapData, widget:Bmp) : Void {
        if( widget.stretch ){
            //keep aspect ratio
            if( widget.keepAspect ){
                var scale : Float = Math.min(
                    (widget.autoWidth ? 1 : widget.w / widget.px2dip(bmp.width)),
                    (widget.autoHeight ? 1 : widget.h / widget.px2dip(bmp.height))
                );
                mx.scale(scale, scale);
            //distort
            }else{
                mx.scale(
                    (widget.autoWidth ? 1 : widget.w / widget.px2dip(bmp.width)),
                    (widget.autoHeight ? 1 : widget.h / widget.px2dip(bmp.height))
                );
            }
        }
    }//function _applyScalingToMx()

/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/

    /**
    * Refresh widget. Draw bitmap on this.graphics
    *
    * @throw <type>String</type> if asset for bitmap was not found
    */
    override public function refresh() : Void {
        var bmp : BitmapData = this._bitmapData;

        if( bmp == null && this.src != null ){
            bmp = Assets.getBitmapData(this.src);
            if( bmp == null ){
                Err.trigger('Bitmap not found: ' + this.src);
            }
        }

        if( bmp != null ){
            //handle auto size
            if(
                this.autoWidth && this.autoHeight
                && (
                    this._width != this.dip2px(this.drawPortion ? bmp.width - this.xOffset : bmp.width)
                    || this._height != this.dip2px(this.drawPortion ? bmp.height - this.yOffset : bmp.height)
                )
            ){
                this.resize(
                    (this.drawPortion ? bmp.width - this.xOffset : bmp.width),
                    (this.drawPortion ? bmp.height - this.yOffset : bmp.height)
                );
            }else if( this.autoWidth && this._width != this.dip2px(this.drawPortion ? bmp.width - this.xOffset : bmp.width) ){
                this.w = (this.drawPortion ? bmp.width - this.xOffset : bmp.width);
                this.autoWidth = true;
            }else if( this.autoHeight && this._height != this.dip2px(this.drawPortion ? bmp.height - this.yOffset : bmp.height) ){
                this.h = (this.drawPortion ? bmp.height - this.yOffset : bmp.height);
                this.autoHeight = true;
            }

            super.refresh();
            this._draw(bmp);
        }else{
            super.refresh();
        }
    }//function refresh()



    /**
    * Draw bitmapdata specified by this.src
    *
    * @throw <type>String</type> if asset for bitmap was not found
    */
    private inline function _draw(bmp:BitmapData) : Void {
        this.graphics.clear();

        //draw just part of image
        if( this.drawPortion ){
            var width : Float = (
                this.autoWidth
                    ? bmp.width
                    : (this._width > bmp.width - this.xOffset ? bmp.width - this.xOffset : this._width)
            );

            var height : Float = (
                this.autoHeight
                    ? this.dip2px(bmp.height)
                    : (this._height > bmp.height - this.yOffset ? bmp.height - this.yOffset : this._height)
            );

            //draw zero?
            if( width <= 0 || height <= 0 ){
                return;
            }else{

                var mx : Matrix = new Matrix();
                #if !html5
                    //stretching makes no sense for drawing portion of image since image width and height is taken from this.w and this.h
                    // Bmp._applyScalingToMx(mx, bmp, this);
                    mx.translate(-this.xOffset, -this.yOffset);
                #else
                    var dest = new BitmapData(Std.int(width), Std.int(height));
                    dest.copyPixels(bmp, new Rectangle(this.xOffset, this.yOffset, width, height), new Point(0, 0));
                    bmp = dest;
                    // Bmp._applyScalingToMx(mx, bmp, this);
                #end

                mx.scale(this.dipFactor, this.dipFactor);

                this.graphics.beginBitmapFill(bmp, mx, false, this.smooth);
                this.graphics.drawRect(0, 0, this.dip2px(width), this.dip2px(height));
                this.graphics.endFill();
            }

        //draw full image
        }else{
            var mx : Matrix = new Matrix();

            if( this.stretch ){
                Bmp._applyScalingToMx(mx, bmp, this);
                this.graphics.beginBitmapFill(bmp, mx, false, this.smooth);
                this.graphics.drawRect(0, 0, bmp.width * mx.a, bmp.height * mx.d);
            }else{
                mx.scale(this.dipFactor, this.dipFactor);
                this.graphics.beginBitmapFill(bmp, mx, false, this.smooth);
                this.graphics.drawRect(0, 0, this.dip2px(bmp.width), this.dip2px(bmp.height));
            }

            this.graphics.endFill();
        }
    }//function _draw()


/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/


    /**
    * Getter src
    *
    */
    private inline function get_src() : String {
        return this._src;
    }//function get_src()


    /**
    * Setter src
    *
    */
    private inline function set_src(src:String) : String {
        if( src != null ){
            this._bitmapData = null;
        }
        return this._src = src;
    }//function set_src()


    /**
    * Getter bitmapData
    *
    */
    private inline function get_bitmapData() : BitmapData {
        return this._bitmapData;
    }//function get_bitmapData()


    /**
    * Setter bitmapData
    *
    */
    private inline function set_bitmapData(bitmapData:BitmapData) : BitmapData {
        if( bitmapData != null ){
            this._src = null;
        }
        return this._bitmapData = bitmapData;
    }//function set_bitmapData()


    /**
    * Setter for autoSize
    *
    */
    @:noCompletion private function set_autoSize (as:Bool) : Bool {
        return this.autoWidth = this.autoHeight = as;
    }//function set_autoSize()


    /**
    * Setter for autoSize
    *
    */
    @:noCompletion private function set_xOffset (x:Int) : Int {
        this.drawPortion = true;
        return this.xOffset = (x >= 0 ? x : 0);
    }//function set_xOffset()

    /**
    * Setter for autoSize
    *
    */
    @:noCompletion private function set_yOffset (y:Int) : Int {
        this.drawPortion = true;
        return this.yOffset = (y >= 0 ? y : 0);
    }//function set_yOffset()

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

}//class Bmp