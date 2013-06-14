package;

import flash.Lib;
import ru.stablex.ui.UIBuilder;


/**
* StablexUI example created in this manual: http://ui.stablex.ru/doc#manual/03_Position_and_size.html
* Section "Size"
*/
class Main extends flash.display.Sprite{

    /**
    * Enrty point
    *
    */
    static public function main () : Void{
        Lib.current.stage.align     = flash.display.StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;

        //initialize StablexUI
        UIBuilder.init();

        //Create UI and attach it to root display object
        Lib.current.addChild( UIBuilder.buildFn('size.xml')() );
    }//function main()


}//class Main


