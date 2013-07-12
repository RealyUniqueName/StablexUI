package;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Bmp;
import ru.stablex.ui.widgets.Widget;
import ru.stablex.ui.widgets.HBox;


/**
* Simple demo project for StablexUI
*/
class Main extends flash.display.Sprite{

    /**
    * Enrty point
    *
    */
    static public function main () : Void{

        //initialize StablexUI
        UIBuilder.init();

        //Show main ui
        Lib.current.addChild( UIBuilder.buildFn('ui.xml')() );
    }//function main()


}//class Main


