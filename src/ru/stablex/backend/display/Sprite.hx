package ru.stablex.backend.display;

import ru.stablex.backend.geom.Rectangle;

#if (flash || openfl)
typedef Sprite = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "display.SpriteFlash")]>;

#else
typedef Sprite = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "display.Sprite.SpriteRef")]>;

/**
* Reference for Sprite implementation
*
*/
class Sprite extends DisplayObjectRef {
    /** Rectangle to specify visible area of this sprite */
    public var scrollRect : Rectangle = null;

    /** Mouse X coordinates in axes of this sprite */
    public var mouseX : Float = 0;
    /** Mouse Y coordinates in axes of this sprite */
    public var mouseY : Float = 0;
    /** Enable mouse pointer interactions */
    public var mouseEnabled : Bool = true;
    /** Enable mouse pointer interactions for children of this sprite*/
    public var mouseChildren : Bool = true;

    /**
    * Removes all listeners registered for this event
    *
    */
    public function clearEvent (eventType:String) : Void {
        //code...
    }//function clearEvent()


    /**
    * Remove all attached event listeners
    *
    */
    public function clearAllEvents () : Void {
    }//function clearAllEvents()


    /**
    * Add event listener only if this listener is still not added to this object
    *
    * @return whether listener was added
    */
    public function addUniqueListener (type:String, listener:Dynamic->Void) : Bool{
        return false;
    }//function addEventListener()


}//class Sprite extends DisplayObjectRef

#end