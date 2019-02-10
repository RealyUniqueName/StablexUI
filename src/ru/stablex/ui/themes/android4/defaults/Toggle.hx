package ru.stablex.ui.themes.android4.defaults;

import ru.stablex.ui.themes.android4.Main;
import ru.stablex.ui.widgets.Toggle in WToggle;
import ru.stablex.ui.widgets.Widget;



/**
* Defaults for Toggle widget
*
*/
class Toggle {

    /**
    * Default section
    *
    */
    static public function Default (w:Widget) : Void {
        var btn = cast(w, WToggle);

        //the same as StateButton
        StateButton.Default(btn);

        btn.states.resolve("up").skinName   = 'button';
        btn.states.resolve("down").skinName = 'buttonPressed';
    }//function Default()

}//class Toggle