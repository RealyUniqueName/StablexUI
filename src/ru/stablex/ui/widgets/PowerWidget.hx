package ru.stablex.ui.widgets;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.events.Event;
import ru.stablex.ui.events.WidgetEvent;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

/**
 * ...
 * @author Darcy.G
 */
class PowerWidget extends Widget
{
    /*
     * 保存Widget的原始宽高大小,缩放操作时需要
     */
    public var srcWidth(default, set_srcWidth) : Float = 0;
    private function set_srcWidth(v : Float) : Float {
        if (v < 0) v = 0;
        return this.srcWidth = v;
    }
    public var srcHeight(default,set_srcHeight) : Float = 0;
    private function set_srcHeight(v : Float) : Float {
        if (v < 0) v = 0;
        return this.srcHeight = v;
    }    
    public function setSrcSize(_w:Float, _h:Float, setNow:Bool = true):Void {
        this.srcWidth = _w;
        this.srcHeight = _h;
        if (setNow) {
            this.w = this.srcWidth ;
            this.h = this.srcHeight ;
        }
    }

    /*
     * 设置Widget的注册点,缩放、旋转操作时需要
     */    
    /*
    public var regX(default, set_regX): Float = 0;
    private function set_regX(v : Float) : Float {
        return this.regX = v;
    }
    public var regY(default, set_regY): Float = 0;
    private function set_regY(v : Float) : Float {
        return this.regY = v;
    }*/
    public var regX(default, null): Float = 0;
    public var regY(default, null): Float = 0;
    
    /*
    public function setRegPoint(_w:Float, _h:Float):Void {
        if (this.srcWidth == 0) this.regPtX = 0;
        else this.regPtX = _w / this.srcWidth;
        if (this.srcHeight == 0) this.regPtY = 0;
        else this.regPtY = _h/this.srcHeight;
    }
    */
    
    /*
     * 设置Widget的注册点,缩放、旋转操作时需要
     */    
    public var regPtX(default, set_regPtX): Float = 0.5;
    private function set_regPtX(v : Float) : Float {
        this.regX = this.regPtX * this.srcWidth;
        return this.regPtX = v;
    }
    public var regPtY(default, set_regPtY): Float = 0.5;
    private function set_regPtY(v : Float) : Float {
        this.regY = this.regPtY * this.srcHeight;
        return this.regPtY = v;
    } 
    
    public function setRegPointPt(_xPt:Float, _yPt:Float) : Void {
        this.regPtX = _xPt;
        this.regPtY = _yPt;
    }
    
    //private var _currentRegX : Float = 0;
    //private var _currentRegY : Float = 0;
    //private var _xOffset : Float = 0;
    //private var _yOffset : Float = 0;
    
    private function _fixRotateCurrentOffset(f:Void->Void) : Void {
        //this._doExecFunc = f;
        //if (this._doExecFunc != null){
        if (f != null){
            var lp:Point = new Point(this.regX, this.regY);
            var ps:Point = this.localToGlobal(lp);
            f();
            var pe:Point = this.localToGlobal(lp);
            //this._xOffset = pe.x - ps.x;
            //this._yOffset = pe.y - ps.y;
            this.x -= pe.x - ps.x;//this._xOffset;
            this.y -= pe.y - ps.y;//this._yOffset;
        }
        //this._doExecFunc = null;
    }
    
    //private function _fixCurrentOffset() : Void {
    //    this.x += this._xOffset;
    //    this.y += this._yOffset;
    //}
    private function _doRotate() : Void {
        this.rotation = this.rotateAxis;
    }    
    
    public var rotateAxis(default, set_rotateAxis) : Float = 0;
    private function set_rotateAxis(v : Float) : Float {
        //trace(v);
        //this._calCurrentOffset();
        this.rotateAxis = v;
        this._fixRotateCurrentOffset(this._doRotate);
        return v;
    }

    private function _fixZoomCurrentOffset(f:Void->Void) : Void {
        //this._doExecFunc = f;
        //if (this._doExecFunc != null){
        if (f != null){
            //var lp:Point = new Point(this.regX, this.regY);
            //var ps:Point = this.localToGlobal(lp); 
            var ps:Point = new Point(this.regX, this.regY);
            f();
            //var pe:Point = this.localToGlobal(lp);
            var pe:Point = new Point(this.w * this.regPtX, this.h * this.regPtY);
            //this._xOffset = pe.x - ps.x;
            //this._yOffset = pe.y - ps.y;
            this.x -= (pe.x - ps.x);//this._xOffset;
            this.y -= (pe.y - ps.y);//this._yOffset;
            this.regX = this.w * this.regPtX;
            this.regY = this.h * this.regPtY;
            trace(this.localToGlobal(new Point(this.regX, this.regY))); 
        }
        //this._doExecFunc = null;
    }    
    
    private function _doZoomInOut() : Void {
        //if (this.zoomInOut == 0) this.regX = this.regY = 0;
        this.resize(this.zoomInOut / 100 * this.srcWidth, this.zoomInOut / 100 * this.srcHeight);
        
        trace([this.zoomInOut,this.w, this.h]);
    }    
    
    public var zoomInOut(default, set_zoomInOut) : Float = 100;
    private function set_zoomInOut(v : Float) : Float {
        //trace(v);
        //this._calCurrentOffset();
        //this.rotateAxis = v;
        //this._calCurrentOffset(this._doRotate);
        this.zoomInOut = v;
        this._fixZoomCurrentOffset(this._doZoomInOut);
        return v;
    }
    
    /*
     * 自动根据父Widget大小设置自身大小
     */
    public var autoParentSize : Bool = false;
    
    private function _resetSizeAndRegPoint():Void {
        //trace("show+"+this.autoParentSize);
        this.setSrcSize(this.w, this.h, false);
        this.setRegPointPt(this.regPtX, this.regPtY);
        //this.regX = 310 / 2;
        //this.regY = 150 / 2;
        trace([this.w, this.h, this.regX, this.regY]);
        //this._calCurrentOffset();
        //this._fixCurrentOffset();
        if (this.autoParentSize && this.wparent != null){
            //this.w = this.wparent.w;
            //this.h = this.wparent.h;
            this.setSrcSize(this.wparent.w, this.wparent.h);
            this.setRegPointPt(this.regPtX, this.regPtY);
        }        
    }
    
    /**
    * Constructor
    *
    */
    public function new() : Void {
        super();
        //第一次加入场景显示时执行
        var displayfn : Event->Void = function(e:Event) : Void {
            this._resetSizeAndRegPoint();
		};
		this.addEventListener(flash.events.Event.ADDED_TO_STAGE, displayfn);	
    }//function new()
    
    /**
    * Display initial value on create
    *
    */
    override public function onCreate() : Void {
        super.onCreate();

    }
    
    //*
    override public function onResize() : Void {
        //trace("onResize:"+this.w+"/"+this.srcWidth+" "+this.h+"/"+this.srcHeight);
        var child : DisplayObject;
        var obj : Widget;

        super.onResize(); 
        //this._resetSizeAndRegPoint();
        for (i in 0...this.numChildren) {
            child = this.getChildAt(i);
            if (Std.is(child, Widget)) {
                obj = cast(child, Widget);
                obj.onResize();
            }
        }
    }
    
}