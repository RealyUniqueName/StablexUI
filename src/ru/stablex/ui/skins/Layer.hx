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
    *Draw, unDraw and reDraw skin to widget
    *
    */
    override public function draw (w:Widget) : Void {
      this.behind.draw(w);
      this.current.draw(w);
    }//function draw()

    override public function unDraw (w:Widget) : Void {
      this.behind.unDraw(w);
      this.current.unDraw(w);
    }//function unDraw()

    override public function reDraw (w:Widget) : Void {
      this.behind.reDraw(w);
      this.current.reDraw(w);
    }//function draw()
}//class Layer
