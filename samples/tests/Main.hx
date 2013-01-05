package;

import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.Lib;
import ru.stablex.ui.UIBuilder;
import ru.stablex.Assets;


/**
* Random testing
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

        //register skins. You can also setup skin for each skinable element by using .skinBmp and .skinSlices
        UIBuilder.regSkins( Assets.embed('assets/ui/skins.hx') );

        //Create our UI
        Lib.current.addChild( UIBuilder.buildFn('assets/ui/autosize.xml')() );
    }//function main()


}//class Main


