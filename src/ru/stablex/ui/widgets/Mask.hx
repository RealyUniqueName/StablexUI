package ru.stablex.ui.widgets;

import nme.geom.Rectangle;



/**
* Hide everything that overflows this widget's size
* Currently does nothing for html5, because masks and scrollRects are not implemented in NME for html5
*/
class Mask extends Widget{


    /**
    * Update scrollRect on resize
    *
    */
    override public function onResize () : Void {
        super.onResize();
        trace('Adding scroll rect!');
        this.scrollRect = new Rectangle(0, 0, this.w, this.h);
    }//function onResize()
}//class Mask
