package ru.stablex.ui.widgets;

import haxe.io.Path;
import flash.display.BitmapData;
import flash.display.Shape;
import mloader.Loader;
import mloader.StringLoader;
import flash.events.Event;
import ru.stablex.ui.events.WidgetEvent;
import ru.stablex.ui.events.ImageWidgetEvent;
import ru.stablex.ui.events.URLLoaderEvent;
import format.SVG;

/**
 * ...
 * @author Darcy.G
 */
class SVGImage extends BmpPlus
{
    
    public var defaultSrc(get_defaultSrc, set_defaultSrc) : String;
    private var _defaultSrc : String = null;
    
    private function get_defaultSrc() : String {
        return this._defaultSrc;
    }

    private function set_defaultSrc(src : String) : String {
        if (src != null && src != "") this._defaultSrc = src;
        return this._defaultSrc;
    }

    public var errorSrc(get_errorSrc, set_errorSrc) : String;
    private var _errorSrc : String = null;
    
    private function get_errorSrc() : String {
        return this._errorSrc;
    }

    private function set_errorSrc(src : String) : String {
        if (src != null && src != "") this._errorSrc = src;
        return this._errorSrc;
    }    
    
    private var _loader: StringLoader = null;
    private var _lastSrc : String = null;
    private var _lastW : Float;
    private var _lastH : Float;
    
    public var loading(get_loading, null) : Bool; 
    private function get_loading() : Bool {
        if (this._loader != null) {
            return this._loader.loading;
        }
        return false;
    }
    
    public var progress(get_progress, null) : Float;
    private var _progress : Float = -1 ;
    private function get_progress() : Float {
        //if (this._loader != null) {
            //this._progress = this._loader.progress;
        //}
        return this._progress;        
    }
    
    public var loaded(get_loaded, null) : Bool;
    private var _loaded : Bool = false;
    private function get_loaded() : Bool {
        return this._loaded;        
    }
    
    private var _updateBitmapCache : Bool = false;
    private var _islocalsrc : Bool = false;
    
    public var fixedSize : Bool = false;
    
    /**
    * Setter src
    *
    */
    override private function set_src(src:String) : String {
        if( src != null ){
            //this._bitmapData = null;
            this._src = src;
            if (src.indexOf("http://") == 0 || src.indexOf("https://") == 0) {
                this._lastSrc = this._defaultSrc;
                this._progress = 0;
                this._loader = new StringLoader(src);
                this._loader.loaded.add(this.__onLoaded);
                this._loader.load();
                this._islocalsrc = false;
            } else {
                this._bitmapData = null;
                this._lastSrc = src;
                this._updateBitmapCache = true;
                this._islocalsrc = true;
                this.refresh();
            }
        }
        return this._src ;//= src;
    }//function set_src()
    
    private function _getBitmapFromSVGData(svgdata:String):BitmapData {
        if (svgdata != null && StringTools.trim(svgdata) != "") {            
            var svg:SVG = new SVG(svgdata);
            var shape:Shape = new Shape();
            svg.render(shape.graphics);
            var bmpData = new BitmapData(Std.int(shape.width), Std.int(shape.height), true, 0x00ffffff);
            bmpData.draw (shape);
            //shape.free();
            shape = null;
            return bmpData;
        }
        return null;
    }
    
    private function _getBitmapFromSVGFile(svgfile:String):BitmapData {
        var svgdata:String = Assets.getText(svgfile);
        return this._getBitmapFromSVGData(svgdata);
    }
    
    private function _getBitmapFromSrcField(srcInfo:String):BitmapData {
        var ext = StringTools.trim(Path.extension(srcInfo).toLowerCase());
        if (ext == "svg") return this._getBitmapFromSVGFile(srcInfo);
        else if (ext == "png" || ext == "jpg" || ext == "bmp")
            return Assets.getBitmapData(srcInfo);
        else return null;
    }
    
    /**
    * Setter bitmapData
    *
    */
    override private function set_bitmapData(bmp:BitmapData) : BitmapData {
        if( bmp != null ){
            this._lastSrc = null;
        }
        return this._bitmapData = bmp;
    }//function set_bitmapData()    
    
    override private function _loadBitmapFromSrc() : BitmapData {
        var bmp : BitmapData = this._bitmapData;
        //trace(this._lastSrc);
        //trace(this._defaultSrc);
        //trace(this._errorSrc);
        if ( bmp == null && (this._lastSrc != null || this._defaultSrc!= null)) {
            bmp = this._setLastBmp(bmp);
            if( bmp == null ){
                //Err.trigger('Bitmap not found: ' + this._lastSrc);
            }//else this.resize(bmp.width, bmp.height);
        }
        
        if (this._updateBitmapCache) {
            this._updateBitmapCache = false;
            if (bmp != null) {
                this.srcWidth = bmp.width;
                this.srcHeight = bmp.height;
            }else {
                this.srcWidth = this.srcHeight = 0;
            }
            if (bmp != null) {
                if (!this._islocalsrc)
                    this.dispatchEvent( new ImageWidgetEvent(ImageWidgetEvent.SHOW_WEBIMG));
                this.dispatchEvent( new ImageWidgetEvent(ImageWidgetEvent.SHOW_IMG));
            }else {
                this.dispatchEvent( new ImageWidgetEvent(ImageWidgetEvent.NONE_IMG));
            }
            if (!this.fixedSize) {
                this._resetSize(bmp);
            }else {
                if (bmp != null) {
                    if (bmp.width > 0) this.scaleX = this.w / bmp.width;
                    if (bmp.height > 0) this.scaleY = this.h / bmp.height;
                }     
            }
        }
        
        return bmp;
    }
    
    private function _setLastBmp(bmp : BitmapData) : BitmapData {
        if (this._lastSrc != null) {
            //bmp = Assets.getBitmapData(this._lastSrc);
            bmp = this._getBitmapFromSrcField(this._lastSrc);
            if (bmp != null) {
                //trace("_setLastBmp ok");
                if (this._islocalsrc) this.dispatchEvent( new ImageWidgetEvent(ImageWidgetEvent.SHOW_LOCALIMG));
                //else this.dispatchEvent( new ImageWidgetEvent(ImageWidgetEvent.SHOW_WEBIMG));
                
                this._updateBitmapCache = true;
                return bmp;
            }
        }
        return this._setDefBmp(bmp);
    }    
    
    private function _setDefBmp(bmp : BitmapData) : BitmapData {
        if (this._defaultSrc != null) {
            //bmp = Assets.getBitmapData(this._defaultSrc);
            bmp = this._getBitmapFromSrcField(this._defaultSrc);
            if (bmp != null) {
                this.dispatchEvent( new ImageWidgetEvent(ImageWidgetEvent.SHOW_DEFIMG));
                this._updateBitmapCache = true;
                //trace("_setDefBmp ok");
                this._lastSrc = this._defaultSrc;
            }
        }
        return bmp;
    }
    
    private function _setErrBmp(bmp : BitmapData) : BitmapData {
        if (this._errorSrc != null) {
            //bmp = Assets.getBitmapData(this._errorSrc);
            bmp = this._getBitmapFromSrcField(this._errorSrc);
            if (bmp != null) {
                //trace("_setErrBmp ok");
                this.dispatchEvent( new ImageWidgetEvent(ImageWidgetEvent.SHOW_ERRIMG));
                this._updateBitmapCache = true;
                this._lastSrc = this._errorSrc;
                return bmp;
            }
        } 
        return this._setDefBmp(bmp);
    }
    
    private function _resetSize(bmp : BitmapData) : Void {
        if (bmp != null) {
            if (this._lastW != bmp.width)
            {
                this.w = bmp.width;
                this._lastW = bmp.width;
            }
            if (this._lastW != bmp.height)
            {
                this.h = bmp.height;
                this._lastH = bmp.height;
            }
        }else {
            this._lastW = this.w = 0;
            this._lastH = this.h = 0;
        }
    }
    
	private function __onLoaded(event) : Void
	{
        //var bmp : BitmapData = this._bitmapData;
		switch (event.type)
		{
            case Start:
                this._loaded = false;
                this.dispatchEvent( new URLLoaderEvent(URLLoaderEvent.WEBGET_START));
                
            case Cancel:
                this._progress = 0;
                this.dispatchEvent( new URLLoaderEvent(URLLoaderEvent.WEBGET_CANCEL));
                this._loader = null;
                
			case Fail(error):
                this._progress = -1;
                if (this._errorSrc != null) {
                    this._bitmapData = null;
                    this._lastSrc = this._errorSrc;
                }else if (this._defaultSrc != null ) {
                    this._bitmapData = null;
                    this._lastSrc = this._defaultSrc;
                }
                this.dispatchEvent( new URLLoaderEvent(URLLoaderEvent.WEBGET_FAIL));
                this._updateBitmapCache = true;
                this.refresh();
                this._loader = null;
                this._loaded = false;

			case Complete:
                this._progress = 1;
                var svgdata = event.target.content;
                
                if (svgdata != null && StringTools.trim(svgdata) != "") {
                    var bmp:BitmapData = null;
                    bmp = this._getBitmapFromSVGData(svgdata);
                    if (bmp != null) this._bitmapData = bmp;
                }
                
                this.dispatchEvent( new URLLoaderEvent(URLLoaderEvent.WEBGET_COMPLETE));
                this._islocalsrc = false;
                this._updateBitmapCache = true;
                this.refresh();
                this._loader = null;
                this._loaded = true;
                
            case Progress:
                //var p = Std.int(this._loader.progress*100);
                this._progress = this._loader.progress;
                this.dispatchEvent( new URLLoaderEvent(URLLoaderEvent.WEBGET_PROGRESS));

			//default:
		}
	}  
    
}