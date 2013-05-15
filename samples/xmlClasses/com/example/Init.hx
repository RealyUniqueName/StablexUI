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

        //initialize StablexUI
        UIBuilder.init("ui/defaults.xml");

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


