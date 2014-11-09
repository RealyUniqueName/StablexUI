package ru.stablex.ui.themes.android4.defaults;

import ru.stablex.ui.themes.android4.Main;
import ru.stablex.ui.widgets.Checkbox in WCheckbox;
import ru.stablex.ui.widgets.Widget;


/**
* Defaults for Checkbox widget
*
*/
class Checkbox {

    /**
    * Default section
    *
    */
    static public function Default (w:Widget) : Void {
        var check = cast(w, WCheckbox);
        check.format.font  = Main.FONT;
        check.format.size  = 14;
        check.format.color = 0xFFFFFF;
        check.label.embedFonts = true;

        check.states.up.ico.bitmapData   = Main.getBitmapData('img/checkbox.png');
        check.states.down.ico.bitmapData = Main.getBitmapData('img/checkboxChecked.png');
    }//function Default()

}//class Checkbox