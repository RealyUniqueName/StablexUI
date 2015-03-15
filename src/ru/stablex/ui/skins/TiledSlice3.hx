package ru.stablex.ui.skins;

import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import ru.stablex.Assets;
import ru.stablex.ui.widgets.Widget;



/**
* Tiled 3-slice-scaling
* Same as 3-slice, but instead of the scaling the middle part, it is tiled.
* In difference to TiledSlice3, the height of the widget is used for correct scaling.
*/
class TiledSlice3 extends Slice3{
    /**
    * Draw skin on widget
    *
    */
    override public function draw (w:Widget) : Void {
        var bmp : BitmapData = this._getBmp();
        var srcRect : Rectangle = this.get_srcRect();

        if( bmp == null ){
            Err.trigger(this.src == null ? 'Bitmap is not specified' : 'Bitmap data not found: ' + this.src);
        }

        var src : Rectangle = new Rectangle();
        var dst : Rectangle = new Rectangle();

        // Find out the scaling (determined from the widgets height)
        var scaling : Float = w.h / srcRect.height;
        var scaleY = scaling;

        var hSizes  : Array<Int> = [0,0,0];
        // Find out the number of tiles
        hSizes[0] = _sliceSize(this.slice[0], Std.int(srcRect.width));
        hSizes[2] = Std.int(srcRect.width) - _sliceSize(this.slice[1], Std.int(srcRect.width));
        hSizes[1] = Std.int(srcRect.width) - hSizes[0] - hSizes[2];
        // Now found the closest number of horizontal tiles, that filles the width of the widget (using the scaling from the height)
        var hTileCount : Int = Math.round((w.w/scaling - hSizes[0] - hSizes[2]) / hSizes[1]);
        // The scaling X is now such, that it fits exactly
        var scaleX : Float = w.w / (hSizes[0] + hSizes[2] + hTileCount * hSizes[1]);

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
        dst.x = 0;
        for (x in 0...(hTileCount+2)) {
          // Set the src rect
          var hSizeIndex = if (x == 0) {0;} else {if (x == hTileCount +1) {2;} else {1;}};
          src.x = srcRect.x + sum(hSizes.slice(0,hSizeIndex));
          src.y = srcRect.y;
          src.width = hSizes[hSizeIndex];
          src.height = srcRect.height;

          // Set the distination width, based on the source width
          dst.width  = src.width  * scaleX;
          dst.height = w.h;
          this._skinDrawSlice(w, bmp, src, dst);

          // Update destination x position
          dst.x += dst.width;
        }

    }//function draw()


}//class Slice3