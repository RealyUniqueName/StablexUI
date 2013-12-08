package ru.stablex.ui.widgets;

import flash.events.MouseEvent;




/**
* Simple checkbox
*
* @dispatch <type>ru.stablex.ui.events.WidgetEvent</type>.CHANGE - on state change
*/
class Checkbox extends Toggle{


    /**
    * Constructor
    *
    */
    public function new () : Void {
        super();

        this.mouseChildren = true;
    }//function new()

}//class Checkbox