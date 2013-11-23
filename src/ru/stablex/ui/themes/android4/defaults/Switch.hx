package ru.stablex.ui.themes.android4.defaults;

import ru.stablex.ui.themes.android4.Main;
import ru.stablex.ui.widgets.Switch in WSwitch;
import ru.stablex.ui.events.WidgetEvent;
import ru.stablex.ui.widgets.Widget;


/**
* Defaults for Switch widget
*
*/
class Switch {

    /**
    * Adjust switch label according to switch state
    *
    */
    static private function _updateSwitchLabel (e:WidgetEvent) : Void {
        var swch = cast(e.target, WSwitch);
        if( swch.selected ){
            swch.labelOn.text = 'ON';
            swch.slider.skinName = 'switchSliderOn';
        }else{
            swch.labelOn.text = 'OFF';
            swch.slider.skinName = 'switchSliderOff';
        }
    }//function _updateSwitchLabel()


    /**
    * Default section
    *
    */
    static public function Default (w:Widget) : Void {
        var swch = cast(w, WSwitch);

        swch.w        = 97;
        swch.h        = 24;
        swch.skinName = 'switcher';

        swch.slider.w = 47;

        swch.labelOff.left = 0;
        swch.labelOn.left  = 0;
        swch.labelOff.top  = 0;
        swch.labelOn.top   = 0;

        swch.labelOn.widthPt   = 100;
        swch.labelOff.widthPt  = 100;
        swch.labelOn.heightPt  = 100;
        swch.labelOff.heightPt = 100;
        swch.labelOff.visible  = false;

        swch.labelOn.align  = 'center,middle';
        swch.labelOff.align = 'center,middle';

        swch.addEventListener(WidgetEvent.CREATE, _updateSwitchLabel);
        swch.addEventListener(WidgetEvent.CHANGE, _updateSwitchLabel);
    }//function Default()


    /**
    * Mor "classic" behavior of switch labels
    *
    */
    static public function Classic (w:Widget) : Void {
        var swch = cast(w, WSwitch);
        swch.w                    = 97;
        swch.h                    = 24;
        swch.skinName             = 'switcher';
        swch.slider.w             = 47;
        swch.slider.skinName      = 'switchSliderOn';
        swch.labelOn.format.color = 0x33b5e5;
    }//function Classic()

}//class Switch