package ru.stablex.ui.themes.android4;



/**
* Main class of a theme
*
*/
class Main extends ru.stablex.ui.Theme{

    /** main font name */
    static public var FONT : String = '';


    /**
    * This method will be automatically called after UIBuilder.init()
    * It's not required to define this method in theme.
    *
    */
    static public function main () : Void {
        FONT = 'Roboto Regular';
    }//function main()

}//class Main