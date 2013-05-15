package;

import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.Lib;
import ru.stablex.ui.UIBuilder;


/**
* StablexUI example created in this manual: http://ui.stablex.ru/doc#manual/06_Skin_system.html
* Section: `Custom skin class`
*
*/
class Main extends nme.display.Sprite{
    /**
    * Enrty point
    *
    */
    static public function main () : Void{
        Lib.current.stage.align     = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        //Register our custom skin class, so we can use it in xml
        UIBuilder.regClass('Fractal');

        //initialize StablexUI
        UIBuilder.init();

        //Create our UI
        Lib.current.addChild( UIBuilder.buildFn('main.xml')() );
    }//function main()
}//class Main