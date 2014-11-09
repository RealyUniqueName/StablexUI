package ru.stablex.ui.themes.android4.defaults;

import ru.stablex.ui.themes.android4.Main;
import ru.stablex.ui.widgets.Radio in WRadio;
import ru.stablex.ui.widgets.Widget;


/**
* Defaults for Radio widget
*
*/
class Radio {

    /**
    * Default section
    *
    */
    static public function Default (w:Widget) : Void {
        var check = cast(w, WRadio);
        check.format.font  = ru.stablex.ui.themes.android4.Main.FONT;//Main.FONT;
        check.format.size  = 14;
        check.format.color = 0xFFFFFF;
        check.label.embedFonts = true;

        check.states.up.ico.bitmapData   = Main.getBitmapData('img/radio.png');
        check.states.down.ico.bitmapData = Main.getBitmapData('img/radioChecked.png');
    }//function Default()

}//class Radio