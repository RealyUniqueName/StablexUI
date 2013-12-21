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
    private var outerBorderColor : Array<Int>;
    private var innerBorderColor : Array<Int>;


    /** difference between the light and darkside of the button gradient. [0, 1]*/
    public var gradFactor: Float = 0.35;
    /** Used to create skins automaticaly */
    public var mode:String = "";
    /** Controls the ammount of border factor.*/
    public var borderFactor:Float = 0.3;
    /** Distance of the bevel effect. */
    public var bevelAmmount:Float = 2;
    /** Blur applied to the bevel effect */
    public var bevelBlur:Float = 4;
    /** Bevel alpha */
    public var bevelAlpha: Float = 0.5;
    /** Direction of the bevel effect */
    public  var bevelAngle : Int = 90;


    /**
    * Constructor
    *
    */
    public function new () : Void {
        super();
        this.rotation = Math.PI / 2;
        corners = [0];
        colors = [0xFFFFFF, 0x0];
        outerBorderColor = [0xFFFFFF, 0x0];
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
        this._adjustArrays();
        var angle = rotation;
        var shadownAngle = -bevelAngle;
        var _colors:Array<Int> = colors.copy();

        if (Std.is(w, Button))
        {
            if (mode == 'hoovered')
            {
                _colors[0] = ColorUtils.brighten(_colors[0], 0.2);
                _colors[1] = ColorUtils.brighten(_colors[1], 0.2);
                innerBorderColor[0] = ColorUtils.brighten(innerBorderColor[0], 0.2);
                innerBorderColor[1] = ColorUtils.brighten(innerBorderColor[1], 0.2);
            }

            if (mode == 'pressed')
            {
                angle *= -1;
                shadownAngle *= -1;
            }
        }

        var width  : Float = w.w - this.paddingLeft - this.paddingRight;
        var height : Float = w.h - this.paddingTop - this.paddingBottom;
        //if size is wrong, draw nothing
        if ( width <= 0 || height <= 0 ) return;



        var mx : Matrix = new Matrix();
        mx.createGradientBox(
            (this.width < 0 ? w.w : this.width),
            (this.height < 0 ? w.h : this.height),
            angle,
            this.tx,
            this.ty
        );


        // ===== OUTER BORDER =====
        w.graphics.lineStyle(4, 0, 1, true);
        w.graphics.lineGradientStyle((this.type == 'linear' ? GradientType.LINEAR : GradientType.RADIAL),[outerBorderColor[1], outerBorderColor[1]], [1, 1], ratios, mx);
        w.graphics.beginGradientFill((this.type == 'linear' ? GradientType.LINEAR : GradientType.RADIAL), [outerBorderColor[1], outerBorderColor[1]], [1, 1], ratios, mx);
        w.graphics.drawRoundRect(this.paddingLeft, this.paddingTop, width, height, corners[0], corners[1]);
        // ===== INNER BORDER =====
        w.graphics.lineStyle(2, 0, 1, true);
        w.graphics.lineGradientStyle((this.type == 'linear' ? GradientType.LINEAR : GradientType.RADIAL),[innerBorderColor[0], innerBorderColor[1]], [1, 1], ratios, mx);
        w.graphics.beginGradientFill((this.type == 'linear' ? GradientType.LINEAR : GradientType.RADIAL), [innerBorderColor[0], innerBorderColor[1]], [1, 1], ratios, mx);
        w.graphics.drawRoundRect(this.paddingLeft, this.paddingTop, width, height, corners[0], corners[1]);
        // ===== INNER BUTTON =====
        w.graphics.lineStyle(0, 0, 0, true);
        w.graphics.beginGradientFill((this.type == 'linear' ? GradientType.LINEAR : GradientType.RADIAL), _colors, this.alphas, this.ratios, mx);
        w.graphics.drawRoundRect(this.paddingLeft, this.paddingTop, width, height, corners[0], corners[1]);
        w.graphics.endFill();

        // ===== APPLY BEVEL =====
        w.filters = [new DropShadowFilter(bevelAmmount, shadownAngle, 0, bevelAlpha, bevelBlur, bevelBlur, 1, 3, true), new DropShadowFilter(bevelAmmount, -shadownAngle, 0xFFFFFF, bevelAlpha, bevelBlur, bevelBlur, 1, 3, true)];

    }

    /**
    * Set `.alphas` and `.ratios` according to `.colors` if they were not set manually
    *
    */
    private inline function _adjustArrays () : Void {

        colors[0] = ColorUtils.brighten( Std.int((0xff << 24) | color), gradFactor / 2); // bright base color
        colors[1] = ColorUtils.darken( Std.int((0xff << 24) | color), gradFactor / 2); // dark base color
        innerBorderColor[0] = ColorUtils.brighten( Std.int((0xff << 24) | color), gradFactor / 2 + borderFactor); // bright border color
        innerBorderColor[1] = ColorUtils.brighten( Std.int((0xff << 24) | color), gradFactor / 2 + borderFactor / 2); // dark border color;
        outerBorderColor[0] = ColorUtils.darken( Std.int((0xff << 24) | color), gradFactor / 2 + borderFactor); // bright border color
        outerBorderColor[1] = ColorUtils.darken( Std.int((0xff << 24) | color), gradFactor / 2 + borderFactor / 2); // dark border color;

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