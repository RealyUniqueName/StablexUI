package ru.stablex.ui.skins;

import ru.stablex.ui.widgets.Widget;



/**
* Skin system interface
*
*/
interface ISkin {


    /**
    * Apply skin to specified widget
    *
    */
    public function apply (w:Widget) : Void;
}//interface Skin