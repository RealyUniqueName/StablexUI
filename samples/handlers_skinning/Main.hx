package;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import ru.stablex.ui.UIBuilder;


/**
* Simple demo project for StablexUI
*/
class Main extends ru.stablex.ui.widgets.Widget{
    /**
    * Enrty point
    *
    */
    static public function main () : Void{
        Lib.current.stage.align     = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        //register Main so we can use it in xml. Full classpath should be specified here
        UIBuilder.regClass("Main");
        //If we want to use com.example.SomeClass in xml we need to do this:
        //  UIBuilder.regClass("com.example.SomeClass");
        //Than we can use <SomeClass /> in tags and $SomeClass in handlers in xml
        //Look in assets/ui/index.xml for samples

        //If we want to to define handlers for any specific event, say flash.event.MouseEvent.MOUSE_WHEEL
        //we need to register it like this
        //  UIBuilder.regEvent("wheel", "flash.event.MouseEvent.MOUSE_WHEEL");
        //or
        //  UIBuilder.regEvent("wheel", "'mouseWheel'"); //'mouseWheel' is the value of flash.event.MouseEvent.MOUSE_WHEEL constant
        //than we can use attribute `on-wheel` to define handlers in xml
        //Look for attributes like on-* in assets/ui/index.xml for samples
        //There are some frequenlty used events already registered by default.
        //Look in ru.stablex.ui.UIBuilder.init() for the list of preregistered events

        //initialize StablexUI
        UIBuilder.init();

        //register skins. You can also define skins separately for each widget right in ui xml
        UIBuilder.regSkins('assets/ui/skins.xml');

        //Create our UI
        Lib.current.addChild( UIBuilder.buildFn('assets/ui/index.xml')() );
    }//function main()


}//class Main


