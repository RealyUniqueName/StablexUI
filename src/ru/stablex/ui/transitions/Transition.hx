package ru.stablex.ui.transitions;

import flash.display.DisplayObject;
import ru.stablex.ui.widgets.Widget;



/**
* Base class for implementing transitions on child changing for <type>ru.stablex.ui.widgets.Widget</type>, for exmaple <type>ru.stablex.ui.widgets.ViewStack</type>
*
*/
class Transition {

    //Duration of transition in seconds
    public var duration : Float = 1;
    //Easing method to use
    public var easing : String = 'Linear.easeNone';


    /**
    * Constructor
    *
    */
    public function new () : Void {
    }//function new()


    /**
    * This method must hide `toHide` object and make visible `toShow` object
    *
    * @param cb - callback to call after visible object was hidden
    */
    public function change (vs:Widget, toHide:DisplayObject, toShow:DisplayObject, cb:Void->Void = null, reverse : Bool = false) : Void{
    }//function change()


    /**
    * Cast this instance to specified class
    *
    */
    public inline function as<T> (cls:Class<T>) : Null<T> {
        return (Std.is(this, cls) ? cast this : null);
    }//function as()
}//interface Transition
