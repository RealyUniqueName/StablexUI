package ru.stablex.backend.display;


#if (flash || openfl)
typedef Stage = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("flash", "display.Stage")]>;

#else
typedef Stage = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "display.Stage.Stage", "display.Stage.StageRef")]>;

/**
* Reference for Stage implementation
*
*/
class StageRef extends DisplayObjectContainer{

    /** width of the Stage */
    public var stageWidth : Float = 0;
    /** height of the Stage */
    public var stageHeight : Float = 0;

}//class StageRef

#end