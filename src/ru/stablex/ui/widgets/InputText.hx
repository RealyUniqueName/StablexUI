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
    public var disabled :Bool = false;
    
    public function new () : Void {
        super();

        if (!disabled){
            #if !html5
                this.label.type = flash.text.TextFieldType.INPUT;
            #else
                //due to strange bug we need this hack
                this.addEventListener(Event.ADDED_TO_STAGE, function(e:Event){
                    this.label.type = flash.text.TextFieldType.INPUT;
                    Reflect.field(this.label, '__graphics').__surface.style.width = this.w + "px";
                    Reflect.field(this.label, '__graphics').__surface.style.height = this.h + "px";
                    Reflect.field(this.label, '__graphics').__surface.style.overflow = "hidden";
                    if( this.label.wordWrap ){
                        Reflect.field(this.label, '__graphics').__surface.style.whiteSpace = "normal";
                    }else{
                        Reflect.field(this.label, '__graphics').__surface.style.whiteSpace = "nowrap";
                    }
                });
            #end

            this.label.autoSize = flash.text.TextFieldAutoSize.NONE;
            this.format.align   = flash.text.TextFormatAlign.LEFT;
        }
    }//function new()


    /**
    * update textField size on refresh
    *
    */
    override public function refresh () : Void {
        this.label.width  = this.w - this.paddingLeft - this.paddingRight;
        this.label.height = this.h - this.paddingTop - this.paddingBottom;

        super.refresh();

        #if html5
            Reflect.field(this.label, '__graphics').__surface.style.width = this.w + "px";
            Reflect.field(this.label, '__graphics').__surface.style.height = this.h + "px";
            if( this.label.wordWrap ){
                Reflect.field(this.label, '__graphics').__surface.style.whiteSpace = "normal";
            }else{
                Reflect.field(this.label, '__graphics').__surface.style.whiteSpace = "nowrap";
            }
        #end
        if (disabled)
           {this.label.type = null;}
        else {this.label.type = flash.text.TextFieldType.INPUT;}  
        
    }//function refresh()

#if html5
    /**
    * Text getter
    * we need this hack to get actual text of textfield
    */
    @:noCompletion override private function get_text() : String {
        return (
            this.label.type == flash.text.TextFieldType.INPUT
                ? StringTools.replace( Reflect.field(this.label, '__graphics').__surface.innerHTML, '&nbsp;', ' ' )
                : this.label.text
        );
    }//function get_text()
	
	/**
    * Text setter
    *
    */
    @:noCompletion override private function set_text(txt:String) : String {
        if( this.label.type == flash.text.TextFieldType.INPUT ) {
            Reflect.field(this.label, '__graphics').__surface.innerHTML = txt;
        }
        return super.set_text(txt);
    }//function set_text()
#end
}//class InputText
