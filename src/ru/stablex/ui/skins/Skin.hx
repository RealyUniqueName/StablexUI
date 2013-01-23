package ru.stablex.ui.skins;

import ru.stablex.ui.widgets.Widget;



/**
* Basic Skin system class. Use it to implement your own skinning mechanics.
*
*/
class Skin {
    /**
    * Constructor
    *
    */
    public function new () : Void {
    }//function new()


    /**
    * Apply skin to specified widget
    *
    */
    public function apply (w:Widget) : Void{
    }//function apply()


    /**
    * Cast this instance to specified class
    *
    */
    public inline function as<T> (cls:Class<T>) : Null<T> {
        return (Std.is(this, cls) ? cast this : null);
    }//function as()
}//class Skin