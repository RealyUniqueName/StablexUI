package ru.stablex.ui.widgets;

import nme.text.TextField;
import nme.text.TextFormat;
import ru.stablex.Err;
import ru.stablex.ui.UIBuilder;


/**
* Text field
*/
class Text extends Box{
    //<type>nme.display.TextField</type> used to render text
    public var label  : TextField;
    //Text format wich will be aplied to label on refresh
    public var format : TextFormat;
    public var highlightFormat : TextFormat;
    //Getter-setter for text.
    public var text (_getText,_setText) : String;


    /**
    * Constructor
    *
    */
    public function new() : Void {
        super();

        this.label = cast(this.addChild(new TextField()), TextField);
        this.label.autoSize  = nme.text.TextFieldAutoSize.LEFT;
        this.label.multiline = true;

        this.format = this.label.defaultTextFormat;
        this.highlightFormat = this.label.defaultTextFormat;

        this.align    = 'top,left';
    }//function new()


    /**
    * Refresh widget. Apply format to text, update text alignment and re-apply skin
    *
    */
    override public function refresh() : Void {
        this.label.defaultTextFormat = this.format;
        this.label.setTextFormat(this.format);

        if( !this.autoWidth && this.label.wordWrap ){
            this.label.width = this._width;
        }

        super.refresh();
    }//function refresh()

    /**
     *  Highlight the widget by setting its format
     */
    public function highlightText () : Void {
        if (this.highlightFormat != null) {
            this.label.setTextFormat(this.highlightFormat);
            super.refresh();
        }
    }//function highlight()
    
    /**
     *  Unhighlight the widget by setting its format back to normal
     */
    public function unhighlight () : Void {
        this.label.setTextFormat(this.format);
        super.refresh();
    }//function unhighlight()

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