package ru.stablex.ui.skins;

import ru.stablex.Assets;
import ru.stablex.ui.widgets.Widget;
import nme.display.BitmapData;


/**
* Img skin always set widget size the same as `.src` bitmapdata size
*
*/
class Img extends Skin{
    //Asset ID or path to bitmapdata
    public var src : String;
    //Smooth bitmap?
    public var smooth : Bool;


    /**
    * Draw skin
    *
    */
    override public function draw (w:Widget) : Void {
        var bmp : BitmapData = Assets.getBitmapData(this.src);

        if( bmp == null ){
            Err.trigger(this.src == null ? 'Bitmap is not specified' : 'Bitmap data not found: ' + this.src);
        }

        if( w.w != bmp.width || w.h != bmp.height ){
            w.resize(bmp.width, bmp.height);
        }

        w.graphics.beginBitmapFill(bmp, null, true, this.smooth);
        w.graphics.drawRect(0, 0, bmp.width, bmp.height);
        w.graphics.endFill();
    }//function draw()

}//class Img