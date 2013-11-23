package ru.stablex.ui.themes.android4.defaults;

import ru.stablex.ui.widgets.Text in WText;
import ru.stablex.ui.widgets.Widget;


/**
* Defaults for text widget
*
*/
class Text {
    /**
    * Function for applying default section to widget including custom user
    * settings from xml file passed to UIBuilder.init(defaults.xml)
    */
    static private var _defaultFn : Widget->Void = null;


    /**
    * Apply default section to widget
    *
    */
    static private inline function _applyDefault (txt:WText) : Void {
        if( _defaultFn == null ){
            _defaultFn = UIBuilder.defaults.get('Text').get('Default');
        }
        _defaultFn(txt);
    }//function _applyDefault()


    /**
    * Default section
    *
    */
    static public function Default (w:Widget) : Void {
        var txt = cast(w, WText);

        txt.format.font      = Main.getFontName('fonts/regular.ttf');
        txt.format.size      = 14;
        txt.format.color     = 0xFFFFFF;
        txt.label.selectable = false;
        txt.label.embedFonts = true;
    }//function Default()


    /**
    * Dark text
    *
    */
    static public function Dark (w:Widget) : Void {
        var txt = cast(w, WText);
        _applyDefault(txt);
        txt.format.color = 0x111111;
    }//function Dark()


    /**
    * Common for hints
    *
    */
    static private function _tip (txt:Widget) : Void {
        txt.format.size    = 12;
        txt.label.wordWrap = true;
        txt.widthPt        = 100;
    }//function _tip()


    /**
    * Hints with dark text
    *
    */
    static public function DarkTip () : Void {
        var txt = cast(w, WText);
        _applyDefault(txt);
        _tip(txt);
        txt.format.color = 0x7F7F7F;
    }//function DarkTip()


    /**
    * Hints with light text
    *
    */
    static public function LightTip () : Void {
        var txt = cast(w, WText);
        _applyDefault(txt);
        _tip(txt);
        txt.format.color = 0xbbbbbb;
    }//function LightTip()


    /**
    * Headers
    *
    */
    static public function H1 (w:Widget) : Void {
        var txt = cast(w, WText);
        _applyDefault(txt);
        txt.format.size = 22;
        txt.padding     = 10;
    }//function H1()

}//class Text