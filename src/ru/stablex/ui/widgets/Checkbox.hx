package ru.stablex.ui.widgets;

import nme.events.MouseEvent;




/**
* Simple checkbox
*
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


    /**
    * Process pressing.
    *
    */
    override public dynamic function onPress (e:MouseEvent) : Void {
    }//function onPress()


    /**
    * Process releasing.
    *
    */
    override public dynamic function onRelease (e:MouseEvent) : Void {
    }//function onRelease()
}//class Checkbox