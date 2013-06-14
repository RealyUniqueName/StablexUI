package;

import flash.Lib;
import ru.stablex.Assets;
import ru.stablex.ui.RTXml;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Widget;


/**
* StablexUI example
*/
class Main extends flash.display.Sprite{

    /**
    * Enrty point
    *
    */
    static public function main () : Void{
        Lib.current.stage.align     = flash.display.StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;

        //register Main class for xml
        UIBuilder.regClass("Main");

        //initialize StablexUI.
        //Second parameter must be `true` if you want to use runtime xml processing.
        UIBuilder.init(null, true);

        // //compile-time xml parsing
        // var fn : ?Dynamic->Widget = UIBuilder.buildFn("assets/ui.xml");

        //run-time xml parsing
        var fn : ?Dynamic->Widget = RTXml.buildFn( Assets.getText("assets/ui.xml") );

        //create ui
        Lib.current.addChild(
            fn({
                color : 0xFF0000,
                data  : {
                    tooltip : "Greetings",
                    name    : "World"
                }
            })
        );
    }//function main()


    /**
    * For testing $ClassName placeholder
    *
    */
    static public function test () : String {
        return "How are you?";
    }//function test()

}//class Main


