package ru.stablex.ui.widgets;

#if html5
import nme.events.Event;
#end



/**
* Text with type = nme.text.TextFieldType.INPUT
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
                this.label.type = nme.text.TextFieldType.INPUT;
            });
        #end
    }//function new()
}//class InputText