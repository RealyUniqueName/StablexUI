package ru.stablex.ui.widgets;

import nme.geom.Rectangle;



/**
*   classname:  Mask
*
* Hide everything that overflows this widget's size
*/
class Mask extends Widget{


    /**
    * Update scrollRect on resize
    *
    */
    override public function onResize () : Void {
        super.onResize();

        this.scrollRect = new Rectangle(0, 0, this.w, this.h);
    }//function onResize()
}//class Mask
