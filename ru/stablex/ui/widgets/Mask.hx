package ru.stablex.ui.widgets;

import nme.display.DisplayObjectContainer;
import nme.display.DisplayObject;
import nme.display.Shape;


/**
*   classname:  Mask
*
* Hide everything that overflows this widget's borders
*/
class Mask extends Panel{

    /**
    * Update scrollRect on resize
    *
    */
    override public function onResize () : Void {
        super.onResize();
        this.scrollRect = new nme.geom.Rectangle(0, 0, this.w, this.h);
    }//function onResize()
}//class Mask