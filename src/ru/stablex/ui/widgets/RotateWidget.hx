package ru.stablex.ui.widgets;

import nme.geom.Point;
import nme.events.Event;
import ru.stablex.ui.events.WidgetEvent;

/**
 * ...
 * @author Darcy.G
 */
class RotateWidget extends Widget
{

    public var xAxis (get_xAxis,set_xAxis)                              : Float;
    public var xAxisPt (get_xAxisPt,set_xAxisPt)                        : Float;
    private var _xAxis                                                  : Float = 0;
    private var _xAxisPercent                                           : Float = 0.5;
    public var yAxis (get_yAxis,set_yAxis)                              : Float;
    public var yAxisPt (get_yAxisPt,set_yAxisPt)                        : Float;
    private var _yAxis                                                  : Float = 0;
    private var _yAxisPercent                                           : Float = 0.5;

    public var rotateAxis(get_rotateAxis, set_rotateAxis)               : Float;
    private var _rotateAxis                                             : Float = 0;
    private var _rotateAxisChanged                                      : Bool = false;
    private var _inited                                                 : Bool = false;
    
    override public function onCreate() : Void {
        this.xAxis = this.w * this._xAxisPercent;
        this.yAxis = this.h * this._yAxisPercent;        
        
		var displayfn : Event->Void = function(e:Event) : Void {
			if (this._rotateAxisChanged) {
				this._rotateAxisChanged = false;
				this.__rotateAxis(this._rotateAxis);
                this._inited = true;
			} 
		};
		this.addEventListener(nme.events.Event.ADDED_TO_STAGE, displayfn);
		
		var changedfn : Event->Void = function(e:Event) : Void {
			if (this._rotateAxisChanged && this._inited) {
				this._rotateAxisChanged = false;
				this.__rotateAxis(this._rotateAxis);
			} 
		};
		this.addEventListener(WidgetEvent.CHANGE, changedfn);
    }//function onCreate()

    /**
    * xAxis percent setter
    *
    */
    private function set_xAxis(x:Float) : Float {
		var osize:Float = 0;
		osize = this.w;

        this._xAxis = x;
        this._xAxisPercent = x / osize;
        this._rotateAxisChanged = true;
        this.set_rotateAxis(this._rotateAxis);
        return this._xAxis;
    }//function set_xAxis()

    /**
    * xAxis percent getter
    *
    */
    private function get_xAxis() : Float {
        return this._xAxis;
    }//function get_xAxis()

    /**
    * xAxisPt percent setter
    *
    */
    private function set_xAxisPt(xp:Float) : Float {
        var osize:Float = 0;
		osize = this.w;

		this._xAxisPercent = xp;
		this.xAxis = osize*xp;
        return this._xAxisPercent;
    }//function set_xAxisPt()

    /**
    * xAxisPt percent getter
    *
    */
    private function get_xAxisPt() : Float {
        return this._xAxisPercent;
    }//function get_xAxisPt()

    /**
    * yAxis percent setter
    *
    */
    private function set_yAxis(y:Float) : Float {
        var osize:Float = 0;
        osize = this.h;

        this._yAxis = y;
        this._yAxisPercent = y / osize;
        this._rotateAxisChanged = true;
        this.set_rotateAxis(this._rotateAxis);
        return this._yAxis;
    }//function set_yAxis()

    /**
    * yAxis percent getter
    *
    */
    private function get_yAxis() : Float {
        return this._yAxis;
    }//function get_yAxis()

    /**
    * yAxisPt percent setter
    *
    */
    private function set_yAxisPt(yp:Float) : Float {
        var osize:Float = 0;
		osize = this.h;

		this._yAxisPercent = yp;
		this.yAxis = osize*yp;
        return this._yAxisPercent;
    }//function set_yAxisPt()

    /**
    * yAxisPt percent getter
    *
    */
    private function get_yAxisPt() : Float {
        return this._yAxisPercent;
    }//function get_yAxisPt()

    private function set_rotateAxis(r:Float):Float {        
		if (this._rotateAxis != r) {
			this._rotateAxisChanged = true;
			this._rotateAxis = r;
		}
		this.dispatchEvent(new WidgetEvent(WidgetEvent.CHANGE));
        return this._rotateAxis;
    }
    
    private function get_rotateAxis():Float { 
        return this._rotateAxis;
    }

	private function __rotateAxis(r:Float) : Void {
		var lp:Point = new Point(this._xAxis,this._yAxis);
		var ps:Point = this.localToGlobal(lp);
		
		this.rotation = r;
		var pe:Point = this.localToGlobal(lp);
		this.x-=pe.x-ps.x;
		this.y-=pe.y-ps.y;

		/*
		trace("w:"+this.w);
		trace("h:"+this.h);
		trace("rotation:"+this.rotation);
		trace("xAxis:"+this.xAxis);
		trace("yAxis:"+this.yAxis);
		*/
	}
    
    
}