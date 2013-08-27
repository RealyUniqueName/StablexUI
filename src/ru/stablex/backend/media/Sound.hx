package ru.stablex.backend.media;

#if (flash || openfl)
typedef Sound = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("flash", "media.Sound")]>;

#else
typedef Sound = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "media.Sound.SoundRef")]>;

/**
* Reference for Sound implementation
*
*/
class SoundRef {

    /**
    * Constructor
    *
    */
    public function new () : Void {
        //code...
    }//function new()

}//class SoundRef

#end