package ru.stablex.ui.widgets;

import nme.display.BitmapData;
import mloader.Loader;
import mloader.ImageLoader;
/**
 * ...
 * @author Darcy.G
 */
class Image extends Bmp
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
    
    private var _loader:ImageLoader = null;
    private var _lastSrc : String = null;
    private var _lastW : Float;
    private var _lastH : Float;
    
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
                this._loader = new ImageLoader(src);
                this._loader.loaded.add(this.__onLoaded);
                this._loader.load();
            } else {
                this._bitmapData = null;
                this._lastSrc = src;
                this.refresh();
            }
        }
        return this._src ;//= src;
    }//function set_src()
    
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
            }else this.resize(bmp.width, bmp.height);
        }
        this._resetSize(bmp);
        return bmp;
    }
    
    private function _setLastBmp(bmp : BitmapData) : BitmapData {
        if (this._lastSrc != null) {
            bmp = Assets.getBitmapData(this._lastSrc);
            if (bmp != null) {
                //trace("_setLastBmp ok");
                return bmp;
            }
        }
        return this._setDefBmp(bmp);
    }    
    
    private function _setDefBmp(bmp : BitmapData) : BitmapData {
        if (this._defaultSrc != null) {
            bmp = Assets.getBitmapData(this._defaultSrc);
            if (bmp != null) {
                //trace("_setDefBmp ok");
                this._lastSrc = this._defaultSrc;
            }
        }
        return bmp;
    }
    
    private function _setErrBmp(bmp : BitmapData) : BitmapData {
        if (this._errorSrc != null) {
            bmp = Assets.getBitmapData(this._errorSrc);
            if (bmp != null) {
                //trace("_setErrBmp ok");
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
			case Fail(error):
                if (this._errorSrc != null) {
                    this._bitmapData = null;
                    this._lastSrc = this._errorSrc;
                }else if (this._defaultSrc != null ) {
                    this._bitmapData = null;
                    this._lastSrc = this._defaultSrc;
                }
                this.refresh();

			case Complete:
				this._bitmapData = event.target.content;
                this.refresh();
                this._loader = null;
                
            case Progress:
                var p = Std.int(this._loader.progress*100);

			default:
		}
	}  
    
}