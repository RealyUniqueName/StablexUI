package ru.stablex.ui.themes.android4.defaults;

import ru.stablex.ui.themes.android4.Main;
import ru.stablex.ui.widgets.StateButton in WStateButton;
import ru.stablex.ui.widgets.Widget;


/**
* Defaults for StateButton
*
*/
class StateButton {

    /**
    * Default section
    *
    */
    static public function Default (w:Widget) : Void {
        var btn = cast(w, WStateButton);
        btn.w                = 185;
        btn.h                = 40;
        btn.format.size      = 14;
        btn.format.color     = 0xFFFFFF;
        btn.format.font      = Main.FONT;
        btn.label.embedFonts = true;
        btn.skinName         = 'button';
        btn.skinHoveredName  = 'buttonHovered';
        btn.skinPressedName  = 'buttonPressed';
    }//function Default()

}//class StateButton