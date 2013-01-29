package ru.stablex.ui.skins;

import nme.display.BitmapData;
import ru.stablex.Assets;
import ru.stablex.ui.widgets.Widget;



/**
* Fill widget with bitmap
*
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