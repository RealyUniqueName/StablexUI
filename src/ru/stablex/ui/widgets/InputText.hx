package ru.stablex.ui.widgets;

#if html5
import flash.events.Event;
#end



/**
* Text with type = <type>flash.text.TextFieldType</type>.INPUT
*/
class InputText extends Text{

    /**
    * Constructor
    *
    */
    public function new () : Void {
        super();

        this.label.type = flash.text.TextFieldType.INPUT;

        this.label.autoSize = flash.text.TextFieldAutoSize.NONE;
        this.format.align   = flash.text.TextFormatAlign.LEFT;
    }//function new()


    /**
    * update textField size on refresh
    *
    */
    override public function refresh () : Void {
        this.label.width  = this.w - this.paddingLeft - this.paddingRight;
        this.label.height = this.h - this.paddingTop - this.paddingBottom;

        super.refresh();
    }//function refresh()

}//class InputText