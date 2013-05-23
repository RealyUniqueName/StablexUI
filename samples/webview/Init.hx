package ;

import ru.stablex.ui.UIBuilder;


/**
* Simple demo project for StablexUI
*/
class Init{

    /**
    * Enrty point
    *
    */
    static public function main () : Void{

        //register classes for usage in xml.
        //UIBuilder.regClass("com.visusway.components.ClockDial");

        //create xml-based classes for custom widgets
        //UIBuilder.createClass("ui/components/clockdial.xml", "com.visusway.components.ClockDialBase");

        //initialize StablexUI
        //UIBuilder.init("ui/defaults.xml");
		UIBuilder.init(null);

        //Run application
        Main.main();

    }//function main()


    /**
    * constructor
    *
    */
    public function new() : Void {
    }//function new()



}//class Init


