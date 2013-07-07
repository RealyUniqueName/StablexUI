package ru.stablex.ui.layouts;

import flash.display.DisplayObject;
import ru.stablex.ui.widgets.Widget;



/**
* Row layout.
*
*/
class Row extends Layout{
    //Setter for padding left, right, top, bottom.
    public var padding (never,set_padding) : Float;
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
    public var fit : Bool = true;
    /**
    * Rows sizes.
    *  - positive numbers greater than 1 define row height in pixels;
    *  - positive numbers between 0 and 1 define row height in % (0.1 for 10%, 0.65 for 65%, etc.);
    *  - negative numbers mean columns will share free space left after using previous rules.
    * E.g. [150, -2, -1, 0.3] means: first child will be 150 pixels height, last
    * child will be 30% height, the second and third children will take left space,
    * and second will take 2/3 of left space, while third will take 1/3.
    */
    public var rows : Array<Float>;

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
        if( this.rows == null || this.rows.length == 0 ) return;

        //calc absolute values {
            var arows     : Array<Float> = [];
            var height    : Float = holder.h - this.paddingTop - this.paddingBottom - (this.rows.length - 1) * this.cellPadding;
            var negParts  : Float = 0;
            var freeSpace : Float = height;

            //calc absolute and % values
            for(i in 0...this.rows.length){
                if( this.rows[i] > 1 ){
                    freeSpace -= arows[i] = this.rows[i];
                }else if( this.rows[i] < 0 ){
                    negParts += arows[i] = this.rows[i];
                }else{
                    freeSpace -= arows[i] = height * this.rows[i];
                }
            }

            //calc negative values
            for(i in 0...arows.length){
                if( arows[i] < 0 ){
                    arows[i] = freeSpace * arows[i] / negParts;
                }
            }
        //}

        //set holder's children parameters
        var child : DisplayObject;
        var top  : Float = this.paddingTop;
        for(i in 0...arows.length){
            if( holder.numChildren <= i ) break;
            child = holder.getChildAt(i);

            //position
            if( Std.is(child, Widget) ){
                cast(child, Widget).top = top;
                cast(child, Widget).left = this.paddingLeft;
            }else{
                child.x = this.paddingLeft;
                child.y = top;
            }

            //size
            if( this.fit && Std.is(child, Widget) ){
                cast(child, Widget).resize(holder.w - this.paddingLeft - this.paddingRight, arows[i]);
            }

            top += arows[i] + this.cellPadding;
        }//for()
    }//function arrangeChildren()

/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

    /**
    * Setter `padding`.
    *
    */
    @:noCompletion private function set_padding (padding:Float) : Float {
        return this.paddingLeft = this.paddingRight = this.paddingTop = this.paddingBottom = padding;
    }//function set_padding
}//class Row