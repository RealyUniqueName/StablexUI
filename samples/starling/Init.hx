package;

import ru.stablex.ui.UIBuilder;


/**
* Macro initialization
*
*/
class Init {


/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/

    /**
    * Function called with `--macro` compiler flag
    *
    */
    macro static public function init () : Void{
        //register classes for usage in xml.
        UIBuilder.regClass("ImageSkin");

        // //create xml-based classes for custom widgets
        // UIBuilder.buildClass("ui/custom.xml", "com.example.Custom");

    }//function init()

/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/

    //code...

/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

}//class Init