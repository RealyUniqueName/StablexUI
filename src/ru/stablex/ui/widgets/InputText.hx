package ru.stablex.ui.widgets;

#if html5
import nme.events.Event;
#end



/**
* Text with type = <type>nme.text.TextFieldType</type>.INPUT
*/
class InputText extends Text{

    /**
    * Constructor
    *
    */
    public function new () : Void {
        super();

        #if !html5
            this.label.type = nme.text.TextFieldType.INPUT;
        #else
            //due to strange bug we need this hack
            this.addEventListener(Event.ADDED_TO_STAGE, function(e:Event){
                this.label.type = browser.text.TextFieldType.INPUT;
            });
        #end
    }//function new()


#if html5
    /**
    * Text getter
    * we need this hack to get actual text of textfield
    */
    override private function _getText() : String {
        return (
            this.label.type == nme.text.TextFieldType.INPUT
                ? StringTools.replace( Reflect.field(this.label, 'nmeGraphics').nmeSurface.innerHTML, '&nbsp;', ' ' )
                : this.label.text
        );
    }//function _getText()
#end
}//class InputText