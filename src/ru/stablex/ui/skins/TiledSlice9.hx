package ru.stablex.ui.skins;

import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import ru.stablex.Assets;
import ru.stablex.ui.widgets.Widget;



/**
* Tiled 9-slice-scaling
* Same as 9-slice, but instead of the scaling the middle part, it is tiled.
*/
class TiledSlice9 extends Slice9{

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

        var hSizes  : Array<Int> = [0,0,0];
        var vSizes : Array<Int> = [0,0,0];
        // Find out the scaling (horizontal)
        hSizes[0] = _sliceSize(this.slice[0], bmp.width);
        hSizes[2] = bmp.width - _sliceSize(this.slice[1], bmp.width);
        hSizes[1] = bmp.width - hSizes[0] - hSizes[2];
        // Now found the closest number of horizontal tiles, that filles the width of the widget
        var hTileCount : Int = Math.round((w.w - hSizes[0] - hSizes[2]) / hSizes[1]);
        // The scaling X is now such, that it fits exactly
        var scaleX : Float = w.w / (hSizes[0] + hSizes[2] + hTileCount * hSizes[1]);

        // Find out the scaling (vertical)
        vSizes[0] = _sliceSize(this.slice[2], bmp.height);
        vSizes[2] = bmp.height - _sliceSize(this.slice[3], bmp.height);
        vSizes[1] = bmp.height - vSizes[0] - vSizes[2];
        // Now found the closest number of vertical tiles, that filles the width of the widget
        var vTileCount : Int = Math.round((w.h - vSizes[0] - vSizes[2]) / vSizes[1]);
        // The scaling Y is now such, that it fits exactly
        var scaleY : Float = w.h / (vSizes[0] + vSizes[2] + vTileCount * vSizes[1]);

        //do not draw nothing
        if( scaleX <= 0 || scaleY <= 0 ){
            return;
        }

        function sum(a : Array<Int>) {
          var res : Int = 0;
          for (e in a) {
            res += e;
          }
          return res;
        }

        dst.y = 0;
        for (y in 0...(vTileCount+2)) {
          dst.x = 0;
          for (x in 0...(hTileCount+2)) {

            // Set the src rect
            var hSizeIndex = if (x == 0) {0;} else {if (x == hTileCount +1) {2;} else {1;}};
            var vSizeIndex = if (y == 0) {0;} else {if (y == vTileCount +1) {2;} else {1;}};
            src.x = sum(hSizes.slice(0,hSizeIndex));
            src.y = sum(vSizes.slice(0,vSizeIndex));
            src.width = hSizes[hSizeIndex];
            src.height = vSizes[vSizeIndex];

            // Set the distination width, based on the source width
            dst.width  = src.width  * scaleX;
            dst.height = src.height * scaleY;
            this._skinDrawSlice(w, bmp, src, dst);

            // Update destination x position
            dst.x += dst.width;
          }
          // Update destination y position
          dst.y += dst.height;
        }

    }//function draw()


}//class Slice9
