package;

import ru.stablex.ui.UIBuilder;


/**
* StablexUI example for Clock widget
*/
class Main extends nme.display.Sprite{

    /**
    * Enrty point
    *
    */
    static public function main () : Void{
        //initialize StablexUI
        UIBuilder.init();

        //Create UI and attach it to root display object
        Lib.current.addChild( UIBuilder.buildFn('clcok.xml')() );
    }//function main()


}//class Main


