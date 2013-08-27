package starlingbackend.text;

import ru.stablex.backend.text.TextFormat;


/**
* TextField implementation
*
*/
class TextField extends starling.text.TextField{

    /** get text width */
    public var textWidth (get,never) : Float;
    /** get text height */
    public var textHeight (get,never) : Float;

    /**
    * For compatibility (we don't need these properties in this project) {
    */
        public var defaultTextFormat : TextFormat;
        public var wordWrap : Bool = false;
        public function setTextFormat (format:TextFormat, beginIndex:Int = -1, endIndex:Int = -1) : Void {}
    /*
    * }
    */


    /**
    * Constructor
    *
    */
    public function new (width:Int = 100, height:Int = 100, text:String = '', fontName:String = 'Verdana', fontSize:Int = 12, color:Int = 0x0, bold:Bool = false) : Void {
        super(width, height, text, fontName, fontSize, color, bold);
        this.autoSize = starling.text.TextFieldAutoSize.BOTH_DIRECTIONS;
        this.vAlign = starling.utils.VAlign.TOP;
        this.hAlign = starling.utils.HAlign.LEFT;
    }//function new()


    /**
    * Getter `textWidth`.
    *
    */
    private function get_textWidth () : Float {
        return this.textBounds.width;
    }//function get_textWidth


    /**
    * Getter `textHeight`.
    *
    */
    private function get_textHeight () : Float {
        return this.textBounds.height;
    }//function get_textHeight


}//class TextField