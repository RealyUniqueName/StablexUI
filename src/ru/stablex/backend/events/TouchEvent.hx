package ru.stablex.backend.events;

#if (flash || openfl)
typedef TouchEvent = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("flash", "events.TouchEvent")]>;

#else
typedef TouchEvent = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("flash", "events.TouchEvent", "events.TouchEvent")]>;

/**
* Reference for TouchEvent implementation
*
*/
class TouchEvent extends Event{
    /** for descriptions of events see docs for flash.event.TouchEvent */
    static public var TOUCH_OUT = 'touchOut';

}//class TouchEvent

#end