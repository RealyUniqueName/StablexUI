package ru.stablex.ui.skins;

import ru.stablex.ui.widgets.Widget;


/**
* Fill widget with color
*
*/
class Paint extends Rect{

    //use this color to fill. Negative values for no fill
    public var color : Int = -1;
    //Background alpha for coloring.
    public var alpha : Float = 1;


    /**
    * Draw skin on widget
    *
    */
    override public function draw (w:Widget) : Void {
        if( this.color >= 0 ){
            w.graphics.beginFill(this.color, this.alpha);
        }

        super.draw(w);

        if( this.color >= 0 ){
            w.graphics.endFill();
        }
    }//function draw()
}//class Paint