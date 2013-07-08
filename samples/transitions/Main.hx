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


    static public var view1 : ?Dynamic->Bmp;
    static public var view2 : ?Dynamic->Widget;
    static public var view3 : ?Dynamic->HBox;


    /**
    * Enrty point
    *
    */
    static public function main () : Void{

        //initialize StablexUI
        UIBuilder.init();

        //build functions for creation of views
        Main.view1 = UIBuilder.buildFn("ui/view1.xml");
        Main.view2 = UIBuilder.buildFn("ui/view2.xml");
        Main.view3 = UIBuilder.buildFn("ui/view3.xml");

        //Show main ui
        Lib.current.addChild( UIBuilder.buildFn('ui/main.xml')() );
    }//function main()


}//class Main


