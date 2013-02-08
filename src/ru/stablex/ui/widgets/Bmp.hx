package ru.stablex.ui.widgets;

import nme.display.BitmapData;
import nme.geom.Matrix;
import nme.geom.Rectangle;
import nme.geom.Point;
import ru.stablex.Err;


/**
* Simple Bitmap. Bitmap is drawn using .graphics.beginBitmapFill()
*/

class Bmp extends Widget{
    //Asset ID or path to bitmap
    public var src : String;
    //Should we use smoothing?
    public var smooth : Bool = true;
    //set size depending on bitmap size
    public var autoSize (never,_setAutoSize) : Bool;
    //set width depending on bitmap width
    public var autoWidth : Bool = true;
    //set height depending on bitmap height
    public var autoHeight : Bool = true;
    /**
    * If you want to draw just a portion of the bitmap. Specify top/left corner of
    * desired source rectangle by `.xOffset` and `.yOffset` and widht/height for
    * that rectangle will be taken from `.w` and `.h` of this widget. If `.autoSize` is true,
    * width and height will be taken from `.xOffset` and `.yOffset` to bitmap right border
    * and bottom border respectively
    */
    public var xOffset (default, _setXOffset) : Int = 0;
    // y offset for drawing a portion of the bitmap
    public var yOffset (default, _setYOffset) : Int = 0;
    /**
    * When `.xOffset` or `.yOffset` is set, this property is changed to true.
    * To draw full image on next refresh set this property to false again.
    */
    public var drawPortion : Bool = false;


    /**
    * Setter for autoSize
    *
    */
    private function _setAutoSize (as:Bool) : Bool {
        return this.autoWidth = this.autoHeight = as;
    }//function _setAutoSize()

    /**
    * Setter for autoSize
    *
    */
    private function _setXOffset (x:Int) : Int {
        this.drawPortion = true;
        return this.xOffset = (x >= 0 ? x : 0);
    }//function _setXOffset()

    /**
    * Setter for autoSize
    *
    */
    private function _setYOffset (y:Int) : Int {
        this.drawPortion = true;
        return this.yOffset = (y >= 0 ? y : 0);
    }//function _setYOffset()

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
    * Refresh widget. Draw bitmap on this.graphics
    *
    * @throw <type>String</type> if asset for bitmap was not found
    */
    override public function refresh() : Void {
        if( this.src != null ){
            var bmp : BitmapData = Assets.getBitmapData(this.src);
            if( bmp == null ){
                Err.trigger('Bitmap not found: ' + this.src);
            }

            //handle auto size
            if(
                this.autoWidth && this.autoHeight
                && (
                    this._width != (this.drawPortion ? bmp.width - this.xOffset : bmp.width)
                    || this._height != (this.drawPortion ? bmp.height - this.yOffset : bmp.height)
                )
            ){
                this.resize(bmp.width, bmp.height);
            }else if( this.autoWidth && this._width != (this.drawPortion ? bmp.width - this.xOffset : bmp.width) ){
                this.w = (this.drawPortion ? bmp.width - this.xOffset : bmp.width);
            }else if( this.autoHeight && this._height != (this.drawPortion ? bmp.height - this.yOffset : bmp.height) ){
                this.h = (this.drawPortion ? bmp.height - this.yOffset : bmp.height);
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
                    ? bmp.height
                    : (this._height > bmp.height - this.yOffset ? bmp.height - this.yOffset : Std.int(this._height))
            );

            //draw zero?
            if( width <= 0 || height <= 0 ){
                return;
            }else{

                var mx : Matrix = new Matrix();
                #if !html5
                    mx.translate(-this.xOffset, -this.yOffset);
                #else
                    var dest = new BitmapData(Std.int(width), Std.int(height));
                    dest.copyPixels(bmp, new Rectangle(this.xOffset, this.yOffset, width, height), new Point(0, 0));
                    bmp = dest;
                #end

                this.graphics.beginBitmapFill(bmp, mx, false, this.smooth);
                this.graphics.drawRect(0, 0, width, height);
                this.graphics.endFill();
            }

        //draw full image
        }else{
            this.graphics.beginBitmapFill(bmp, null, false, this.smooth);
            this.graphics.drawRect(0, 0, bmp.width, bmp.height);
            this.graphics.endFill();
        }
    }//function _draw()



}//class Bmp