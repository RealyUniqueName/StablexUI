package;

import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.Lib;
import ru.stablex.ui.UIBuilder;
import ru.stablex.Assets;


/**
* Simple demo project for StablexUI
*/
class Main extends ru.stablex.ui.widgets.Panel{
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

        //register skins. You can also setup skin for each skinable element by using .skinBmp and .skinSlices
        UIBuilder.regSkins( Assets.embed('assets/ui/skins.hx') );

        //Create our UI
        Lib.current.addChild( UIBuilder.buildFn('assets/ui/mask.xml')() );
    }//function main()


}//class Main


