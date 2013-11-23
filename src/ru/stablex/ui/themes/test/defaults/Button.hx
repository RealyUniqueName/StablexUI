package ru.stablex.ui.themes.test.defaults;

import ru.stablex.ui.widgets.Widget;
import ru.stablex.ui.widgets.Button in WButton;


/**
* Defaults for buttons
*
*/
class Button {

    /**
    * Default section
    *
    */
    static public function Default (w:Widget) : Void {
        var btn : WButton = cast(w, WButton);

        btn.skinName = 'green';
        btn.h = 40;
        btn.padding = 20;
    }//function Default()


    /**
    * Ubuntu-style buttons
    *
    */
    static public function ubuntu (w:Widget) : Void {
        var btn : WButton = cast(w, WButton);

        btn.skinName = 'btnUbuntu';
        btn.h       = 40;
        btn.padding = 10;
    }//function ubuntu()

}//class Button