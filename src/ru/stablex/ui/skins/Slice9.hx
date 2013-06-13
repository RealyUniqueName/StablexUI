package ru.stablex.ui.skins;

import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import ru.stablex.Assets;
import ru.stablex.ui.widgets.Widget;



/**
* 9-slice-scaling
* `slice` property now takes 4 floats: vertical left, vertical right, horizontal top,
* horizontal bottom guidelines for slicing
* If the floats are less than one they indicate a percentage of the picture where it 
* should be cut. 
* If they are larger than or equal to one they are pixels and should be integer values.
*/
class Slice9 extends Slice3{

    /**
    * Draw skin on widget
    *
    */
    override public function draw (w:Widget) : Void {
        var bmp : BitmapData = this._getBmp();

        if( bmp == null ){
            Err.trigger(this.src == null ? 'Bitmap is not specified' : 'Bitmap data not found: ' + this.src);
        }

        var src : Rectangle = new Rectangle();
        var dst : Rectangle = new Rectangle();

        var scaleX : Float = (w.w >= bmp.width ? 1 : w.w / bmp.width);
        var scaleY : Float = (w.h >= bmp.height ? 1 : w.h / bmp.height);
        //do not draw nothing
        if( scaleX <= 0 || scaleY <= 0 ){
            return;
        }

        //top left{
            src.x      = 0;
            src.y      = 0;
            src.width  = _sliceSize(this.slice[0], bmp.width);
            src.height = _sliceSize(this.slice[2], bmp.height);

            dst.x      = 0;
            dst.y      = 0;
            dst.width  = _sliceSize(this.slice[0], bmp.width) * scaleX;
            dst.height = _sliceSize(this.slice[2], bmp.height) * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //top middle{
            src.x      = _sliceSize(this.slice[0], bmp.width);
            src.y      = 0;
            src.width  = _sliceSize(this.slice[1] - this.slice[0], bmp.width);
            src.height = _sliceSize(this.slice[2], bmp.height);

            dst.x      = _sliceSize(this.slice[0], bmp.width) * scaleX;
            dst.y      = 0;
            dst.width  = w.w - (_sliceSize(this.slice[0], bmp.width) + (bmp.width - _sliceSize(this.slice[1], bmp.width))) * scaleX;
            dst.height = _sliceSize(this.slice[2], bmp.height) * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //top right{
            src.x      = _sliceSize(this.slice[1], bmp.width);
            src.y      = 0;
            src.width  = bmp.width - _sliceSize(this.slice[1], bmp.width);
            src.height = _sliceSize(this.slice[2], bmp.height);

            dst.x      = w.w - src.width * scaleX;
            dst.y      = 0;
            dst.width  = src.width * scaleX;
            dst.height = _sliceSize(this.slice[2], bmp.height) * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //middle left{
            src.x      = 0;
            src.y      = _sliceSize(this.slice[2], bmp.height);
            src.width  = _sliceSize(this.slice[0], bmp.width);
            src.height = _sliceSize(this.slice[3] - this.slice[2], bmp.height);

            dst.x      = 0;
            dst.y      = _sliceSize(this.slice[2], bmp.height) * scaleY;
            dst.width  = _sliceSize(this.slice[0], bmp.width) * scaleX;
            dst.height = w.h - (_sliceSize(this.slice[2], bmp.height) + (bmp.height - _sliceSize(this.slice[3], bmp.height))) * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //middle middle{
            src.x      = _sliceSize(this.slice[0], bmp.width);
            src.y      = _sliceSize(this.slice[2], bmp.height);
            src.width  = _sliceSize(this.slice[1] - this.slice[0], bmp.width);
            src.height = _sliceSize(this.slice[3] - this.slice[2], bmp.height);

            dst.x      = _sliceSize(this.slice[0], bmp.width) * scaleX;
            dst.y      = _sliceSize(this.slice[2], bmp.height) * scaleY;
            dst.width  = w.w - (_sliceSize(this.slice[0], bmp.width) + (bmp.width - _sliceSize(this.slice[1], bmp.width))) * scaleX;
            dst.height = w.h - (_sliceSize(this.slice[2], bmp.height) + (bmp.height - _sliceSize(this.slice[3], bmp.height))) * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //middle right{
            src.x      = _sliceSize(this.slice[1], bmp.width);
            src.y      = _sliceSize(this.slice[2], bmp.height);
            src.width  = bmp.width - _sliceSize(this.slice[1], bmp.width);
            src.height = _sliceSize(this.slice[3] - this.slice[2], bmp.height);

            dst.x      = w.w - src.width * scaleX;
            dst.y      = _sliceSize(this.slice[2], bmp.height) * scaleY;
            dst.width  = src.width * scaleX;
            dst.height = w.h - (_sliceSize(this.slice[2], bmp.height) + (bmp.height - _sliceSize(this.slice[3], bmp.height))) * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //bottom left{
            src.x      = 0;
            src.y      = _sliceSize(this.slice[3], bmp.height);
            src.width  = _sliceSize(this.slice[0], bmp.width);
            src.height = bmp.height - _sliceSize(this.slice[3], bmp.height);

            dst.x      = 0;
            dst.y      = w.h - src.height * scaleY;
            dst.width  = _sliceSize(this.slice[0], bmp.width) * scaleX;
            dst.height = src.height * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //bottom middle{
            src.x      = _sliceSize(this.slice[0], bmp.width);
            src.y      = _sliceSize(this.slice[3], bmp.height);
            src.width  = _sliceSize(this.slice[1] - this.slice[0], bmp.width);
            src.height = bmp.height - _sliceSize(this.slice[3], bmp.height);

            dst.x      = _sliceSize(this.slice[0], bmp.width) * scaleX;
            dst.y      = w.h - src.height * scaleY;
            dst.width  = w.w - (_sliceSize(this.slice[0], bmp.width) + (bmp.width - _sliceSize(this.slice[1], bmp.width))) * scaleX;
            dst.height = src.height * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //bottom right{
            src.x      = _sliceSize(this.slice[1], bmp.width);
            src.y      = _sliceSize(this.slice[3], bmp.height);
            src.width  = bmp.width - _sliceSize(this.slice[1], bmp.width);
            src.height = bmp.height - _sliceSize(this.slice[3], bmp.height);

            dst.x      = w.w - src.width * scaleX;
            dst.y      = w.h - src.height * scaleY;
            dst.width  = src.width * scaleX;
            dst.height = src.height * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}
    }//function draw()


}//class Slice9
