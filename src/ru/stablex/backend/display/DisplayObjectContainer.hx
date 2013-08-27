package ru.stablex.backend.display;


#if (flash || openfl)
typedef DisplayObjectContainer = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("flash", "display.DisplayObjectContainer")]>;

#else
typedef DisplayObjectContainer = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "display.DisplayObjectContainer.DisplayObjectContainer", "display.DisplayObjectContainer.DisplayObjectContainerRef")]>;

/**
* Reference for DisplayObjectContainer implementation.
*
*/
class DisplayObjectContainerRef extends DisplayObject{


}//class DisplayObjectContainerRef

#end