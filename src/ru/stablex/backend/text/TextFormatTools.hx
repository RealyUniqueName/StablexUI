package ru.stablex.backend.text;

#if (flash || openfl)
typedef TextFormatTools = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "text.TextFormatTools", "text.TextFormatToolsFlash")]>;

#else
typedef TextFormatTools = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "text.TextFormatTools", "text.TextFormatTools.TextFormatToolsRef")]>;



/**
* Reference to implement methods for bitmapdata drawings on sprites
*
*/
class TextFormatToolsRef {


    /**
    * Create a copy of TextFormat instance
    *
    */
    static public function copy (source:TextFormat) : TextFormat {
        return new TextFormat();
    }//function copy()


    /**
    * Instantiating is not allowed
    *
    */
    private function new () : Void {
    }//function new()

}//class TextFormatToolsRef

#end
