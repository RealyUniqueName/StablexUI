package ru.stablex.ui.skins;

import flash.display.BitmapData;
import ru.stablex.Assets;
import ru.stablex.ui.widgets.Widget;



/**
* Fill widget with bitmap
*
* NOTICE: NME 3.5.5 and probably OpenFL for cpp target has issues for bitmaps with size not power of two.
* So if you want to use this skin for cpp target, make sure your bitmap size is power of two
* (32, 64, 128, ... pixels)
*/
class Tile extends Rect{
    //Asset ID or path to bitmap
    public var src (get_src,set_src): String;
    public var _src : String = null;
    /**
    * Use this property instead of `.src`, if you need to directly assign BitmapData instance.
    * `.bitmapData` will be set to null automatically, if you set `.src`.
    * `.src` will be set to null automatically, if you set `.bitmapData`
    */
    public var bitmapData (get_bitmapData,set_bitmapData) : BitmapData;
    private var _bitmapData : BitmapData = null;
    //should we use smoothing?
    public var smooth : Bool = false;


    /**
    * get BitmapData instance
    *
    */
    private inline function _getBmp () : BitmapData {
        var bmp : BitmapData = this._bitmapData;

        if( bmp == null && this.src != null ){
            bmp = Assets.getBitmapData(this.src);
            if( bmp == null ){
                Err.trigger('Bitmap not found: ' + this.src);
            }
        }else if( bmp == null ){
            Err.trigger('Bitmap is not specified');
        }

        return bmp;
    }//function _getBmp()


    /**
    * Draw skin on widget
    *
    */
    override public function draw (w:Widget) : Void {
        var bmp : BitmapData = this._getBmp();

        w.graphics.beginBitmapFill(bmp, null, true, this.smooth);
        super.draw(w);
        w.graphics.endFill();
    }//function draw()


/*******************************************************************************
*   GETTERS / SETTERS
*******************************************************************************/


    /**
    * Getter src
    *
    */
    private inline function get_src() : String {
        return this._src;
    }//function get_src()


    /**
    * Setter src
    *
    */
    private inline function set_src(src:String) : String {
        if( src != null ){
            this._bitmapData = null;
        }
        return this._src = src;
    }//function set_src()


    /**
    * Getter bitmapData
    *
    */
    private inline function get_bitmapData() : BitmapData {
        return this._bitmapData;
    }//function get_bitmapData()


    /**
    * Setter bitmapData
    *
    */
    private inline function set_bitmapData(bitmapData:BitmapData) : BitmapData {
        if( bitmapData != null ){
            this._src = null;
        }
        return this._bitmapData = bitmapData;
    }//function set_bitmapData()

}//class Tile