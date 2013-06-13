package ;

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

        //initialize StablexUI
        UIBuilder.init();

        //Create our UI
        Lib.current.addChild( UIBuilder.buildFn('index.xml')() );
    }//function main()


}//class Main


