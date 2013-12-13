package ru.stablex.ui.skins;

import flash.display.GradientType;
import flash.display.Graphics;
import flash.errors.Error;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.geom.Matrix;
import ru.stablex.ui.misc.ColorUtils;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Widget;


/**
* Creates an aswing like skin.
*/
class Aswing extends Skin {
	
	
	 //border width
    public var border : Float = 0;
    //border color
    //public var borderColor : Int = 0x000000;
    //border alpha
    public var borderAlpha : Float = 1;
    //define corner radius. Format: [elipseWidth, elipseHeight] or [radius], e.g. [10, 20] or [20]
    public var corners : Array<Float>;
    //padding for top border
    public var paddingTop : Float = 0;
    //padding for right border
    public var paddingRight : Float = 0;
    //padding for bottom border
    public var paddingBottom : Float = 0;
    //padding for left border
    public var paddingLeft : Float = 0;
    //set equal padding for all borders
    public var padding(never,set_padding) : Float;
	//gradient type (linear or radial)
    public var type : String = 'linear';

	
    //colors alpha. Defaults to non-transparent colors
    public var alphas : Array<Float>;
    //description. Defaults to equal ratios for all colors
    public var ratios : Array<Int>;
    //gradient box width (negative values defaults to widget size)
    public var width : Float = -1;
    //gradient box height (negative values defaults to widget size)
    public var height : Float = -1;
    //gradient rotation (radians. 0 for from left to right, PI / 2 for from top to bottom. Defaults to PI / 2)
    public var rotation : Float;
    //gradient offset along x axes
    public var tx : Float = 0;
    //gradient offset along y axes
    public var ty : Float = 0;
	
	// Base color used by this widget (other colors are generated from it)
	public var color: Int = 0x009FEC;
	
    private var colors : Array<Int>;
	private var innerBorderColor : Array<Int>;
	
	/** Used to create skins automaticaly */
	public var mode:String = "";
	
	
    /**
    * Constructor
    *
    */
    public function new () : Void {
        super();
        this.rotation = Math.PI / 2;
		corners = [0];
		colors = [0xFFFFFF, 0x0];
		innerBorderColor = [0xFFFFFF, 0x0];
    }

	/**
    * Setter for padding
    *
    */
    @:noCompletion private function set_padding (p:Float) : Float {
        this.paddingTop = this.paddingBottom = this.paddingRight = this.paddingLeft = p;
        return p;
    } //function set_padding()

	
    /**
    * Draw skin on widget
    *
    */
    override public function draw (w:Widget) : Void 
	{
			
		if (Std.is(w, Button))
		{
			drawButton(cast w);
		}
		// TODO - else..
		
    }
	
	function drawButton(w:Button) 
	{
		
		var width  : Float = w.w - this.paddingLeft - this.paddingRight;
        var height : Float = w.h - this.paddingTop - this.paddingBottom;
		//if size is wrong, draw nothing
        if ( width <= 0 || height <= 0 ) return;
		
		var angle = rotation;
		var shadownAngle = 225;
		if (mode == 'pressed')
		{
			angle = 180;
			shadownAngle = 45;
		}
		
        var mx : Matrix = new Matrix();
        mx.createGradientBox(
            (this.width < 0 ? w.w : this.width),
            (this.height < 0 ? w.h : this.height),
            angle,
            this.tx,
            this.ty
        );
		var mxBase = mx.clone();
		
        this._adjustArrays();
		var btnColor:Array<Int> = colors.copy();
		
		if (mode == 'hoovered')
		{
			btnColor[0] = ColorUtils.brighten(btnColor[0], 0.2);
			btnColor[1] = ColorUtils.brighten(btnColor[1], 0.2);
			innerBorderColor[0] = ColorUtils.brighten(innerBorderColor[0], 0.2);
			innerBorderColor[1] = ColorUtils.brighten(innerBorderColor[1], 0.2);
		} 
		
		
		
		// ===== BASE GRADIENT =====
        w.graphics.beginGradientFill((this.type == 'linear' ? GradientType.LINEAR : GradientType.RADIAL), btnColor, this.alphas, this.ratios, mxBase);
		roundRect(w.graphics, this.paddingLeft, this.paddingTop, width, height, this.corners[0] / 2 );
        
		// ===== OUTER BORDER =====
		w.graphics.beginGradientFill((this.type == 'linear' ? GradientType.LINEAR : GradientType.RADIAL),[innerBorderColor[1], innerBorderColor[1]], [1, 0.6], [0, 255], mx);
		roundRect(w.graphics, this.paddingLeft, this.paddingTop, width, height, this.corners[0] / 2);
		// ===== INNER BORDER =====
		w.graphics.beginGradientFill((this.type == 'linear' ? GradientType.LINEAR : GradientType.RADIAL),[innerBorderColor[0], innerBorderColor[0]], [1, 0.6], [0, 255], mx);
		roundRect(w.graphics, this.paddingLeft + 1, this.paddingTop + 1, width - 2, height - 2, this.corners[0] / 2);
		
		// ===== INNER BUTTON =====
		w.graphics.beginGradientFill((this.type == 'linear' ? GradientType.LINEAR : GradientType.RADIAL), btnColor, this.alphas, this.ratios, mxBase);
		roundRect(w.graphics, this.paddingLeft + 2, this.paddingTop + 2, width - 4, height - 4, this.corners[0] / 2);
		
		w.graphics.endFill();
		
		
		w.filters = [new DropShadowFilter(2,shadownAngle,0,.5,4,4,1,1,true), new DropShadowFilter(2,shadownAngle + 180,0xFFFFFF,.5,4,4,1,1,true)];
	}
	
	/**
	 * Draws a round rectangle.
	 *
	 * @param x the left top the rectangle bounds' x corrdinate.
	 * @param y the left top the rectangle bounds' y corrdinate.
	 * @param width the width of rectangle bounds.
	 * @param height the height of rectangle bounds.
	 * @param radius the top left corner's round radius.
	 * @param trR (optional)the top right corner's round radius. (miss this param default to same as radius)
	 * @param blR (optional)the bottom left corner's round radius. (miss this param default to same as radius)
	 * @param brR (optional)the bottom right corner's round radius. (miss this param default to same as radius)
	 */
	public function roundRect(target:Graphics, x:Float, y:Float, width:Float, height:Float, radius:Float = 0, ?trR:Float = -1, ?blR:Float = -1, ?brR:Float = -1):Void {
        var tlR:Float = radius;
        if (trR == -1) trR = radius;
        if (blR == -1) blR = radius;
        if (brR == -1) brR = radius;
		
		//Bottom right
		target.moveTo(x + blR, y + height);
		target.lineTo(x + width - brR, y + height);
		target.curveTo(x + width, y + height, x + width, y + height - blR);
		//Top right
		target.lineTo(x + width, y + trR);
		target.curveTo(x + width, y, x + width - trR, y);
		//Top left
		target.lineTo(x + tlR, y);
		target.curveTo(x, y, x, y + tlR);
		//Bottom left
		target.lineTo(x, y + height - blR);
		target.curveTo(x, y + height, x + blR, y + height);
	}
	
	
    /**
    * Set `.alphas` and `.ratios` according to `.colors` if they were not set manually
    *
    */
    private inline function _adjustArrays () : Void {
			
		colors[0] = ColorUtils.brighten( Std.int((0xff << 24) | color), 0.35 / 2); // bright base color
		colors[1] = ColorUtils.darken( Std.int((0xff << 24) | color), 0.35 / 2); // dark base color
		innerBorderColor[0] = ColorUtils.brighten( Std.int((0xff << 24) | color), 0.35 / 2 + 0.15); // bright border color
		innerBorderColor[1] = ColorUtils.darken( Std.int((0xff << 24) | color), 0.35 / 2 + 0.15); // dark border color; 
		
        if( this.alphas == null || this.alphas.length != this.colors.length ){
            this.alphas = [];
            for(i in 0...this.colors.length){
                this.alphas.push(1);
            }
        }

        if( this.ratios == null || this.ratios.length != this.colors.length ){
            this.ratios = [0];
            var r : Int = Math.floor(255 / (this.colors.length - 1));

            for(i in 1...(this.colors.length - 1)){
                this.ratios.push(r * i);
            }

            this.ratios.push(255);
        }
    }
	
}