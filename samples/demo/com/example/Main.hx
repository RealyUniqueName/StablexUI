package com.example;

import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.Lib;
import ru.stablex.ui.UIBuilder;


/**
* Simple demo project for StablexUI
*/
class Main extends ru.stablex.ui.widgets.Widget{

    /**
    * Enrty point
    *
    */
    static public function main () : Void{

#if !debug throw 'DEMO IS NOT READY YET'; #end

        Lib.current.stage.align     = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        UIBuilder.saveCodeTo('_genCode_');

        //initialize StablexUI
        UIBuilder.init('ui/android/defaults.xml');

        //register skins
        UIBuilder.regSkins('ui/android/skins.xml');

        //Create our UI
        UIBuilder.buildFn('index.xml')().show();
    }//function main()


}//class Main


