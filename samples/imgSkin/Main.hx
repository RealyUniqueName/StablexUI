package;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Floating;


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
        UIBuilder.init('ui/defaults.xml');
        UIBuilder.regSkins('ui/skins.xml');

        //Create our UI
        var f : Floating = UIBuilder.buildFn('ui/ui.xml')();
        f.show();
    }//function main()


}//class Main


