package ru.stablex.ui.themes.android4.defaults;

import ru.stablex.ui.themes.android4.Main;
import ru.stablex.ui.widgets.Options in WOptions;
import ru.stablex.ui.widgets.Widget;


/**
* Defaults for Options widget
*
*/
class Options {

    /**
    * Default section (drop.down)
    *
    */
    static public function Default (w:Widget) : Void {
        var opts = cast(w, WOptions);
        opts.w                = 185;
        opts.h                = 40;
        opts.format.size      = 14;
        opts.format.color     = 0xFFFFFF;
        opts.format.font      = Main.FONT;
        opts.skinName         = 'button';
        opts.label.embedFonts = true;
        opts.skinHoveredName  = 'buttonHovered';
        opts.skinPressedName  = 'buttonPressed';
        opts.ico.bitmapData   = Main.getBitmapData('img/options.png');
        opts.icoBeforeLabel   = false;
        opts.apart            = true;
        opts.box.skinName     = 'optionsBg';
        opts.box.padding      = 15;
        opts.box.childPadding = 5;
    }//function Default()


    /**
    * Picker list
    *
    */
    static public function Picker (w:Widget) : Void {
        Options.Default(w);
        var opts = cast(w, WOptions);
        opts.alignList     = false;
        opts.list.skinName = 'popup';
        opts.list.widthPt  = 100;
        opts.list.heightPt = 100;
    }//function Picker()

}//class Options