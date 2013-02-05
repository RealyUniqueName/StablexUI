package ru.stablex.ui.transitions;

import nme.display.DisplayObject;
import ru.stablex.ui.widgets.ViewStack;



/**
* Base class for implementing transitions on child changing for <type>ru.stablex.ui.widgets.ViewStack</type>
*
*/
class Transition {

    //Duration of transition in seconds
    public var duration : Float = 1;


    /**
    * Constructor
    *
    */
    public function new () : Void {
    }//function new()


    /**
    * This method must hide `toHide` object and make visible `toShow` object
    *
    */
    public function change (vs:ViewStack, toHide:DisplayObject, toShow:DisplayObject) : Void{
    }//function change()


    /**
    * Cast this instance to specified class
    *
    */
    public inline function as<T> (cls:Class<T>) : Null<T> {
        return (Std.is(this, cls) ? cast this : null);
    }//function as()
}//interface Transition