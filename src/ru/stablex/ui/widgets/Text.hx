package ru.stablex.ui.widgets;

import flash.text.TextField;
import flash.text.TextFormat;
import ru.stablex.Err;
import ru.stablex.ui.UIBuilder;


/**
* Text field
*/
class Text extends Box{
    //<type>flash.display.TextField</type> used to render text
    public var label  : TextField;
    //Text format wich will be aplied to label on refresh
    public var format : TextFormat;
    //Text format for higlight mode
    public var highlightFormat (get_highlightFormat,set_highlightFormat) : TextFormat;
    private var _hightlightFormat : TextFormat;
    //indicates highlighting state
    public var highlighted (default,null) : Bool = false;
    //Getter-setter for text.
    public var text (get_text,set_text) : String;


    /**
    * Constructor
    *
    */
    public function new() : Void {
        super();

        this.label = cast(this.addChild(new TextField()), TextField);
        this.label.autoSize   = flash.text.TextFieldAutoSize.LEFT;
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
    @:noCompletion private function get_highlightFormat () : TextFormat {
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
    }//function get_highlightFormat()


    /**
    * Setter for `.highlightFormat`
    *
    */
    @:noCompletion private function set_highlightFormat (hl:TextFormat) : TextFormat {
        return this._hightlightFormat = hl;
    }//function set_highlightFormat()


    /**
    * Refresh widget. Apply format to text, update text alignment and re-apply skin
    *
    */
    override public function refresh() : Void {
        if( this.highlighted ){
            this.label.defaultTextFormat = this.highlightFormat;
            if( this.label.text.length > 0 ){
                this.label.setTextFormat(this.highlightFormat #if cpp , 0 , this.text.length #end );
            }
        }else{
            this.label.defaultTextFormat = this.format;
            if( this.label.text.length > 0 ){
                this.label.setTextFormat(this.format #if cpp , 0 , this.text.length #end);
            }
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
    @:noCompletion private function get_text() : String {
        return this.label.text;
    }//function get_text()


    /**
    * Text setter
    *
    */
    @:noCompletion private function set_text(txt:String) : String {
        this.label.text = txt;

        //if widget needs to be resized to fit new string size
        if( this.autoWidth || this.autoHeight ){
            this.refresh();
        //otherwise just realign text
        }else{
            this.alignElements();
        }

        return txt;
    }//function set_text()



}//class Text