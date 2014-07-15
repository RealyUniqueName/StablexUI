package;

import flash.Lib;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.*;


/**
* StablexUI example. How to use themes.
*/
class Main extends flash.display.Sprite{

    /**
    * Enrty point
    *
    */
    static public function main () : Void{
        //plug in theme
        UIBuilder.setTheme('ru.stablex.ui.themes.android4');

        //initialize StablexUI
        UIBuilder.init();

        Lib.current.addChild( UIBuilder.buildFn('ui/main.xml')() );
    }//function main()


}//class Main


