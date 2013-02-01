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
    * This method clears widget.graphics (if this.clear == true) and calls `.draw(w)` (see below)
    */
    public function apply (w:Widget) : Void{
        if( this.clear ){
            w.graphics.clear();
        }

        this.draw(w);
    }//function apply()


    /**
    * Actual drawings on widget.
    * Override this method to implement custom skin processor.
    */
    public function draw (w:Widget) : Void {
    }//function draw()


    /**
    * Cast this instance to specified class
    *
    */
    public inline function as<T> (cls:Class<T>) : Null<T> {
        return (Std.is(this, cls) ? cast this : null);
    }//function as()
}//class Skin