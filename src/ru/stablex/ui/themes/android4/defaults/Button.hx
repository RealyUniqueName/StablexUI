package ru.stablex.ui.themes.android4.defaults;

import ru.stablex.ui.themes.android4.Main;
import ru.stablex.ui.widgets.Button in WButton;
import ru.stablex.ui.widgets.Widget;


/**
* Defaults for Button widget
*
*/
class Button {
    /**
    * Function for applying default section to widget including custom user
    * settings from xml file passed to UIBuilder.init(defaults.xml)
    */
    static private var _defaultFn : Widget->Void = null;


    /**
    * Apply default section to widget
    *
    */
    static private inline function _applyDefault (btn:WButton) : Void {
        if( _defaultFn == null ){
            _defaultFn = UIBuilder.defaults.get('Button').get('Default');
        }
        _defaultFn(btn);
    }//function _applyDefault()


    /**
    * Default section
    *
    */
    static public function Default (w:Widget) : Void {
        var btn = cast(w, WButton);
        btn.w = 185;
        btn.h = 40;
        btn.label.embedFonts = true;
        btn.format.size = 14;
        btn.format.color = 0xFFFFFF;
        btn.format.font = Main.FONT;
        btn.skinName = 'button';
        btn.skinHoveredName = 'buttonHovered';
        btn.skinPressedName = 'buttonPressed';
    }//function Default()


    /**
    * Settings button
    *
    */
    static public function Settings (w:Widget) : Void {
        var btn = cast(w, WButton);
        _applyDefault(btn);
        btn.ico.bitmapData = Main.getBitmapData('img/ico/dark/settings.png');
        btn.autoWidth      = true;
        btn.childPadding   = 0;
        btn.icoBeforeLabel = false;
        btn.apart          = true;
    }//function Settings()


    /**
    * Items in menu list
    *
    */
    static public function MenuItem (w:Widget) : Void {
        var btn = cast(w, WButton);
        btn.align            = 'middle';
        btn.h                = 44;
        btn.widthPt          = 100;
        btn.padding          = 5;
        btn.label.embedFonts = true;
        btn.format.font      = Main.FONT;
        btn.format.size      = 16;
        btn.format.color     = 0xFFFFFF;
        btn.apart            = true;
        btn.ico.bitmapData   = Main.getBitmapData('img/ico/light/next.png');
        btn.icoBeforeLabel   = false;
        btn.skinName         = 'Black1';
        btn.skinPressedName  = 'pressed';
    }//function MenuItem()

}//class Button