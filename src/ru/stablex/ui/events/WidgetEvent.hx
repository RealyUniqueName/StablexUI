package ru.stablex.ui.events;

import nme.events.Event;


/**
* Events on creating / destroying widgets
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
}//class WidgetEvent