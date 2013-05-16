package;

import nme.Lib;
import ru.stablex.ui.UIBuilder;


/**
* StablexUI example created in this manual: http://ui.stablex.ru/doc#manual/02_Basics.html
*/
class Main extends nme.display.Sprite{

    /**
    * Enrty point
    *
    */
    static public function main () : Void{
        Lib.current.stage.align     = nme.display.StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;

        //initialize StablexUI
        UIBuilder.init();

        //Create UI and attach it to root display object
        Lib.current.addChild( UIBuilder.buildFn('first.xml')() );
    }//function main()


}//class Main


