package ru.stablex.backend.utils;

#if (flash || openfl)
typedef ByteArray = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("flash", "utils.ByteArray")]>;

#else
typedef ByteArray = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "utils.ByteArray.ByteArrayRef")]>;

/**
* Reference for ByteArray implementation
*
*/
class ByteArrayRef {

    /**
    * Constructor
    *
    */
    public function new () : Void {
        //code...
    }//function new()

}//class ByteArrayRef
#end
