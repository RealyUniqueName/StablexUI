package ru.stablex.ui.themes.android4.defaults;

import ru.stablex.ui.themes.android4.Main;
import ru.stablex.ui.widgets.InputText in WInputText;
import ru.stablex.ui.widgets.Widget;


/**
* Defaults for InputText widget
*
*/
class InputText {
    /**
    * Function for applying default section to widget including custom user
    * settings from xml file passed to UIBuilder.init(defaults.xml)
    */
    static private var _defaultFn : Widget->Void = null;


    /**
    * Apply default section to widget
    *
    */
    static private inline function _applyDefault (txt:WInputText) : Void {
        if( _defaultFn == null ){
            _defaultFn = UIBuilder.defaults.get('InputText').get('Default');
        }
        _defaultFn(txt);
    }//function _applyDefault()


    /**
    * Default section
    *
    */
    static public function Default (w:Widget) : Void {
        var txt = cast(w, WInputText);

        txt.format.font      = Main.FONT;
        txt.format.size      = 14;
        txt.format.color     = 0xFFFFFF;
        txt.label.embedFonts = true;
    }//function Default()


}//class InputText