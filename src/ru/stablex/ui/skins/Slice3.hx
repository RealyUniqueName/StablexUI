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

        w.graphics.clear();

        var w1 : Int = 0;
        var w2 : Int = 0;

        var scaleX : Float = (w.w >= bmp.width ? 1 : w.w / bmp.width);
        //do not draw nothing
        if( scaleX <= 0 ){
            return;
        }

        //slice two equal size parts
        if( this.slice == null || this.slice.length == 0 ){
            w1 = Std.int(bmp.width / 2);
            w2 = w1 + 1;
        //two different size parts
        }else if( this.slice.length == 1 ){
            w1 = _sliceSize(this.slice[0], bmp.width);
            w2 = w1 + 1;
        //slice three parts
        }else{
            w1 = _sliceSize(this.slice[0], bmp.width);
            w2 = _sliceSize(this.slice[1], bmp.width);
        }

        var src : Rectangle = new Rectangle();
        var dst : Rectangle = new Rectangle();

        //left{
            src.x      = 0;
            src.y      = 0;
            src.width  = w1;
            src.height = bmp.height;

            dst.x      = 0;
            dst.y      = 0;
            dst.width  = w1 * scaleX;
            dst.height = (this.stretch ? w.h : bmp.height);

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //middle{
            src.x      = w1;
            src.y      = 0;
            src.width  = w2 - w1;
            src.height = bmp.height;

            dst.x      = w1 * scaleX;
            dst.y      = 0;
            dst.width  = w.w - (w1 + (bmp.width - w2)) * scaleX;
            dst.height = (this.stretch ? w.h : bmp.height);

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //right{
            src.x      = w2;
            src.y      = 0;
            src.width  = bmp.width - w2;
            src.height = bmp.height;

            dst.x      = w.w - src.width * scaleX;
            dst.y      = 0;
            dst.width  = src.width * scaleX;
            dst.height = (this.stretch ? w.h : bmp.height);

            this._skinDrawSlice(w, bmp, src, dst);
        //}
    }//function draw()


    /**
    * Draw slice for 3- or 9- slice scaling
    *
    */
    private function _skinDrawSlice(w:Widget, bmp:BitmapData, src:Rectangle, dst:Rectangle) : Void {
        var fill:BitmapData = new BitmapData(Std.int(src.width), Std.int(src.height), true);
        fill.copyPixels(bmp, src, new Point(0, 0));

        var mx : Matrix = new Matrix();
        mx.scale(dst.width / fill.width, dst.height / fill.height);
        mx.translate(dst.x, dst.y);

        w.graphics.beginBitmapFill(fill, mx, false, this.smooth);
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

}//class Slice3
