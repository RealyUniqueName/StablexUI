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

        #if !html5
            this.label.type = flash.text.TextFieldType.INPUT;
        #else
            //due to strange bug we need this hack
            this.addEventListener(Event.ADDED_TO_STAGE, function(e:Event){
                this.label.type = flash.text.TextFieldType.INPUT;
                Reflect.field(this.label, 'nmeGraphics').nmeSurface.style.width = this.w + "px";
                Reflect.field(this.label, 'nmeGraphics').nmeSurface.style.height = this.h + "px";
                Reflect.field(this.label, 'nmeGraphics').nmeSurface.style.overflow = "hidden";
                if( this.label.wordWrap ){
                    Reflect.field(this.label, 'nmeGraphics').nmeSurface.style.whiteSpace = "normal";
                }else{
                    Reflect.field(this.label, 'nmeGraphics').nmeSurface.style.whiteSpace = "nowrap";
                }
            });
        #end

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

        #if html5
            Reflect.field(this.label, 'nmeGraphics').nmeSurface.style.width = this.w + "px";
            Reflect.field(this.label, 'nmeGraphics').nmeSurface.style.height = this.h + "px";
            if( this.label.wordWrap ){
                Reflect.field(this.label, 'nmeGraphics').nmeSurface.style.whiteSpace = "normal";
            }else{
                Reflect.field(this.label, 'nmeGraphics').nmeSurface.style.whiteSpace = "nowrap";
            }
        #end
    }//function refresh()

#if html5
    /**
    * Text getter
    * we need this hack to get actual text of textfield
    */
    @:noCompletion override private function get_text() : String {
        return (
            this.label.type == flash.text.TextFieldType.INPUT
                ? StringTools.replace( Reflect.field(this.label, 'nmeGraphics').nmeSurface.innerHTML, '&nbsp;', ' ' )
                : this.label.text
        );
    }//function get_text()
#end
}//class InputText