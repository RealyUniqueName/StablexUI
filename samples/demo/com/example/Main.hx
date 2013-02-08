package com.example;

import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.Lib;
import ru.stablex.ui.UIBuilder;


/**
* Simple demo project for StablexUI
*/
class Main extends ru.stablex.ui.widgets.Widget{

    //callback to create alert popups
    static public var alert : Dynamic->ru.stablex.ui.widgets.Floating;


    /**
    * Enrty point
    *
    */
    static public function main () : Void{

// ... IN PROGRESS ...

        Lib.current.stage.align     = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        UIBuilder.saveCodeTo('_genCode_');

        //register main class to access it's methods and properties in xml
        UIBuilder.regClass('com.example.Main');

        //initialize StablexUI
        UIBuilder.init('ui/android/defaults.xml');

        //register skins
        UIBuilder.regSkins('ui/android/skins.xml');

        //create callback for alert popup
        Main.alert = UIBuilder.buildFn('ui/alert.xml');

        //Create our UI
        UIBuilder.buildFn('ui/index.xml')().show();

        // FPS counter {
            var fps : nme.display.FPS = cast Lib.current.stage.addChild(new nme.display.FPS());
            var format = new nme.text.TextFormat (nme.Assets.getFont ("ui/android/fonts/regular.ttf").fontName, 12, 0xFFFFFF);
            fps.defaultTextFormat = format;
            fps.selectable = false;
            fps.embedFonts = true;
            fps.x = 0;
            fps.y = 0;
            fps.mouseEnabled = false;
        //}
    }//function main()


}//class Main


