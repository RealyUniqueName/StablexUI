package ru.stablex.ui.themes.android4;

import ru.stablex.ui.widgets.Scroll in WScroll;
import ru.stablex.ui.events.ScrollEvent;
import ru.stablex.ui.events.WidgetEvent;
import ru.stablex.ui.widgets.Widget;


/**
* Defaults for Scroll widget
*
*/
class Scroll {

    /**
    * Show vBar of scroll widget
    *
    */
    static private function _showVBar (e:WidgetEvent) : Void {
        cast(e.target, Scroll).vBar.visible = true;
    }//function _showVBar()


    /**
    * Hide vBar of scroll widget
    *
    */
    static private function _hideVBar (e:WidgetEvent) : Void {
        cast(e.target, Scroll).vBar.visible = false;
    }//function _hideVBar()


    /**
    * Screen containers
    *
    */
    static public function Screen (w:Widget) : Void {
        var scroll = cast(w, WScroll);
        scroll.widthPt      = 100
        scroll.heightPt     = 100
        scroll.hScroll      = false
        scroll.hBar         = null
        scroll.vBar.visible = false
        scroll.vBar.w       = 5
        scroll.vBar.right   = 2
        scroll.skinName     = 'Black1'

        scroll.addEventListener(WidgetEvent.SCROLL_START, _showBar);
        scroll.addEventListener(WidgetEvent.SCROLL_STOP, _hideBar);
    }//function Screen()

}//class Scroll