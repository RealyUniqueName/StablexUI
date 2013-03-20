package ru.stablex.ui.skins;

import nme.display.BitmapData;
import ru.stablex.Assets;
import ru.stablex.ui.widgets.Widget;



/**
* Fill widget with bitmap
*
* NOTICE: nme 3.5.5 for cpp target has issues for bitmaps with size not power of two.
* So if you want to use this skin for cpp target, make sure your bitmap size is power of two
* (32, 64, 128, ... pixels)
*/
class Tile extends Rect{

    //Asset ID or path to bitmap for tiling
    public var src : String;
    //should we use smoothing?
    public var smooth : Bool = false;


    /**
    * Draw skin on widget
    *
    */
    override public function draw (w:Widget) : Void {
        var bmp : BitmapData = Assets.getBitmapData(this.src);

        if( bmp == null ){
            Err.trigger(this.src == null ? 'Bitmap is not specified' : 'Bitmap data not found: ' + this.src);
        }

        w.graphics.beginBitmapFill(bmp, null, true, this.smooth);

        super.draw(w);

        w.graphics.endFill();
    }//function draw()
}//class Tile