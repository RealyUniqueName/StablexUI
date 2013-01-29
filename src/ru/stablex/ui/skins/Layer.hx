package ru.stablex.ui.skins;

import ru.stablex.ui.widgets.Widget;


/**
* Allows to draw several skins on top of each other
*
*/
class Layer extends Skin{

    //skin for current layer
    public var current : Skin;
    //Skin to draw behind current layer
    public var behind : Skin;


    /**
    * Apply skin to widget
    *
    */
    override public function apply (w:Widget) : Void {
        if( this.clear ){
            w.graphics.clear();
        }

        if( this.behind != null ){
            this.behind.clear = false;
            this.behind.apply(w);
        }

        if( this.current != null ){
            this.current.clear = false;
            this.current.apply(w);
        }
    }//function apply()
}//class Layer