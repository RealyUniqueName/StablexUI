package ru.stablex.backend.text;

#if (flash || openfl)
typedef TextFormat = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("flash", "text.TextFormat")]>;

#else
typedef TextFormat = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "text.TextFormat", "text.TextFormat.TextFormatRef")]>;

/**
* Reference for Textformat implementation
*
*/
class TextFormatRef {

    /**
    * Constructor
    *
    */
    public function new () : Void {
        //code...
    }//function new()

}//class TextFormatRef

#end