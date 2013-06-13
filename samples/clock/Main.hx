package;

import ru.stablex.ui.UIBuilder;


/**
* StablexUI example for Clock widget
*/
class Main extends flash.display.Sprite{

    /**
    * Enrty point
    *
    */
    static public function main () : Void{
        //initialize StablexUI
        UIBuilder.init();

        //Create UI and attach it to root display object
        flash.Lib.current.addChild( UIBuilder.buildFn('clock.xml')() );
    }//function main()


}//class Main


