package ru.stablex.ui.skins;

import ru.stablex.ui.widgets.Widget;



/**
* Skin system interface. Use it to implement your own skinning mechanics.
* Constructor must take no necessary arguments.
*
*/
interface ISkin {


    /**
    * Apply skin to specified widget
    *
    */
    public function apply (w:Widget) : Void;
}//interface Skin