package ru.stablex.ui.widgets;

import nme.text.TextField;
import nme.text.TextFormat;
import ru.stablex.Err;
import ru.stablex.ui.UIBuilder;


/**
* Text field
*/
class Text extends Box{
    //nme.display.TextField used to render text
    public var label  : TextField;
    //Text format wich will be aplied to label on refresh
    public var format : TextFormat;
    // //Should we set widget .w and .h according to label .width and .height?
    // public var autoSize : Bool = true;
    //Getter-setter for text.
    public var text (_getText,_setText) : String;


    /**
    * Constructor
    *
    */
    public function new() : Void {
        super();

        this.label = cast(this.addChild(new TextField()), TextField);
        this.label.autoSize = nme.text.TextFieldAutoSize.LEFT;

        this.format = this.label.defaultTextFormat;

        this.autoSize = true;
    }//function new()


    /**
    * Refresh widget. Apply format to text and update text alignment
    *
    */
    override public function refresh() : Void {
        this.label.defaultTextFormat = this.format;
        this.label.setTextFormat(this.format);

        super.refresh();
    }//function refresh()


    /**
    * Text getter
    *
    */
    private function _getText() : String {
        return this.label.text;
    }//function _getText()


    /**
    * Text setter
    *
    */
    private function _setText(txt:String) : String {
        this.label.text = txt;
        if( this.autoWidth || this.autoHeight ){
            this.refresh();
        }else{
            this.alignElements();
        }
        return txt;
    }//function _setText()

}//class Text