package ru.stablex.backend.events;

#if (flash || openfl)
typedef Event = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("flash", "events.Event")]>;

#else
typedef Event = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "events.Event.EventRef")]>;


/**
* Reference for Event class implementation
*
*/
class EventRef {
    /** for descriptions of events see docs for flash.event.Event */
    static public var ENTER_FRAME    = 'enterFrame';
    static public var ADDED_TO_STAGE = 'addedToStage';
    static public var RESIZE         = 'resize';

    /** event type */
    public var type : String;
    /** Indicates whether an event is a bubbling event */
    public var bubbles : Bool = false;
    /** The event target */
    public var target : Dynamic;
    /** The object that is actively processing the Event object with an event listener */
    public var currentTarget : Dynamic;


    /**
    * Constructor
    *
    */
    public function new (type:String, bubbles:Bool = false) : Void {
        this.type    = type;
        this.bubbles = bubbles;
    }//function new()

}//class EventRef

#end
