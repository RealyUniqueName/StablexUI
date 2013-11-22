package ru.stablex.themes.test;

import ru.stablex.ui.skins.Paint;



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


}//class Skins