package ru.stablex.ui.widgets;

import nme.display.BitmapData;
import ru.stablex.Err;


/**
* Simple Bitmap. Bitmap is drawn using .graphics.beginBitmapFill()
*/

class Bmp extends Widget{
    //Asset ID or path to BitmapData
    public var src : String;
    //Should we use smoothing? False by default
    public var smooth : Bool = false;


    /**
    * Refresh widget. Draw bitmap on this.graphics
    *
    */
    override public function refresh() : Void {
        this._load();
        super.refresh();
    }//function refresh()



    /**
    * Load and display bitmapdata specified by this.src
    *
    */
    private function _load() : Void {
        var bmp : BitmapData = Assets.getBitmapData(this.src);

        //draw picture on graphics
        if( bmp != null ){
            this.graphics.clear();
            this.graphics.beginBitmapFill(bmp, null, false, this.smooth);
            this.graphics.drawRect(0, 0, bmp.width, bmp.height);
            this.graphics.endFill();

            this.w = this.width;
            this.h = this.height;
        }
    }//function _load()



}//class Bmp