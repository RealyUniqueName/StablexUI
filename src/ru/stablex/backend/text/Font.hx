package ru.stablex.backend.text;


#if (flash || openfl)
typedef Font = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("flash", "text.Font")]>;

#else
typedef Font = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "text.Font", "text.Font.FontRef")]>;

/**
* Reference for Font implementation
*
*/
class FontRef {

    /**
    * Constructor
    *
    */
    public function new () : Void {
        //code...
    }//function new()

}//class FontRef

#end
