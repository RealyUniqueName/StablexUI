package ru.stablex.ui.skins;

import nme.display.GradientType;
import nme.geom.Matrix;
import ru.stablex.ui.widgets.Widget;


/**
* Fill widget with gradient
* <a href="http://help.adobe.com/ru_RU/FlashPlatform/reference/actionscript/3/flash/display/Graphics.html#beginGradientFill()" target="_blank">read this</a>
*/
class Gradient extends Skin{
    //gradient type (linear or radial)
    public var type : String = 'linear';
    //colors (defaults to [0x000000, 0xFFFFFF])
    public var colors : Array<Int>;
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
    //border width
    public var border : Float = 0;
    //border color
    public var borderColor : Int = 0x000000;
    //border alpha
    public var borderAlpha : Float = 1;
    //define corner radius. Format: [elipseWidth, elipseHeight] or [radius], e.g. [10, 20] or [20]
    public var corners : Array<Float>;


    /**
    * Constructor
    *
    */
    public function new () : Void {
        super();
        this.rotation = Math.PI / 2;
    }//function new()


    /**
    * Apply skin to widget
    *
    */
    override public function apply (w:Widget) : Void {
        w.graphics.clear();

        if( this.border > 0 ){
            w.graphics.lineStyle(this.border, this.borderColor, this.borderAlpha);
        }

        //define gradient box {
            var mx : Matrix = new Matrix();
            mx.createGradientBox(
                (this.width < 0 ? w.w : this.width),
                (this.height < 0 ? w.h : this.height),
                this.rotation,
                this.tx,
                this.ty
            );
        //}

        this._adjustArrays();

        w.graphics.beginGradientFill((this.type == 'linear' ? GradientType.LINEAR : GradientType.RADIAL), this.colors, this.alphas, this.ratios, mx);

        //workaround for cpp bug with zero radius corners
        if( this.corners == null || this.corners.length == 0 ){
            w.graphics.drawRect(0, 0, w.w, w.h);
        }else if( this.corners.length == 1 ){
            w.graphics.drawRoundRect(0, 0, w.w, w.h, this.corners[0], this.corners[0]);
        }else{
            w.graphics.drawRoundRect(0, 0, w.w, w.h, this.corners[0], this.corners[1]);
        }

        w.graphics.endFill();
    }//function apply()


    /**
    * Set `.alphas` and `.ratios` according to `.colors` if they were not set manually
    *
    */
    private inline function _adjustArrays () : Void {
        if( this.colors == null ){
            this.colors = [0x000000, 0xFFFFFF];
        }else if( this.colors.length < 2 ){
            this.colors.push(0xFFFFFF);
        }

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
    }//function _adjustArrays()
}//class Gradient