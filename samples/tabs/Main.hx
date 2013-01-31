package;

import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.Lib;
import ru.stablex.ui.UIBuilder;
import ru.stablex.Assets;

import ru.stablex.ui.widgets.StateButton;


/**
* Simple demo project for StablexUI
*/
class Main extends nme.display.Sprite{

    /**
    * Enrty point
    *
    */
    static public function main () : Void{
        Lib.current.stage.align     = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        //initialize StablexUI
        UIBuilder.init();

        //register skins 
        UIBuilder.regSkins('assets/ui/skins.xml');

        //Create our UI
        Lib.current.addChild( UIBuilder.buildFn('assets/ui/index.xml')() );
    }//function main()


}//class Main


