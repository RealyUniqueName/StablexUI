package ru.stablex.ui.widgets;

import nme.display.BitmapData;
import ru.stablex.Err;


/**
* Simple Bitmap. Bitmap is drawn using .graphics.beginBitmapFill()
*/

class Bmp extends Widget{
    //Asset ID or path to bitmap
    public var src : String;
    //Should we use smoothing? False by default
    public var smooth : Bool = false;


    /**
    * Refresh widget. Draw bitmap on this.graphics
    *
    * @throw <type>String</type> if asset for bitmap was not found
    */
    override public function refresh() : Void {
        this._load();
        super.refresh();
    }//function refresh()



    /**
    * Load and display bitmapdata specified by this.src
    *
    * @throw <type>String</type> if asset for bitmap was not found
    */
    private function _load() : Void {
        var bmp : BitmapData = null;

        if( this.src != null ){
            bmp = Assets.getBitmapData(this.src);
            if( bmp == null ){
                Err.trigger('Bitmap not found: ' + this.src);
            }

            //draw picture on graphics
            this.graphics.clear();
            this.graphics.beginBitmapFill(bmp, null, false, this.smooth);
            this.graphics.drawRect(0, 0, bmp.width, bmp.height);
            this.graphics.endFill();

            this.w = this.width;
            this.h = this.height;
        }
    }//function _load()



}//class Bmp