package ru.stablex.ui.themes.android4.defaults;

import ru.stablex.ui.themes.android4.Main;
import ru.stablex.ui.widgets.TabStack in WTabStack;
import ru.stablex.ui.widgets.Widget;
import ru.stablex.ui.skins.Paint;


/**
* Defaults for TabStack widget
*
*/
class TabStack {

    /**
    * Default section (drop.down)
    *
    */
    static public function Default (w:Widget) : Void {
        var stack = cast(w, WTabStack);

        var skin = new Paint();
        skin.color = 0x474747;

        stack.tabBar.skin = skin;
        stack.tabBar.unifyChildren = true;
        stack.tabBar.childPadding  = 1;
        stack.widthPt  = 100;
        stack.heightPt = 100;
        stack.wrap     = true;
    }//function Default()




}//class TabStack