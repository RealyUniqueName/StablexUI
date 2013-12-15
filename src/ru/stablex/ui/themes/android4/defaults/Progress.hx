package ru.stablex.ui.themes.android4.defaults;

import ru.stablex.ui.themes.android4.Main;
import ru.stablex.ui.widgets.Progress in WProgress;
import ru.stablex.ui.widgets.Widget;


/**
* Defaults for Progress widget
*
*/
class Progress {

    /**
    * Default section
    *
    */
    static public function Default (w:Widget) : Void {
        var progress = cast(w, WProgress);
        progress.h = 20;
        progress.w = 100;
        progress.skinName     = 'progress';
        progress.bar.skinName = 'progressBar';
    }//function Default()

}//class Progress