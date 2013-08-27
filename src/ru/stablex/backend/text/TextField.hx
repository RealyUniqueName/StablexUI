package ru.stablex.backend.text;


#if (flash || openfl)
typedef TextField = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "text.TextFieldFlash")]>;

#else
import ru.stablex.backend.display.DisplayObject;

typedef TextField = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "text.TextField.TextFieldRef")]>;

/**
* Reference for TextField implementation
*
*/
class TextFieldRef extends DisplayObject{

    /**
    * Specifies the format applied to newly inserted text.
    * Must not be null
    */
    public var defaultTextFormat : TextFormat;
    /** Content of text field */
    public var text : String;
    /** enable/disable word wrapping */
    public var wordWrap : Bool = false;


    /**
    * Applies the text formatting that the format parameter specifies to the specified text in a text field
    *
    */
    public function setTextFormat (format:TextFormat, beginIndex:Int = -1, endIndex:Int = -1) : Void {
        //code...
    }//function setTextFormat()


}//class TextFieldRef

#end