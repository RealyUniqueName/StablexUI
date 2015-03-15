package ru.stablex.ui.skins;

import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import ru.stablex.Assets;
import ru.stablex.ui.widgets.Widget;



/**
* 3-slice-scaling
*
*/
class Slice3 extends Skin{
    //Asset ID or path to bitmap
    public var src (get_src,set_src): String;
    public var _src : String = null;
    /**
    * Use this property instead of `.src`, if you need to directly assign BitmapData instance.
    * `.bitmapData` will be set to null automatically, if you set `.src`.
    * `.src` will be set to null automatically, if you set `.bitmapData`
    */
    public var bitmapData (get_bitmapData,set_bitmapData) : BitmapData;
    private var _bitmapData : BitmapData = null;
    //should we use smoothing?
    public var smooth : Bool = true;
    //should we stretch skin to fit widget's height?
    public var stretch : Bool = true;

    //padding for top border
    public var paddingTop : Float = 0;
    //padding for right border
    public var paddingRight : Float = 0;
    //padding for bottom border
    public var paddingBottom : Float = 0;
    //padding for left border
    public var paddingLeft : Float = 0;
    //set equal padding for all borders
    public var padding(never,set_padding) : Float;

    /**
    * Setter for padding
    *
    */
    @:noCompletion private function set_padding (p:Float) : Float {
        this.paddingTop = this.paddingBottom = this.paddingRight = this.paddingLeft = p;
        return p;
    }//function set_padding()

    /**
    * Source rectangle for the bitmap. Not the whole bitmap, but only this part of it is used.
    * This is usefull when using e.g. spritesheets for the bitmap.
    */
    public var srcRect(get,set) : Rectangle;
    private var _srcRect : Rectangle = null;

    /**
    * Where to slice skin bitmap.
    * This array should contain zero, one or two floats.
    * If the floats are less than one they indicate a percentage of the picture where it 
    * should be cut.
    * If they are larger than or equal to one they are pixels and should be integer values.
    * Zero - 3 slice scaling (horizontal). Bitmap is divided into two equal sized bitmaps.
    *         Middle part is filled with central column of pixels.
    * One - 3 slice scaling (horizontal). Bitmap is divided into two bitmaps. Middle part
    *         is filled with column of pixels with x = specified float.
    * Two - 3 slice scaling (horizontal). Floats: left and right guidelines for slicing
    */
    public var slice : Array<Float>;


    /**
    * get BitmapData instance
    *
    */
    private inline function _getBmp () : BitmapData {
        var bmp : BitmapData = this._bitmapData;

        if( bmp == null && this.src != null ){
            bmp = Assets.getBitmapData(this.src);
            if( bmp == null ){
                Err.trigger('Bitmap not found: ' + this.src);
            }
        }else if( bmp == null ){
            Err.trigger('Bitmap is not specified');
        }

        return bmp;
    }//function _getBmp()

    /**
    * Draw skin on widget
    *
    */
    override public function draw (w:Widget) : Void {
        var bmp : BitmapData = this._getBmp();
        var srcRect : Rectangle = this.get_srcRect();

        w.graphics.clear();

        var w1 : Int = 0;
        var w2 : Int = 0;

        var drawRect = new flash.geom.Rectangle(paddingLeft, paddingTop, w.w - paddingLeft - paddingRight, w.h - paddingTop - paddingBottom);

        var scaleX : Float = (drawRect.width >= srcRect.width ? 1 : drawRect.width / srcRect.width);
        //do not draw nothing
        if( scaleX <= 0 ){
            return;
        }

        //slice two equal size parts
        if( this.slice == null || this.slice.length == 0 ){
            w1 = Std.int(srcRect.width / 2);
            w2 = w1 + 1;
        //two different size parts
        }else if( this.slice.length == 1 ){
            w1 = _sliceSize(this.slice[0], Std.int(srcRect.width));
            w2 = w1 + 1;
        //slice three parts
        }else{
            w1 = _sliceSize(this.slice[0], Std.int(srcRect.width));
            w2 = _sliceSize(this.slice[1], Std.int(srcRect.width));
        }

        var src : Rectangle = new Rectangle();
        var dst : Rectangle = new Rectangle();

        //left{
            src.x      = srcRect.x;
            src.y      = srcRect.y;
            src.width  = w1;
            src.height = srcRect.height;

            dst.x      = drawRect.x;
            dst.y      = drawRect.y;
            dst.width  = w1 * scaleX;
            dst.height = (this.stretch ? drawRect.height : srcRect.height);

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //middle{
            src.x      = srcRect.x + w1;
            src.y      = srcRect.y;
            src.width  = w2 - w1;
            src.height = srcRect.height;

            dst.x      = w1 * scaleX;
            dst.y      = 0;
            dst.width  = drawRect.width - (w1 + (srcRect.width - w2)) * scaleX;
            dst.height = (this.stretch ? drawRect.height : srcRect.height);

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //right{
            src.x      = srcRect.x + w2;
            src.y      = srcRect.y;
            src.width  = srcRect.width - w2;
            src.height = srcRect.height;

            dst.x      = drawRect.width - src.width * scaleX;
            dst.y      = 0;
            dst.width  = src.width * scaleX;
            dst.height = (this.stretch ? drawRect.height : srcRect.height);

            this._skinDrawSlice(w, bmp, src, dst);
        //}
    }//function draw()


    /**
    * Draw slice for 3- or 9- slice scaling
    *
    */
    private function _skinDrawSlice(w:Widget, bmp:BitmapData, src:Rectangle, dst:Rectangle) : Void {

        var mx : Matrix = new Matrix();
		mx.translate(-src.x, -src.y);
        mx.scale(dst.width / src.width, dst.height / src.height);
        mx.translate(dst.x, dst.y);

        w.graphics.beginBitmapFill(bmp, mx, false, this.smooth);
        w.graphics.drawRect(dst.x, dst.y, dst.width, dst.height);
        w.graphics.endFill();
    }//function _skinDrawSlice()


    /**
    * Returns the correct slice value, depending on if the slice value is less 
    * than one or not.
    * If it's less than one we return a part of the total value passed.
    * If it's larger or equal to one we return the slice value rounded.
    *
    */
    private function _sliceSize(slice:Float, total:Int) : Int {
        return Math.round(slice < 1 ? slice*total : slice);
    }


/*******************************************************************************
*   GETTERS / SETTERS
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
    * Getter srcRect
    *
    */
    private inline function get_srcRect() : Rectangle {
        if (this._srcRect == null) {
            var bmp = _getBmp();
            if (bmp != null) {
              return new Rectangle(0,0,bmp.width,bmp.height);
            }
            return null;
        }
        return _srcRect;
    }//function get_srcRect()


/**
    * Setter srcRect
    *
    */
    private inline function set_srcRect(rect:Rectangle) : Rectangle {
        return this._srcRect = rect;
    }//function set_srcRect()

}//class Slice3
