package ru.stablex.ui.widgets;

import nme.display.BitmapData;
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
    //set size depending on bitmap size, overrides any width, height, xOffset and yOffset settings
    public var autoSize (never,_setAutoSize) : Bool;
    //set width depending on bitmap width, overrides any width and xOffset settings
    public var autoWidth : Bool = true;
    //set height depending on bitmap height, overrides any height and yOffset settings
    public var autoHeight : Bool = true;
    // x offset for drawing a portion of the bitmap
    public var xOffset (default, _setXOffset) : Int = 0;
    // y offset for drawing a portion of the bitmap
    public var yOffset (default, _setYOffset) : Int = 0;


    /**
    * Setter for autoSize
    *
    */
    private function _setAutoSize (as:Bool) : Bool {
        trace("setting autosize");
        return this.autoWidth = this.autoHeight = as;
    }//function _setAutoSize()

    /**
    * Setter for autoSize
    *
    */
    private function _setXOffset (x:Int) : Int {
        return this.xOffset = x;
    }//function _setXOffset()
    
    /**
    * Setter for autoSize
    *
    */
    private function _setYOffset (y:Int) : Int {
        return this.yOffset = y;
    }//function _setYOffset()
    
    /**
    * If width is set, disable autoWidth
    *
    */
    override private function _setWidth(w:Float) : Float {
        this.autoWidth = false;
        trace("setting width: " + autoWidth);
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
        trace("setting height: " + autoHeight);
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
            if( this.autoWidth && this.autoHeight && (this._width != bmp.width || this._height != bmp.height ) ){
                this.resize(bmp.width, bmp.height);
            }else if( this.autoWidth && this._width != bmp.width ){
                this.w = bmp.width;
            }else if( this.autoHeight && this._height != bmp.height ){
                this.h = bmp.height;
            }
            
            this.xOffset = (this.autoWidth) ? 0 : this.xOffset;
            this.yOffset = (this.autoHeight) ? 0 : this.yOffset;
            
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
        trace(this.autoWidth);
        trace(this.autoHeight);
        var dest = new BitmapData(Std.int(this.w), Std.int(this.h));
        dest.copyPixels(bmp, new Rectangle(xOffset, yOffset, this.w, this.h), new Point(0,0));
        this.graphics.beginBitmapFill(dest, null, false, this.smooth);
        this.graphics.drawRect(0, 0, this.w, this.h);
        this.graphics.endFill();
    }//function _draw()



}//class Bmp