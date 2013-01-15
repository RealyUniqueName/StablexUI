 package;

import ru.stablex.ui.widgets.Widget;


/**
* Draw fractal rectangles
*
*/
class Fractal implements ISkin{

    //Thickness of line used to draw rectangles
    public var lineThickness : Int = 2;
    //Color of line used to draw rectangles
    public var lineColor : Int = 0x000000;
    //step between rectangles in pixels
    public var step : Int = 10;

    /**
    * Constructor of skin class must take no necessary arguments.
    *
    */
    public function new () : Void {
    }//function new()


    /**
    * Apply skin to widget
    *
    */
    public function apply (widget:Widget) : Void {
        //make sure `step` is valid
        if( this.step <= 0 ) this.step = 10;

        //size of initial rectangle
        var width  : Float = widget.w;
        var height : Float = widget.h;

        //top-left corner of initial rectangle
        var x : Int = 0;
        var y : Int = 0;

        widget.graphics.clear();
        widget.graphics.lineStyle(this.lineThickness, this.lineColor);

        //draw rectangles
        while( width > this.step && height > this.step ){

            widget.graphics.drawRect(x, y, width, height);

            width  -= this.step;
            height -= this.step;

            x += this.step;
            y += this.step;
        }//while()
    }//function apply()
}//class Fractal