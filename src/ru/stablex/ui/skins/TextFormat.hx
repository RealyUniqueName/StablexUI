package ru.stablex.ui.skins;

import ru.stablex.ui.widgets.Widget;
import ru.stablex.ui.widgets.Text;

/**
 * Change format options of text
 *
 */

class TextFormat extends Skin {
  //font format if the widget is a Text
  public var format : flash.text.TextFormat = new flash.text.TextFormat();

  /**
    * Draw skin on widget
    */
  override public function draw(w:Widget) : Void {
    if (Std.is(w,Text)) {
      var t = cast(w,Text);
      t.label.defaultTextFormat = this.format;
      t.label.setTextFormat(this.format #if cpp ,0, t.label.text.length #end);
    }
    super.draw(w);
  }//function draw()
}
