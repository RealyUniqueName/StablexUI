package ru.stablex.ui.themes.android4.defaults;

import ru.stablex.ui.skins.Rect;
import ru.stablex.ui.themes.android4.Main;
import ru.stablex.ui.widgets.Tip in WTip;
import ru.stablex.ui.widgets.Widget;



/**
* Defaults for Tip widget
*
*/
class Tip {

    /**
    * Default section
    *
    */
    static public function Default (w:Widget) : Void {
        var tip = cast(w, WTip);

        tip.skinName = 'popup';
        tip.skin.as(Rect).corners = [5];

        tip.padding               = 4;
        tip.label.format.size     = 12;
    }//function Default()

}//class Tip