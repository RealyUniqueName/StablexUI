package ru.stablex.ui.widgets;

import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.geom.Point;
import ru.stablex.Err;
import flash.events.Event;
import ru.stablex.ui.events.WidgetEvent;

/**
* Simple Bitmap. Bitmap is drawn using .graphics.beginBitmapFill()
*/

class BmpPlus extends Bmp {
    
    public var srcWidth : Float = 0;
    public var srcHeight : Float = 0;
    
    public var autoParentSize : Bool = false;
    public var autoScaleSize : Bool = true;
    /**
    * Constructor
    *
    */
    public function new() : Void {
        super();
    }//function new()
    
    /**
    * Display initial value on create
    *
    */
    override public function onCreate() : Void {
        super.onCreate();
        var displayfn : Event->Void = function(e:Event) : Void {
            //trace("show+"+this.autoParentSize);
            if (this.autoParentSize && this.wparent != null){
                this.w = this.wparent.w;
                this.h = this.wparent.h;
            }
		};
		this.addEventListener(flash.events.Event.ADDED_TO_STAGE, displayfn);	
    }
    
    //*
    override public function onResize() : Void {
        //trace("onResize:"+this.w+"/"+this.srcWidth+" "+this.h+"/"+this.srcHeight);
        if (this.srcWidth!=0&&this.srcHeight!=0) {
            this.scaleX = this.w / this.srcWidth;
            this.scaleY = this.h / this.srcHeight;           
        }
        super.onResize();
    }
    //*/
    
    override private function _loadBitmapFromSrc() : BitmapData {
        var bmp : BitmapData = super._loadBitmapFromSrc();
        //trace(bmp.width+" "+bmp.height);
        if (bmp != null) {
            this.srcWidth = bmp.width;
            this.srcHeight = bmp.height;
        }else {
            this.srcWidth = this.srcHeight = 0;
        }
        return bmp;
    }

}//class Bmp