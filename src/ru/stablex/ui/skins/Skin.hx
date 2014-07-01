package ru.stablex.ui.skins;

import ru.stablex.ui.widgets.Widget;



/**
* Basic Skin system class. Use it to implement your own skinning mechanics.
*
*/
class Skin {

    //helper property wich indicates, whether skin should call `.graphics.clear()` on widget
    public var clear : Bool = true;


    /**
    * Constructor
    *
    */
    public function new () : Void {
    }//function new()


    /**
    * Apply skin to specified widget
    * This method clears widget.graphics (if this.clear == true) and calls draw/reDraw/unDraw depending on the situation
    */
    @:access(ru.stablex.ui.widgets.Widget._appliedSkin)
    public function apply (w:Widget) : Void{
        if( this.clear ){
            w.graphics.clear();
        }

        if (w._appliedSkin != null) {
          if (w._appliedSkin == this) {
            this.reDraw(w);
          } else {
            w._appliedSkin.unDraw(w);
            this.draw(w);
          }
        } else {
          this.draw(w);
        }
        w._appliedSkin = this;
    }//function apply()


    /**
    * Actual drawings on widget.
    * Override this method to implement custom skin processor.
    */
    private function draw (w:Widget) : Void {
    }//function draw()

    /**
    * Undo drawing to a widget, to which this is drawn.
    * Override this method to implement custom skin processor.
    */
    private function unDraw (w:Widget) : Void {
    }//function unDraw()

    /**
    * Redo drawing to a widget, to which this is drawn.
    * Override this method to implement custom skin processor.
    */
    private function reDraw (w:Widget) : Void {
      unDraw(w);
      draw(w);
    }//function renDraw()


    /**
    * Cast this instance to specified class
    *
    */
    public inline function as<T> (cls:Class<T>) : Null<T> {
        return (Std.is(this, cls) ? cast this : null);
    }//function as()
}//class Skin