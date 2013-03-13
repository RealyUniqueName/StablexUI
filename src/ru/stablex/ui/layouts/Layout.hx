package ru.stablex.ui.layouts;

import ru.stablex.ui.widgets.Widget;


/**
* Basic layout manager class
*
*/
class Layout {



/*******************************************************************************
*   STATIC METHODS
*******************************************************************************/



/*******************************************************************************
*   INSTANCE METHODS
*******************************************************************************/

    /**
    * Constructor
    *
    */
    public function new () : Void {
    }//function new()


    /**
    * Position children of provided widget according to layout logic
    *
    */
    public function arrangeChildren(Widget:Widget) : Void {

    }//function arrangeChildren()



    /**
    * Cast this instance to specified class
    *
    */
    public inline function as<T:Layout> (cls:Class<T>) : Null<T> {
        return (Std.is(this, cls) ? cast this : null);
    }//function as()

/*******************************************************************************
*   GETTERS / SETTERS
*******************************************************************************/



}//class Layout