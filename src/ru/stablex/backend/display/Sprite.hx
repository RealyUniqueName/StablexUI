package ru.stablex.backend.display;

import ru.stablex.backend.geom.Rectangle;

#if (flash || openfl)
typedef Sprite = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "display.Sprite", "display.SpriteFlash")]>;

#else
typedef Sprite = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "display.Sprite", "display.Sprite.SpriteRef")]>;

/**
* Reference for Sprite implementation
* It's up to you to make sure `sx*Child` methods are being called if 'native' `*Child` methods of sprites get called.
* E.g. you need to override `addChild` so it becomes alias for `sxAddChild`.
* See SpriteFlash for examples
*/
class SpriteRef extends DisplayObjectRef {
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
    * Clear all drawings on this sprite
    *
    */
    public function clearGraphics () : Void {
        //code...
    }//function clearGraphics()


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


    /**
    * Add child to display list of this container
    *
    */
    public function sxAddChild (child:DisplayObject) : DisplayObject {
        return child;
    }//function sxAddChild()


    /**
    * Remove child from display list
    *
    */
    public function sxRemoveChild (child:DisplayObject) : DisplayObject {
        return child;
    }//function sxRemoveChild()


    /**
    * Add child at specified index in display list
    *
    */
    public function sxAddChildAt (child:DisplayObject, index:Int) : DisplayObject {
        return child;
    }//function sxAddChildAt()


    /**
    * Remove child from specified index in display list
    *
    */
    public function sxRemoveChildAt (index:Int) : DisplayObject {
        return child;
    }//function sxRemoveChildAt()


    /**
    * Swap children in display list.
    * Required by transitions of ViewStack only.
    *
    */
    public function sxSwapChildren (child1:DisplayObject, child2:DisplayObject) : Void {
    }//function sxSwapChildren()

}//class SpriteRef

#end