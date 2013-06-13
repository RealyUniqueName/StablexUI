package;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import ru.stablex.ui.UIBuilder;


/**
* Simple demo project for StablexUI
*/
class Main extends flash.display.Sprite{

    /**
    * Enrty point
    *
    */
    static public function main () : Void{
        Lib.current.stage.align     = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        //initialize StablexUI
        UIBuilder.init('assets/ui/defaults.xml');

        //Create our UI
        Lib.current.addChild( UIBuilder.buildFn('assets/ui/index.xml')() );
    }//function main()


}//class Main


