package ru.stablex.backend;

#if (flash || openfl)
typedef Lib = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("flash", "Lib")]>;

#else
typedef Lib = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "Lib", "Lib.LibRef")]>;


/**
* Reference for Lib implementation
*
*/
class LibRef {

    /**
    * Root sprite on stage.
    * `.stage` property of this sprite must not be null
    */
    static public var current : Sprite;


    /**
    * Constructor
    *
    */
    public function new () : Void {
        //code...
    }//function new()

}//class LibRef

#end