package ru.stablex.ui.layouts;

import flash.display.DisplayObject;
import ru.stablex.ui.misc.SizeTools;
import ru.stablex.ui.widgets.Widget;
import ru.stablex.ui.widgets.Box; // To accrss static method _objWidth



/**
* Column layout.
*
*/
class Column extends Layout{
    //Setter for padding left, right, top, bottom.
    public var padding (never,set) : Float;
    //padding left
    public var paddingLeft   : Float = 0;
    //padding right
    public var paddingRight  : Float = 0;
    //padding top
    public var paddingTop    : Float = 0;
    //padding bottom
    public var paddingBottom : Float = 0;
    //Distance between children
    public var cellPadding : Float = 0;
    //Set children widget size according to column size
    public var fit(null, set) : Bool;
    public var fitWidth : Bool = true;
    public var fitHeight : Bool = true;
    // Vertical alignment (middle,bottom,top)
    public var vAlign : String = "top";
    /**
    * Columns sizes.
    *  - positive numbers greater than 1 define column width in pixels;
    *  - positive numbers between 0 and 1 define column width in % (0.1 for 10%, 0.65 for 65%, etc.);
    *  - negative numbers mean columns will share free space left after using previous rules.
    *  - zero means, the column will take the space of the containing widget
    * E.g. [150, -2, -1, 0.3] means: first child will be 150 pixels width, last
    * child will be 30% width, the second and third children will take left space,
    * and second will take 2/3 of left space, while third will take 1/3.
    */
    public var cols : Array<Float>;

/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/



/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/

    /**
    * Position children of provided widget according to layout logic
    *
    */
    override public function arrangeChildren(holder:Widget) : Void {
        if( this.cols == null || this.cols.length == 0 ) return;

        //calc absolute values {
            var acols     : Array<Float> = [];
            var width     : Float = holder.w - this.paddingLeft - this.paddingRight - (this.cols.length - 1) * this.cellPadding;
            var negParts  : Float = 0;
            var freeSpace : Float = width;

            //calc absolute and % values
            for(i in 0...this.cols.length){
                if( this.cols[i] > 1 ){
                    freeSpace -= acols[i] = this.cols[i];
                }else if( this.cols[i] < 0 ){
                    negParts += acols[i] = this.cols[i];
                }else if (this.cols[i] == 0){
                    freeSpace -= acols[i] = SizeTools.width(holder.getChildAt(i));
                }else{
                    freeSpace -= acols[i] = width * this.cols[i];
                }
            }

            //calc negative values
            for(i in 0...acols.length){
                if( acols[i] < 0 ){
                    acols[i] = freeSpace * acols[i] / negParts;
                }
            }
        //}

        //set holder's children parameters
        var child : DisplayObject;
        var left  : Float = this.paddingLeft;
        for(i in 0...acols.length){
            if( holder.numChildren <= i ) break;
            child = holder.getChildAt(i);

            //position
            if( Std.is(child, Widget) ){
                cast(child, Widget).left = left;
                switch(vAlign) {
                    case "top":    cast(child, Widget).top    = paddingTop;
                    case "bottom": cast(child, Widget).bottom = paddingBottom;
                    case "middle": cast(child, Widget).top    = paddingTop + (holder.h - paddingTop - paddingBottom - cast(child,Widget).h)/2.0;
                }
            }else{
                child.x = left;
                switch(vAlign) {
                    case "top":    child.y = paddingTop;
                    case "bottom": child.y = paddingBottom - child.height;
                    case "middle": child.y = paddingTop + (holder.h - paddingTop - paddingBottom - child.height)/2.0;
              }
            }

            //size
            if( this.fitWidth && Std.is(child, Widget) ){
                cast(child, Widget).resize(acols[i], fitHeight?(holder.h - this.paddingTop - this.paddingBottom):cast(child,Widget).h);
            }

            left += acols[i] + this.cellPadding;
        }//for()
    }//function arrangeChildren()

/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

    /**
      * Setter `fit`.
      *
      */
    @:noCompletion private function set_fit (fit:Bool) : Bool {
      fitWidth = fit;
      fitHeight = fit;
      return fit;
    }//function set_fit

    /**
    * Setter `padding`.
    *
    */
    @:noCompletion private function set_padding (padding:Float) : Float {
        return this.paddingLeft = this.paddingRight = this.paddingTop = this.paddingBottom = padding;
    }//function set_padding
}//class Column