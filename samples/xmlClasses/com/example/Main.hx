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
    * Enrty point after StablexUI was initialized
    *
    */
    static public function main () : Void{

        Lib.current.stage.align     = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        //instantiate xml-based class
        var w = UIBuilder.create(Custom);
        trace( Type.typeof(w.box) ); //ru.stablex.ui.widgets.HBox
        trace( Type.typeof(w.btn) ); //ru.stablex.ui.widgets.Button
        w.free();

        //Create our UI
        Lib.current.addChild( UIBuilder.buildFn('ui/index.xml')() );
    }//function main()


}//class Main


