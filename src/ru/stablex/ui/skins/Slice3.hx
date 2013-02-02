package ru.stablex.ui.skins;

import nme.display.BitmapData;
import nme.geom.Matrix;
import nme.geom.Point;
import nme.geom.Rectangle;
import ru.stablex.Assets;
import ru.stablex.ui.widgets.Widget;



/**
* 3-slice-scaling
*
*/
class Slice3 extends Skin{
    //Asset ID or path to bitmap
    public var src : String;
    //should we use smoothing?
    public var smooth : Bool = true;
    //should we stretch skin to fit widget's height?
    public var stretch : Bool = true;
    /**
    * Where to slice skin bitmap.
    * This array should contain zero, one or two integers.
    * Zero - 3 slice scaling (horizontal). Bitmap is divided into two equal sized bitmaps.
    *         Middle part is filled with central column of pixels.
    * One - 3 slice scaling (horizontal). Bitmap is divided into two bitmaps. Middle part
    *         is filled with column of pixels with x = specified integer.
    * Two - 3 slice scaling (horizontal). Integers: left and right guidelines for slicing
    */
    public var slice : Array<Int>;


    /**
    * Draw skin on widget
    *
    */
    override public function draw (w:Widget) : Void {
        var bmp : BitmapData = Assets.getBitmapData(this.src);

        if( bmp == null ){
            Err.trigger(this.src == null ? 'Bitmap is not specified' : 'Bitmap data not found: ' + this.src);
        }

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
            w1 = this.slice[0];
            w2 = w1 + 1;
        //slice three parts
        }else{
            w1 = this.slice[0];
            w2 = this.slice[1];
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
}//class Slice3