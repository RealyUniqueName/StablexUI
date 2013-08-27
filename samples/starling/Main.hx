package ;

import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Widget;
import starlingbackend.events.Event;
import starlingbackend.Lib;


/**
* Simple demo project for StablexUI
*/
class Main extends starlingbackend.display.Sprite{


    /**
    * Entry point
    *
    */
    static public function run (e:Event) : Void {
        Lib.current = cast e.target;

        //initialize StablexUI
        UIBuilder.init();

        // var skin = new ImageSkin();
        // skin.src = "assets/haxe.jpg";
        // var txt = UIBuilder.create(Widget, {
        //     skin :skin,
        //     top  : 400,
        //     left : 300
        // });
        // Lib.current.addChild(txt);

        var ui = UIBuilder.buildFn('ui/index.xml')();
        Lib.current.addChild(ui);

        Main.rotateWidget(ui);
    }//function run()


    /**
    * Rotate widget
    *
    */
    static public function rotateWidget (w:Widget) : Void {
        w.tween(5, {rotation:w.rotation + Math.PI}).onComplete(Main.rotateWidget, [w]);
    }//function rotateWidget()


    /**
    * System enrty point
    *
    */
    static public function main () : Void{
        var s = new starling.core.Starling(Main, flash.Lib.current.stage);
        s.start();
    }//function main()


    /**
    * Constructor
    *
    */
    public function new () : Void {
        super();
        this.addEventListener(Event.ADDED_TO_STAGE, Main.run);
    }//function new()

}//class Main


