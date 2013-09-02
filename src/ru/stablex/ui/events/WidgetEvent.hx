package ru.stablex.ui.events;

import flash.events.Event;
import ru.stablex.ui.widgets.Widget;

/**
* Events dispatched by widgets
*/

class WidgetEvent extends Event{

    //Dispatched when widget is created
    static public inline var CREATE = 'widgetCreate';
    //Dispatched when widget is destroyed (called .free() method)
    static public inline var FREE   = 'widgetFree';
    //Dispatched when widget is resized and widget.created = true
    static public inline var RESIZE = 'widgetResize';
    //Dispatched when widget is resized and widget.created = false
    static public inline var INITIAL_RESIZE = 'widgetInitialResize';
    //Dispatched when widget value/state is changed (check boxes, radio buttons, toggles etc.)
    static public inline var CHANGE = 'widgetChange';
    //Dispatched when scrolling was started
    static public inline var SCROLL_START = 'widgetScrollStart';
    //Dispatched when scrolling was stopped
    static public inline var SCROLL_STOP = 'widgetScrollStop';
    //Dispatched when a widget is added to another
    static public inline var ADDED = 'widgetAdded';
    //Dispatched when a widget is removed from another
    static public inline var REMOVED = 'widgetRemoved';

    public var widget : Widget;

    /**
    * Constructor
    *
    */
    public function new(type:String, ?widget:Widget) : Void {
        super(type);
        this.widget = widget;
    }//function new()
}//class WidgetEvent