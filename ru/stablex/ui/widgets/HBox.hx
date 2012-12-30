package ru.stablex.ui.widgets;


/**
* Horizontal box. It's a box with this.vertical = false by default
*/
class HBox extends Box{


    /**
    * Constructor
    *
    */
    public function new () : Void {
        super();

        this.vertical = false;
    }//function new()
}//class HBox