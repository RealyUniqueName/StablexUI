package ru.stablex.ui.widgets;

import #if nme nme #else flash #end.events.MouseEvent;




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

}//class Checkbox