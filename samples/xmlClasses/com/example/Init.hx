package com.example;

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
        UIBuilder.regClass("com.example.CustomExt");

        //create xml-based classes for custom widgets
        UIBuilder.createClass("ui/custom.xml", "com.example.Custom");

        // //register classes, which rely on xml-based classes
        // UIBuilder.regClass("com.example.CustomExtended");

        //initialize StablexUI
        UIBuilder.init("ui/defaults.xml");

        //Run application
        Main.main();

    }//function main()


}//class Init


