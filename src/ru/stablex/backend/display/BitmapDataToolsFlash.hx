package ru.stablex.backend.display;

#if (flash || openfl)

import ru.stablex.backend.display.BitmapData;
import ru.stablex.backend.display.Sprite;
import ru.stablex.backend.geom.Matrix;
import ru.stablex.backend.geom.Point;


/**
* Methods for bitmapdata drawings on sprites
* Implementation for Flash and OpenFL
*
*/
class BitmapDataToolsFlash {


    /**
    * Draw rectangle on specified sprite using this bitmap
    *
    * @param mx     - transformation matrix
    * @param x      - top left corner of drawing
    * @param y      - top left corner of drawing
    * @param width  - width of drawing
    * @param height - height of drawing
    * @param smooth - enable bitmap smoothing
    */
    static public function drawRect (sprite:Sprite, bmp:BitmapData, mx:Matrix, x:Float, y:Float, width:Float, height:Float, smooth:Bool = false) : Void {
        #if html5
            if( mx == null ){
                mx = new Matrix();
            }
            var dest = new BitmapData(Std.int(width), Std.int(height));
            dest.copyPixels(bmp, new Rectangle(-mx.tx, -mx.ty, width, height), new Point(0, 0));
            bmp = dest;
        #end

        sprite.graphics.beginBitmapFill(bmp, mx, false, smooth);
        sprite.graphics.drawRect(x, y, width, height);
        sprite.graphics.endFill();
    }//function drawRect()


    /**
    * Instantiating is not allowed
    *
    */
    private function new () : Void {}

}//class BitmapDataToolsFlash

#end