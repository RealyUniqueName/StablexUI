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

        var scaleX : Float = (w.w >= bmp.width ? 1 : w.w / bmp.width);
        var scaleY : Float = (w.h >= bmp.height ? 1 : w.h / bmp.height);
        //do not draw nothing
        if( scaleX <= 0 || scaleY <= 0 ){
            return;
        }

// if( w.wparent != null && w.wparent.id == 'naughty' ){
//     // trace({sx:scaleX, sy:scaleY});
//     var b = new nme.display.Sprite();
//     var mx = new nme.geom.Matrix();
//     mx.scale(scaleX, scaleY);
//     b.graphics.beginBitmapFill(bmp, mx, false, true);
//     b.graphics.drawRect(0, 0, bmp.width * scaleX, bmp.height * scaleY);
//     b.graphics.endFill();
//     b.y = b.x = 200;
//     nme.Lib.current.addChild(b);

//     var b = new nme.display.Sprite();
//     b.graphics.beginBitmapFill(bmp, null, false, true);
//     b.graphics.drawRect(0, 0, bmp.width, bmp.height);
//     b.graphics.endFill();
//     b.y = b.x = 300;
//     b.scaleX = scaleX;
//     b.scaleY = scaleY;
//     nme.Lib.current.addChild(b);
// }
        //top left{
            src.x      = 0;
            src.y      = 0;
            src.width  = this.slice[0];
            src.height = this.slice[2];

            dst.x      = 0;
            dst.y      = 0;
            dst.width  = this.slice[0] * scaleX;
            dst.height = this.slice[2] * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //top middle{
            src.x      = this.slice[0];
            src.y      = 0;
            src.width  = this.slice[1] - this.slice[0];
            src.height = this.slice[2];

            dst.x      = this.slice[0] * scaleX;
            dst.y      = 0;
            dst.width  = w.w - (this.slice[0] + (bmp.width - this.slice[1])) * scaleX;
            dst.height = this.slice[2] * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //top right{
            src.x      = this.slice[1];
            src.y      = 0;
            src.width  = bmp.width - this.slice[1];
            src.height = this.slice[2];

            dst.x      = w.w - src.width * scaleX;
            dst.y      = 0;
            dst.width  = src.width * scaleX;
            dst.height = this.slice[2] * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //middle left{
            src.x      = 0;
            src.y      = this.slice[2];
            src.width  = this.slice[0];
            src.height = this.slice[3] - this.slice[2];

            dst.x      = 0;
            dst.y      = this.slice[2] * scaleY;
            dst.width  = this.slice[0] * scaleX;
            dst.height = w.h - (this.slice[2] + (bmp.height - this.slice[3])) * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //middle middle{
            src.x      = this.slice[0];
            src.y      = this.slice[2];
            src.width  = this.slice[1] - this.slice[0];
            src.height = this.slice[3] - this.slice[2];

            dst.x      = this.slice[0] * scaleX;
            dst.y      = this.slice[2] * scaleY;
            dst.width  = w.w - (this.slice[0] + (bmp.width - this.slice[1])) * scaleX;
            dst.height = w.h - (this.slice[2] + (bmp.height - this.slice[3])) * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //middle right{
            src.x      = this.slice[1];
            src.y      = this.slice[2];
            src.width  = bmp.width - this.slice[1];
            src.height = this.slice[3] - this.slice[2];

            dst.x      = w.w - src.width * scaleX;
            dst.y      = this.slice[2] * scaleY;
            dst.width  = src.width * scaleX;
            dst.height = w.h - (this.slice[2] + (bmp.height - this.slice[3])) * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //bottom left{
            src.x      = 0;
            src.y      = this.slice[3];
            src.width  = this.slice[0];
            src.height = bmp.height - this.slice[3];

            dst.x      = 0;
            dst.y      = w.h - src.height * scaleY;
            dst.width  = this.slice[0] * scaleX;
            dst.height = src.height * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //bottom middle{
            src.x      = this.slice[0];
            src.y      = this.slice[3];
            src.width  = this.slice[1] - this.slice[0];
            src.height = bmp.height - this.slice[3];

            dst.x      = this.slice[0] * scaleX;
            dst.y      = w.h - src.height * scaleY;
            dst.width  = w.w - (this.slice[0] + (bmp.width - this.slice[1])) * scaleX;
            dst.height = src.height * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}

        //bottom right{
            src.x      = this.slice[1];
            src.y      = this.slice[3];
            src.width  = bmp.width - this.slice[1];
            src.height = bmp.height - this.slice[3];

            dst.x      = w.w - src.width * scaleX;
            dst.y      = w.h - src.height * scaleY;
            dst.width  = src.width * scaleX;
            dst.height = src.height * scaleY;

            this._skinDrawSlice(w, bmp, src, dst);
        //}
    }//function draw()


}//class Slice9