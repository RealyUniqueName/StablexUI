package ru.stablex.ui.themes.test;

import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.skins.Slice9;



/**
* Skins definitions for this theme
*
*/
class Skins {


    /**
    * Green fill with rounded corners
    *
    */
    static public function green () : Paint {
        var skin : Paint = new Paint();
        skin.color   = 0x00FF00;
        skin.corners = [20];

        return skin;
    }//function green()


    /**
    * Ubuntu-style buttons
    *
    */
    static public function btnUbuntu () : Slice9 {
        var skin = new Slice9();

        skin.bitmapData = Main.getBitmapData('nested/evenMore/bg.png');
        skin.slice      = [4, 5, 7, 20];

        return skin;
    }//function btnUbuntu()
}//class Skins