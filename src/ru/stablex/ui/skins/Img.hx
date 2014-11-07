package ru.stablex.ui.skins;

import ru.stablex.Assets;
import ru.stablex.ui.widgets.Widget;
import flash.display.BitmapData;


/**
* Img skin always set widget size the same as `.src` bitmapdata size
*
*/
class Img extends Skin{
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
    //Smooth bitmap?
    public var smooth : Bool = true;
    // If set to true, the img is scaled to the size of the widget. If false the widget is scaled to the size of the img.
    public var scaleImg = false;
    // If set to true and scaleImg is set to true, will maintain the aspect ratio of the image whilst scaling
    public var keepAspect : Bool = false;


    /**
    * Draw skin
    *
    */
    override public function draw (w:Widget) : Void {
        var bmp : BitmapData = this._bitmapData;

        if( bmp == null && this.src != null ){
            bmp = Assets.getBitmapData(this.src);
            if( bmp == null ){
                Err.trigger('Bitmap not found: ' + this.src);
            }
        }else if( bmp == null ){
            Err.trigger('Bitmap is not specified');
        }

        var matrix = new flash.geom.Matrix();
        if (!scaleImg) {
            if( w.w != bmp.width || w.h != bmp.height ){
                w.resize(bmp.width, bmp.height);
            }
        } else {
            var scaleX = w.w/bmp.width;
            var scaleY = w.h/bmp.height;
            if(keepAspect){
                var scale = Math.min(scaleX, scaleY);
                matrix.scale(scale, scale);
                matrix.translate((w.w-bmp.width*scale)*0.5, (w.h-bmp.height*scale)*0.5);
            }else{
                matrix.scale(scaleX, scaleY);
            }
        }

        w.graphics.beginBitmapFill(bmp, matrix, false, this.smooth);
        w.graphics.drawRect(matrix.tx, matrix.ty, bmp.width*matrix.a, bmp.height*matrix.d);
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

}//class Img
