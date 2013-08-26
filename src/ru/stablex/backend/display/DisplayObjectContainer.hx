package ru.stablex.backend.display;

import ru.stablex.backend.display.DisplayObject;

#if (flash || openfl)
typedef DisplayObjectContainer = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("flash", "display.DisplayObjectContainer")]>;

#else
typedef DisplayObjectContainer = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "display.DisplayObjectContainer.DisplayObjectContainerRef")]>;

/**
* Reference for DisplayObjectContainer implementation
*
*/
class DisplayObjectContainerRef extends DisplayObject{


    /**
    * Add child to display list of this container
    *
    */
    public function addChild (child:DisplaObject) : DisplayObject {
        return child;
    }//function addChild()


    /**
    * Remove child from display list
    *
    */
    public function removeChild (child:DisplayObject) : DisplayObject {
        return child;
    }//function removeChild()


    /**
    * Add child at specified index in display list
    *
    */
    public function addChildAt (child:DisplayObject, index:Int) : DisplayObject {
        return child;
    }//function addChildAt()


    /**
    * Remove child from specified index in display list
    *
    */
    public function removeChildAt (index:int) : DisplayObject {
        return null;
    }//function removeChildAt()


    /**
    * Swap children in display list.
    * Required by transitions of ViewStack only.
    *
    */
    public function swapChildren (child1:DisplayObject, child2:DisplayObject) : Void {
        //code...
    }//function swapChildren()


}//class DisplayObjectContainerRef

#end