package ru.stablex.ui.skins;

import ru.stablex.ui.widgets.Widget;



/**
* Draws a rectangle
*
*/
class Rect extends Skin{

    //border width
    public var border : Float = 0;
    //border color
    public var borderColor : Int = 0x000000;
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


    /**
    * Setter for padding
    *
    */
    @:noCompletion private function set_padding (p:Float) : Float {
        this.paddingTop = this.paddingBottom = this.paddingRight = this.paddingLeft = p;
        return p;
    }//function set_padding()


    /**
    * Draw skin on widget
    *
    */
    override public function draw (w:Widget) : Void {
        var width  : Float = w.w - this.paddingLeft - this.paddingRight;
        var height : Float = w.h - this.paddingTop - this.paddingBottom;

        //if size is wrong, draw nothing
        if( width <= 0 || height <= 0 ) return;

        if( this.border > 0 ){
            w.graphics.lineStyle(this.border, this.borderColor, this.borderAlpha);
        }

        if( this.corners == null || this.corners.length == 0 ){
            w.graphics.drawRect(
                this.paddingLeft,
                this.paddingTop,
                width,
                height
            );
        }else if( this.corners.length > 0 ){
            w.graphics.drawRoundRect(
                this.paddingLeft,
                this.paddingTop,
                width,
                height,
                this.corners[0],
                (this.corners.length > 1 ? this.corners[1] : this.corners[0])
            );
        }
    }//function draw()


}//class Rect