package ru.stablex.backend.display;

#if (flash || openfl)
typedef Sprite = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "display.SpriteExt")]>;

#else
typedef Sprite = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "display.Sprite.SpriteRef")]>;

/**
* Reference for Sprite implementation
*
*/
class Sprite extends DisplayObjectRef {


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