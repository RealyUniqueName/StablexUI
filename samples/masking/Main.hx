package;

import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.Lib;
import ru.stablex.ui.UIBuilder;
import ru.stablex.Assets;


/**
* Simple demo project for StablexUI
*/
class Main extends ru.stablex.ui.widgets.Widget{
    /**
    * Enrty point
    *
    */
    static public function main () : Void{

/*************************
*
* MASKING DOES NOT WORK FOR HTML5
*
*************************/

        Lib.current.stage.align     = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        //register Main so we can use it in xml.
        UIBuilder.regClass("Main");

        //initialize StablexUI
        UIBuilder.init();

        //Create our UI
        Lib.current.addChild( UIBuilder.buildFn('assets/ui/mask.xml')() );
    }//function main()


}//class Main


