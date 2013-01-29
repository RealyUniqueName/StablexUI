package ru.stablex.ui.skins;

import nme.display.BitmapData;
import nme.geom.Matrix;
import nme.geom.Point;
import nme.geom.Rectangle;
import ru.stablex.Assets;
import ru.stablex.ui.widgets.Widget;



/**
* 9-slice-scaling
* `slice` property now takes 4 integers: vertical left, vertical right, horizontal top,
* horizontal bottom guidelines for slicing
*
*/
class Slice9 extends Slice3{

    /**
    * Draw skin on widget
    *
    */
    override public function draw (w:Widget) : Void {
        if( this.slice == null || this.slice.length < 4 ){
            Err.trigger('.slice property should contain 4 integers.');
        }

        var bmp : BitmapData = Assets.getBitmapData(this.src);

        if( bmp == null ){
            Err.trigger(this.src == null ? 'Bitmap is not specified' : 'Bitmap data not found: ' + this.src);
        }

        var src : Rectangle = new Rectangle();
        var dst : Rectangle = new Rectangle();

        //top left{
            src.x      = 0;
            src.y      = 0;
            src.width  = this.slice[0];
            src.height = this.slice[2];

            dst.x      = 0;
            dst.y      = 0;
            dst.width  = this.slice[0];
            dst.height = this.slice[2];

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //top middle{
            src.x      = this.slice[0];
            src.y      = 0;
            src.width  = this.slice[1] - this.slice[0];
            src.height = this.slice[2];

            dst.x      = this.slice[0];
            dst.y      = 0;
            dst.width  = w.w - this.slice[0] - (bmp.width - this.slice[1]);
            dst.height = this.slice[2];

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //top right{
            src.x      = this.slice[1];
            src.y      = 0;
            src.width  = bmp.width - this.slice[1];
            src.height = this.slice[2];

            dst.x      = w.w - src.width;
            dst.y      = 0;
            dst.width  = src.width;
            dst.height = this.slice[2];

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //middle left{
            src.x      = 0;
            src.y      = this.slice[2];
            src.width  = this.slice[0];
            src.height = this.slice[3] - this.slice[2];

            dst.x      = 0;
            dst.y      = this.slice[2];
            dst.width  = this.slice[0];
            dst.height = w.h - this.slice[2] - (bmp.height - this.slice[3]);

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //middle middle{
            src.x      = this.slice[0];
            src.y      = this.slice[2];
            src.width  = this.slice[1] - this.slice[0];
            src.height = this.slice[3] - this.slice[2];

            dst.x      = this.slice[0];
            dst.y      = this.slice[2];
            dst.width  = w.w - this.slice[0] - (bmp.width - this.slice[1]);
            dst.height = w.h - this.slice[2] - (bmp.height - this.slice[3]);

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //middle right{
            src.x      = this.slice[1];
            src.y      = this.slice[2];
            src.width  = bmp.width - this.slice[1];
            src.height = this.slice[3] - this.slice[2];

            dst.x      = w.w - src.width;
            dst.y      = this.slice[2];
            dst.width  = src.width;
            dst.height = w.h - this.slice[2] - (bmp.height - this.slice[3]);

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //bottom left{
            src.x      = 0;
            src.y      = this.slice[3];
            src.width  = this.slice[0];
            src.height = bmp.height - this.slice[3];

            dst.x      = 0;
            dst.y      = w.h - src.height;
            dst.width  = this.slice[0];
            dst.height = src.height;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //bottom middle{
            src.x      = this.slice[0];
            src.y      = this.slice[3];
            src.width  = this.slice[1] - this.slice[0];
            src.height = bmp.height - this.slice[3];

            dst.x      = this.slice[0];
            dst.y      = w.h - src.height;
            dst.width  = w.w - this.slice[0] - (bmp.width - this.slice[1]);
            dst.height = src.height;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //bottom right{
            src.x      = this.slice[1];
            src.y      = this.slice[3];
            src.width  = bmp.width - this.slice[1];
            src.height = bmp.height - this.slice[3];

            dst.x      = w.w - src.width;
            dst.y      = w.h - src.height;
            dst.width  = src.width;
            dst.height = src.height;

            this._skinDrawSlice(w, bmp, src, dst);
        //}
    }//function draw()


}//class Slice9