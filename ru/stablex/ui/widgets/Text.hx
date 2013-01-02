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
    //Should we set widget .w and .h according to label .width and .height?
    public var autoSize : Bool = true;
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
    }//function new()


    /**
    * Refresh widget. Apply format to text and update text alignment
    *
    */
    override public function refresh() : Void {
        this.label.defaultTextFormat = this.format;
        this.label.setTextFormat(this.format);

        if( this.autoSize ){
            #if html5
                if( this.label.text.length > 0 ) { this.w = this.width; }else{ this.w = 0; }
                if( this.label.text.length > 0 ) { this.h = this.height; }else{ this.h = 0; }
            #else
                if( this.label.text.length > 0 ) { this.w = this.label.textWidth; }else{ this.w = 0; }
                if( this.label.text.length > 0 ) { this.h = this.label.textHeight; }else{ this.h = 0; }
            #end
        }
        // }else{
        //     //align text
        //     this.updateAlign();
        // }

        super.refresh();
    }//function refresh()


    // /**
    // * on resize
    // *
    // */
    // override public function onResize() : Void {
    //     super.onResize();
    //     this.updateAlign();
    // }//function onResize()


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
        this.refresh();
        return txt;
    }//function _setText()


    // /**
    // * Text align
    // *
    // */
    // public function updateAlign() : Void {
    //     if( this.align != null ){
    //         var alignments : Array<String> = this.align.split(',');

    //         for(align in alignments){
    //             switch(align){
    //                 case 'top'    : this.label.y = 0;
    //                 case 'middle' : this.label.y = (this.h - this.label.height) / 2;
    //                 case 'bottom' : this.label.y = this.h - this.label.height;
    //                 case 'left'   : this.label.x = 0;
    //                 case 'center' : this.label.x = (this.w - this.label.width) / 2;
    //                 case 'right'  : this.label.x = this.w - this.label.width;
    //                 default : Err.trigger('Unknown text alignment: ' + align);
    //             }
    //         }
    //     }
    // }//function updateAlign()


}//class Text