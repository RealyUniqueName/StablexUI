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
    //Text format for higlight mode
    public var highlightFormat (_getHighlightFormat,_setHightlightFormat) : TextFormat;
    private var _hightlightFormat : TextFormat;
    //indicates highlighting state
    public var highlighted (default,null) : Bool = false;
    //Getter-setter for text.
    public var text (_getText,_setText) : String;


    /**
    * Constructor
    *
    */
    public function new() : Void {
        super();

        this.label = cast(this.addChild(new TextField()), TextField);
        this.label.autoSize   = nme.text.TextFieldAutoSize.LEFT;
        this.label.multiline  = true;
        // this.label.embedFonts = true;

        this.format = this.label.defaultTextFormat;

        this.align    = 'top,left';
    }//function new()


    /**
    * Getter for `.highlightFormat`.
    * Since highlighting is rare required, avoid creating object for it, until
    * it is requested
    */
    private function _getHighlightFormat () : TextFormat {
        if( this._hightlightFormat == null ){
            //clone current format
            this._hightlightFormat = new TextFormat(
                this.format.font,
                this.format.size,
                this.format.color,
                this.format.bold,
                this.format.italic,
                this.format.underline,
                this.format.url,
                this.format.target,
                this.format.align,
                #if html5
                    Std.int(this.format.leftMargin),
                    Std.int(this.format.rightMargin),
                    Std.int(this.format.indent),
                    Std.int(this.format.leading)
                #else
                    this.format.leftMargin,
                    this.format.rightMargin,
                    this.format.indent,
                    this.format.leading
                #end
            );
        }
        return this._hightlightFormat;
    }//function _getHighlightFormat()


    /**
    * Setter for `.highlightFormat`
    *
    */
    private function _setHightlightFormat (hl:TextFormat) : TextFormat {
        return this._hightlightFormat = hl;
    }//function _setHightlightFormat()


    /**
    * Refresh widget. Apply format to text, update text alignment and re-apply skin
    *
    */
    override public function refresh() : Void {
        if( this.highlighted ){
            this.label.defaultTextFormat = this.highlightFormat;
            this.label.setTextFormat(this.highlightFormat);
        }else{
            this.label.defaultTextFormat = this.format;
            this.label.setTextFormat(this.format);
        }

        if( !this.autoWidth && this.label.wordWrap ){
            this.label.width = this._width;
        }

        super.refresh();
    }//function refresh()


    /**
     *  Highlight the text by applying `.highlightFormat`
     */
    public function highlight () : Void {
        this.highlighted = true;
        super.refresh();
    }//function highlight()


    /**
     *  Unhighlight the widget by setting its format back to `.format`
     */
    public function unhighlight () : Void {
        this.highlighted = false;
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

        //if widget needs to be resized to fit new string size
        if( this.autoWidth || this.autoHeight ){
            this.refresh();
        //otherwise just realign text
        }else{
            this.alignElements();
        }

        return txt;
    }//function _setText()



}//class Text