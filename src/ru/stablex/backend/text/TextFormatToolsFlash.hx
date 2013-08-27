package ru.stablex.backend.text;

#if (flash || openfl)



/**
* TextFormatTools implementation for flash and openfl
*
*/
class TextFormatToolsFlash {


    /**
    * Create a copy of TextFormat instance
    *
    */
    static public function copy (source:TextFormat) : TextFormat {
        return new TextFormat(
            source.font,
            source.size,
            source.color,
            source.bold,
            source.italic,
            source.underline,
            source.url,
            source.target,
            source.align,
            #if html5
                Std.int(source.leftMargin),
                Std.int(source.rightMargin),
                Std.int(source.indent),
                Std.int(source.leading)
            #else
                source.leftMargin,
                source.rightMargin,
                source.indent,
                source.leading
            #end
        );
    }//function copy()


    /**
    * Instantiating is not allowed
    *
    */
    private function new () : Void {
    }//function new()

}//class TextFormatToolsFlash

#end