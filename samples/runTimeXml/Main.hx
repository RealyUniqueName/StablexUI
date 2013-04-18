package;

import nme.Lib;
import ru.stablex.Assets;
import ru.stablex.ui.RTXml;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Widget;


/**
* StablexUI example
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
        UIBuilder.init(null, true);

        // //compile-time xml parsing
        // Lib.current.addChild( UIBuilder.buildFn("assets/ui.xml")() );

        //run-time xml parsing {
            var tm = Lib.getTimer();
            var fn = RTXml.buildFn(Assets.getText("assets/big.xml"));
            trace("Parse time: " + (Lib.getTimer() - tm) + "ms");

            tm = Lib.getTimer();
            Lib.current.addChild( fn() );
            trace("Create time: " + (Lib.getTimer() - tm) + "ms");
        //}
    }//function main()


}//class Main


