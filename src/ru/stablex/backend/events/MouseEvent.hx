package ru.stablex.backend.events;

#if (flash || openfl)
typedef MouseEvent = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("flash", "events.MouseEvent")]>;

#else
typedef MouseEvent = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "events.MouseEvent", "events.MouseEvent.MouseEventRef")]>;


/**
* Reference for MouseEvent implementation
*
*/
class MouseEventRef extends Event{

    /** for descriptions of events see docs for flash.event.MouseEvent */
    static public var CLICK       = 'click';
    static public var MOUSE_DOWN  = 'mouseDown';
    static public var MOUSE_UP    = 'mouseUp';
    static public var MOUSE_OVER  = 'mouseOver';
    static public var MOUSE_OUT   = 'mouseOut';
    static public var MOUSE_WHEEL = 'mouseWheel';

    /** Indicates how many lines should be scrolled for each unit the user rotates the mouse wheel */
    public var delta : Int = 0;
    /** Indicates whether the Alt key is active (true) or inactive (false) */
    public var altKey : Bool = false;
    /** On Windows or Linux, indicates whether the Ctrl key is active (true) or inactive (false) */
    public var ctrlKey : Bool = false;
    /** Indicates whether the Shift key is active (true) or inactive (false) */
    public var shiftKey : Bool = false;

}//class MouseEventRef

#end
