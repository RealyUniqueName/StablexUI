package ru.stablex.ui.skins;

import flash.geom.Matrix;
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
    // If set to true and `scaleImg` is set to true, will maintain the aspect ratio of the image whilst scaling
    public var keepAspect : Bool = false;
    // If set to true as well as `scaleImg` and `keepAspect` the image will be cropped such that it fills the entire widget space
    public var crop : Bool = false;


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

        //scale widget to image (default)
        if (!scaleImg) {
            if( w.w != bmp.width || w.h != bmp.height ){
                w.resize(bmp.width, bmp.height);
            }
            w.graphics.beginBitmapFill(bmp, null, false, this.smooth);
            w.graphics.drawRect(0, 0, bmp.width, bmp.height);
            w.graphics.endFill();

        //scale image to widget
        } else {
            var matrix = new Matrix();
            var scaleX = w.w / bmp.width;
            var scaleY = w.h / bmp.height;

            if (keepAspect) {
                scaleX = scaleY = (this.crop ? Math.max(scaleX, scaleY) : Math.min(scaleX, scaleY));
                matrix.scale (scaleX, scaleY);
                matrix.translate(
                    (w.w - bmp.width * scaleX) * 0.5,
                    (w.h - bmp.height * scaleY) * 0.5
                );
            } else {
                matrix.scale(scaleX, scaleY);
            }

            w.graphics.beginBitmapFill(bmp, matrix, false, this.smooth);
            if (this.crop) {
                w.graphics.drawRect(0, 0, w.w, w.h);
            } else {
                w.graphics.drawRect(matrix.tx, matrix.ty, bmp.width * scaleX, bmp.height * scaleY);
            }
            w.graphics.endFill();
        }
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
