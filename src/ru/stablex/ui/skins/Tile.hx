package ru.stablex.ui.skins;

import nme.display.BitmapData;
import ru.stablex.Assets;
import ru.stablex.ui.widgets.Widget;



/**
* Fill widget with bitmap
*
*/
class Tile implements ISkin{

    //Asset ID or path to bitmap for tiling
    public var src : String;
    //should we use smoothing?
    public var smooth : Bool = false;
    //border width
    public var border : Float = 0;
    //border color
    public var borderColor : Int = 0x000000;
    //border alpha
    public var borderAlpha : Float = 1;
    //define corner radius for filling with color. Format: [elipseWidth, elipseHeight] or [radius], e.g. [10, 20] or [20]
    public var corners : Array<Float>;


    /**
    * Constructor
    *
    */
    public function new () : Void {
    }//function new()


    /**
    * Apply skin to widget
    *
    */
    public function apply (w:Widget) : Void {
        var bmp : BitmapData = Assets.getBitmapData(this.src);

        if( bmp == null ){
            Err.trigger(this.src == null ? 'Bitmap is not specified' : 'Bitmap data not found: ' + this.src);
        }

        w.graphics.clear();

        #if !html5
            if( this.border > 0 ){
                w.graphics.lineStyle(this.border, this.borderColor, this.borderAlpha);
            }

            w.graphics.beginBitmapFill(bmp, null, true, this.smooth);

            if( this.corners == null || this.corners.length == 0 ){
                w.graphics.drawRect(0, 0, w.w, w.h);
            }else if( this.corners.length == 1 ){
                w.graphics.drawRoundRect(0, 0, w.w, w.h, this.corners[0], this.corners[0]);
            }else{
                w.graphics.drawRoundRect(0, 0, w.w, w.h, this.corners[0], this.corners[1]);
            }

            w.graphics.endFill();
        #else
            var wh : Float = 0;
            var hh : Float = 0;
            var mx = new nme.geom.Matrix();

            while(wh < w.w){
                while(hh < w.h){
                    mx.identity();
                    mx.translate(wh, hh);

                    if( hh + bmp.height > w.h || wh + bmp.width > w.w ){
                        var h1 : Float = (hh + bmp.height > w.h ? w.h - hh : bmp.height);
                        var w1 : Float = (wh + bmp.width > w.w ? w.w - wh : bmp.width);

                        var bmp1 : BitmapData = new BitmapData(Std.int(w1), Std.int(h1), true, 0x00FFFFFF);
                        bmp1.copyPixels(bmp, new nme.geom.Rectangle(0, 0, w1, h1), new nme.geom.Point());

                        w.graphics.beginBitmapFill(bmp1, mx, true, true);
                    }else{
                        w.graphics.beginBitmapFill(bmp, mx, true, true);
                    }

                    w.graphics.drawRect(
                        wh,
                        hh,
                        (wh + bmp.width > w.w ? w.w - wh : bmp.width),
                        (hh + bmp.height > w.h ? w.h - hh : bmp.height)
                    );
                    w.graphics.endFill();

                    hh += bmp.height;
                }
                hh = 0;
                wh += bmp.width;
            }

            //if border is described
            if( this.border > 0 ){
                w.graphics.lineStyle(this.border, this.borderColor, this.borderAlpha);
                w.graphics.drawRect(0, 0, w.w, w.h);
            }
        #end
    }//function apply()
}//class Tile