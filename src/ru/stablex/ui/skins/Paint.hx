package ru.stablex.ui.skins;

import ru.stablex.ui.widgets.Widget;


/**
* Fill widget with color
*
*/
class Paint implements ISkin{

    //use this color to fill
    public var color : Int = 0xFFFFFF;
    /**
    * Background alpha for coloring. Default - 0.
    * If bgAlpha = 0, background won't be colored at all.
    */
    public var alpha : Float = 1;
    //border width
    public var border : Float = 0;
    //border color
    public var borderColor : Int = 0x000000;
    //border alpha
    public var borderAlpha : Float = 1;
    //define corner radius for filling with color. Format: [elipseWidth, elipseHeight] or [radius], e.g. [10, 20] or [20]
    public var corners : Array<Float>;


    /**
    * Constructor
    *
    */
    public function new () : Void {
    }//function new()


    /**
    * Apply skin to widget
    *
    */
    public function apply (w:Widget) : Void {
        w.graphics.clear();

        if( this.border > 0 ){
            w.graphics.lineStyle(this.border, this.borderColor, this.borderAlpha);
        }

        w.graphics.beginFill(this.color, this.alpha);

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
}//class Paint