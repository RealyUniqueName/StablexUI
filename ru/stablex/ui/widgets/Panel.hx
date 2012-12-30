package ru.stablex.ui.widgets;

import nme.display.BitmapData;
import nme.geom.Matrix;
import nme.geom.Point;
import nme.geom.Rectangle;
import ru.stablex.Err;


/**
* Just panel wich can be tiled with texture, skinned with TSkin or colored with .graphics.beginFill()
* Prioritty: skin -> texture -> coloring
*/
class Panel extends Widget{
    //Skin name to use. One of UIBuilder.skins
    public var skin (default,_setSkin) : String;
    //Assets ID or path to bitmapData for skinning
    public var skinBmp : String;
    /*
    * Where to slice skin bitmap.
    * This array should contain zero, one, two or four integers.
    * Zero - 3 slice scaling (horizontal). Bitmap is divided into two equal sized bitmaps. Middle part is filled with central column of pixels.
    * One - 3 slice scaling (horizontal). Bitmap is divided into two bitmaps. Middle part is filled with column of pixels with x = specified integer.
    * Two - 3 slice scaling (horizontal). Integers: left and right guidelines for slicing
    * Four - 9 slice scalign. Integers: vertical left, vertical right, horizontal top, horizontal bottom
    */
    public var skinSlices : Array<Int>;
    //Should we use skin or texture bitmap size to set this.h and this.w ? Default - false
    public var skinMetrics : Bool = false;
    //Should we stretch skin height to fit this.h when using 3 slice scaling? Default - true
    public var skinStretch : Bool = true;
    //Assets ID or path to bitmapData for tiling
    public var texture : String;
    //Border width
    public var border : Float = 0;
    //Border color
    public var borderColor : Int = 0x000000;
    //Background color
    public var bgColor (default,_setBgColor) : Int = 0x000000;
    /**
    * Background alpha for coloring. Default - 0.
    * If bgAlpha = 0, background won't be colored at all.
    */
    public var bgAlpha : Float = 0;


    /**
    * .bgColor setter. If bgAlpha = 0 set it to 1
    *
    */
    private function _setBgColor (c:Int) : Int {
        if( this.bgAlpha == 0 ) this.bgAlpha = 1;
        return this.bgColor = c;
    }//function _setBgColor()


    /**
    * Setter for skin data according to one of UIBUilder.skin skins
    *
    */
    private function _setSkin(s:String) : String {
        var skin : ru.stablex.ui.TSkin = ru.stablex.ui.UIBuilder.skins.get(s);
        if( skin == null ) Err.trigger('Skin not found: ' + s);

        this.skinBmp    = skin.bmp;
        this.skinSlices = skin.slices;

        return this.skin = s;
    }//function _setSkin()


    /**
    * Refresh widget
    *
    */
    override public function refresh() : Void {
        super.refresh();
        this.reskin();
    }//function refresh()


    /**
    * apply skin settings
    *
    */
    public function reskin() : Void {
        //should we use skin ?
        if( this.skinBmp != null ){
            var bmp : BitmapData = Assets.getBitmapData(this.skinBmp);
            //рисуем картинку на объекте
            if( bmp != null ){
                if( this.skinMetrics || this.w == 0 ) this.w = bmp.width;
                if( this.skinMetrics || this.h == 0 ) this.h = bmp.height;

                this._skin(bmp, this.border, this.borderColor);
            }else{
                Err.trigger('Skin bitmap not found: ' + this.skinBmp);
            }

        //or fill with bitmap ?
        }else if( this.texture != null ){
            var bmp : BitmapData = Assets.getBitmapData(this.texture);
            //рисуем картинку на объекте
            if( bmp != null ){
                if( this.skinMetrics || this.w == 0 ) this.w = bmp.width;
                if( this.skinMetrics || this.h == 0 ) this.h = bmp.height;

                this._fillWithBitmap(bmp, this.border, this.borderColor);

            }else{
                Err.trigger('Texture bitmap not found: ' + this.texture);
            }

        //or just fill with color?
        }else{
            this._fillWithColor(this.bgColor, this.border, this.borderColor, this.bgAlpha);
        }
    }//function reskin()


    /**
    * on resize refresh widget
    *
    */
    override public function onResize() : Void {
        super.onResize();
        this.reskin();
    }//function onResize()


    /**
    * Fill with bitmap (texture)
    *
    */
    private function _fillWithBitmap(bmp:BitmapData, borderWidth:Float = 0, borderColor:Int = 0x000000) : Void {
        var w : Float = 0;
        var h : Float = 0;
        var mx = new Matrix();

        this.graphics.clear();

        while(w < this.w){
            while(h < this.h){
                mx.identity();
                mx.translate(w, h);

                this.graphics.beginBitmapFill(bmp, mx, true, true);
                this.graphics.drawRect(
                    w,
                    h,
                    (w + bmp.width > this.w ? this.w - w : bmp.width),
                    (h + bmp.height > this.h ? this.h - h : bmp.height)
                );
                this.graphics.endFill();

                h += bmp.height;
            }
            h = 0;
            w += bmp.width;
        }

        //if border is described
        if( borderWidth > 0 ){
            this.graphics.lineStyle(borderWidth, borderColor);
            this.graphics.drawRect(0, 0, this.w, this.h);
        }
    }//function _fillWithBitmap()


    /**
    * Fill with color
    *
    */
    private function _fillWithColor(color:Int, borderWidth:Float = 0, borderColor:Int = 0x000000, alpha:Float = 1) : Void {
        this.graphics.clear();

        if( borderWidth > 0 ){
            this.graphics.lineStyle(borderWidth, borderColor);
        }

        if( alpha > 0 ){
            this.graphics.beginFill(color, alpha);
            this.graphics.drawRect(0, 0, this.w, this.h);
            this.graphics.endFill();

        }else if( borderWidth > 0 ){
            this.graphics.drawRect(0, 0, this.w, this.h);
        }
    }//function _fillWithColor()


    /**
    * Apply skin
    *
    */
    private function _skin(bmp:BitmapData, borderWidth:Float = 0, borderColor:Int = 0) : Void {
        //choose X-slice-scaling type {
            //divide skin bitmap to 2 equal parts
            if( this.skinSlices == null || this.skinSlices.length == 0 ){
                this._skin3Slice(bmp, Std.int(bmp.width/2));
            //divide skin bitmap to 2 parts with width of first part  = this.skinSlices[0]
            }else if( this.skinSlices.length == 1 ){
                this._skin3Slice(bmp, this.skinSlices[0]);
            //3 slice scaling
            }else if( this.skinSlices.length == 2 ){
                this._skin3Slice(bmp, this.skinSlices[0], this.skinSlices[1]);
            //3 slice scaling
            }else if( this.skinSlices.length == 4 ){
                this._skin9Slice(bmp, this.skinSlices[0], this.skinSlices[1], this.skinSlices[2], this.skinSlices[3]);
            //Unexpected this.skinSlices content
            }else{
                Err.trigger('Wrong skinSlices amount specified');
            }
        //}

        //if border is described
        if( borderWidth > 0 ){
            this.graphics.lineStyle(borderWidth, borderColor);
            this.graphics.drawRect(0, 0, this.w, this.h);
        }
    }//function _skin()


    /**
    * 3 slice scaling skin
    *
    */
    private function _skin3Slice(bmp:BitmapData, w1:Int, w2:Int = 0) : Void {
        this.graphics.clear();

        //если делим скин только на две части
        if( w2 == 0 ){
            w2 = w1 + 1;
        }

        var src : Rectangle = new Rectangle();
        var dst : Rectangle = new Rectangle();

        //left{
            src.x      = 0;
            src.y      = 0;
            src.width  = w1;
            src.height = bmp.height;

            dst.x      = 0;
            dst.y      = 0;
            dst.width  = w1;
            dst.height = (this.skinStretch ? this.h : bmp.height);

            this._skinDrawSlice(bmp, src, dst);
        //}

        //middle{
            src.x      = w1;
            src.y      = 0;
            src.width  = w2 - w1;
            src.height = bmp.height;

            dst.x      = w1;
            dst.y      = 0;
            dst.width  = this.w - w1 - (bmp.width - w2);
            dst.height = (this.skinStretch ? this.h : bmp.height);

            this._skinDrawSlice(bmp, src, dst);
        //}

        //right{
            src.x      = w2;
            src.y      = 0;
            src.width  = bmp.width - w2;
            src.height = bmp.height;

            dst.x      = this.w - src.width;
            dst.y      = 0;
            dst.width  = src.width;
            dst.height = (this.skinStretch ? this.h : bmp.height);

            this._skinDrawSlice(bmp, src, dst);
        //}
    }//function _skin2Slice()


    /**
    * 9 slice scaling skin
    *
    */
    private function _skin9Slice(bmp:BitmapData, w1:Int, w2:Int, h1:Int, h2:Int) : Void {
        this.graphics.clear();

        var src : Rectangle = new Rectangle();
        var dst : Rectangle = new Rectangle();

        //top left{
            src.x      = 0;
            src.y      = 0;
            src.width  = w1;
            src.height = h1;

            dst.x      = 0;
            dst.y      = 0;
            dst.width  = w1;
            dst.height = h1;

            this._skinDrawSlice(bmp, src, dst);
        //}

        //top middle{
            src.x      = w1;
            src.y      = 0;
            src.width  = w2 - w1;
            src.height = h1;

            dst.x      = w1;
            dst.y      = 0;
            dst.width  = this.w - w1 - (bmp.width - w2);
            dst.height = h1;

            this._skinDrawSlice(bmp, src, dst);
        //}

        //top right{
            src.x      = w2;
            src.y      = 0;
            src.width  = bmp.width - w2;
            src.height = h1;

            dst.x      = this.w - src.width;
            dst.y      = 0;
            dst.width  = src.width;
            dst.height = h1;

            this._skinDrawSlice(bmp, src, dst);
        //}

        //middle left{
            src.x      = 0;
            src.y      = h1;
            src.width  = w1;
            src.height = h2 - h1;

            dst.x      = 0;
            dst.y      = h1;
            dst.width  = w1;
            dst.height = this.h - h1 - (bmp.height - h2);

            this._skinDrawSlice(bmp, src, dst);
        //}

        //middle middle{
            src.x      = w1;
            src.y      = h1;
            src.width  = w2 - w1;
            src.height = h2 - h1;

            dst.x      = w1;
            dst.y      = h1;
            dst.width  = this.w - w1 - (bmp.width - w2);
            dst.height = this.h - h1 - (bmp.height - h2);

            this._skinDrawSlice(bmp, src, dst);
        //}

        //middle right{
            src.x      = w2;
            src.y      = h1;
            src.width  = bmp.width - w2;
            src.height = h2 - h1;

            dst.x      = this.w - src.width;
            dst.y      = h1;
            dst.width  = src.width;
            dst.height = this.h - h1 - (bmp.height - h2);

            this._skinDrawSlice(bmp, src, dst);
        //}

        //bottom left{
            src.x      = 0;
            src.y      = h2;
            src.width  = w1;
            src.height = bmp.height - h2;

            dst.x      = 0;
            dst.y      = this.h - src.height;
            dst.width  = w1;
            dst.height = src.height;

            this._skinDrawSlice(bmp, src, dst);
        //}

        //bottom middle{
            src.x      = w1;
            src.y      = h2;
            src.width  = w2 - w1;
            src.height = bmp.height - h2;

            dst.x      = w1;
            dst.y      = this.h - src.height;
            dst.width  = this.w - w1 - (bmp.width - w2);
            dst.height = src.height;

            this._skinDrawSlice(bmp, src, dst);
        //}

        //bottom right{
            src.x      = w2;
            src.y      = h2;
            src.width  = bmp.width - w2;
            src.height = bmp.height - h2;

            dst.x      = this.w - src.width;
            dst.y      = this.h - src.height;
            dst.width  = src.width;
            dst.height = src.height;

            this._skinDrawSlice(bmp, src, dst);
        //}
    }//function _skin3Slice()


    /**
    * Draw slice for 3- or 9- slice scaling
    *
    */
    private function _skinDrawSlice(bmp:BitmapData, src:Rectangle, dst:Rectangle) : Void {
        var fill:BitmapData = new BitmapData(Std.int(src.width), Std.int(src.height), true,  0x00FFFFFF);
        fill.copyPixels(bmp, src, new Point(0, 0));

        var mx : Matrix = new Matrix();
        mx.scale(dst.width / fill.width, dst.height / fill.height);
        mx.translate(dst.x, dst.y);

        this.graphics.beginBitmapFill(fill, mx, false, true);
        this.graphics.drawRect(dst.x, dst.y, dst.width, dst.height);
        this.graphics.endFill();
    }//function _skinDrawSlice()


}//class Panel