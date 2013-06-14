package ru.stablex.ui.events;

import flash.events.Event;



/**
* Events for <type>ru.stablex.ui.widgets.Scroll</type> widget
*
*/
class ScrollEvent extends Event{
    //dispatched when scrolling is about to start
    static public inline var BEFORE_SCROLL = "scrollBefore";

    //whether scrolling should be cancaled
    public var canceled (default,null) : Bool = false;
    /**
    * Event, wich started scrolling process
    * <type>flash.events.MouseEvent</type>.WHEEL_EVENT for scrolling by wheel,
    * <type>flash.events.MouseEvent</type>.MOUSE_DOWN for scrolling by dragging, etc.
    */
    public var srcEvent (default, null) : Event;


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
    public function new(type:String, source:Event) : Void {
        super(type);
        this.srcEvent = source;
    }//function new()


    /**
    * Cancel scrolling
    *
    */
    public function cancel() : Void {
        this.canceled = true;
    }//function cancel()


    /**
    * Cast `.srcEvent` to specified class
    *
    */
    public inline function srcAs<T> (cls:Class<T>) : Null<T> {
        return (Std.is(this.srcEvent, cls) ? cast this.srcEvent : null);
    }//function as()


/*******************************************************************************
*   GETTERS / SETTERS
*******************************************************************************/



}//class ScrollEvent