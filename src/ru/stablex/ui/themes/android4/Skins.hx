package ru.stablex.ui.themes.android4;

import ru.stablex.ui.skins.Gradient;
import ru.stablex.ui.skins.Layer;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.skins.Rect;
import ru.stablex.ui.skins.Skin;
import ru.stablex.ui.UIBuilder;



/**
* Skins definitions
*
*/
class Skins {

    /**
    * Default button skin
    *
    */
    static public function button () : Paint {
        var skin = new Paint();
        skin.color   = 0x999999;
        skin.corners = [5];
        return skin;
    }//function button()


    /**
    * Buttons under the mouse cursor
    *
    */
    static public function buttonHovered () : Paint {
        var skin = new Paint();
        skin.color   = 0x33b5e5;
        skin.corners = [5];
        return skin;
    }//function buttonHovered()


    /**
    * Skin for pressed states of elements
    *
    */
    static public function pressed () : Paint {
        var skin = new Paint();
        skin.color = 0x257390;
        return skin;
    }//function pressed()


    /**
    * Pressed buttons
    *
    */
    static public function buttonPressed () : Skin {
        var skin = UIBuilder.skin('pressed')();
        if( Std.is(skin, Rect) ){
            skin.as(Rect).corners = [5];
        }
        return skin;
    }//function buttonPressed()


    /**
    * on/off switches
    *
    */
    static public function switcher () : Paint {
        var skin = new Paint();
        skin.color = 0x555555;
        skin.alpha = 0.3;
        return skin;
    }//function switcher()


    /**
    * Slider of a switch turned off
    *
    */
    static public function switchSliderOff () : Paint {
        var skin = new Paint();
        skin.color   = 0x555555;
        skin.padding = 1;
        skin.corners = [5];
        return skin;
    }//function switchSliderOff()


    /**
    * Slider of a switch turned on
    *
    */
    static public function switchSliderOn () : Paint {
        var skin = new Paint();
        skin.color   = 0x0099cc;
        skin.padding = 1;
        skin.corners = [5];
        return skin;
    }//function switchSliderOn()


    /**
    * Progress' background
    *
    */
    static public function progress () : Gradient {
        var skin = new Gradient();
        skin.colors  = [0x9c9e9c, 0x737573, 0x5a5d5a, 0x737173];
        skin.ratios  = [0, 127, 190, 255];
        skin.corners = [15];
        return skin;
    }//function progress()


    /**
    * Progress' bar
    *
    */
    static public function progressBar () : Paint {
        var skin = new Paint();
        skin.color   = 0xFFFF00;
        skin.corners = [15];
        skin.alpha   = 0.7;
        return skin;
    }//function progressBar()


    /**
    * Popups' backing
    *
    */
    static public function popup () : Paint {
        var skin = new Paint();
        skin.color = 0x00000000;
        skin.alpha = 0.8;
        return skin;
    }//function popup()


    /**
    * Horisontal rulers lines
    *
    */
    static public function hr () : Paint {
        var skin = new Paint();
        skin.color        = 0x282828;
        skin.paddingLeft  = 10;
        skin.paddingRight = 10;
        return skin;
    }//function hr()


    /**
    * Background for Options widget
    *
    */
    static public function optionsBg () : Paint {
        var skin = new Paint();
        skin.color = 0x444444;
        return skin;
    }//function optionsBg()


    /**
    * Inactive tab
    *
    */
    static public function tab () : Paint {
        var skin = new Paint();
        skin.color = 0x333333;
        return skin;
    }//function tab()


    /**
    * Active tab
    *
    */
    static public function tabActive () : Layer {
        var skin = new Layer();

        skin.current = new Paint();
        skin.current.as(Paint).color = 0x333333;
        skin.current.as(Paint).paddingBottom = 6;

        skin.behind = new Paint();
        skin.behind.as(Paint).color = 0x33b5e5;

        return skin;
    }//function tabActive()


    /**
    * Pressed tab
    *
    */
    static public function tabPressed () : Layer {
        var skin = new Layer();

        skin.current = new Paint();
        skin.current.as(Paint).color = 0x33819d;
        skin.current.as(Paint).paddingBottom = 6;

        skin.behind = new Paint();
        skin.behind.as(Paint).color = 0x33b5e5;

        return skin;
    }//function tabPressed()


    /**
    * Black fill
    *
    */
    static public function Black1 () : Paint {
        var skin = new Paint();
        skin.color = 0x111111;
        return skin;
    }//function Black1()


    /**
    * Black gradient fill
    *
    */
    static public function BlackGradient1 () : Gradient {
        var skin = new Gradient();
        skin.colors = [0x000000, 0x2b3034];
        return skin;
    }//function BlackGradient1()


    /**
    * Black background with blue bottom border (for screen header)
    *
    */
    static public function BlackBlueStripe () : Layer {
        var skin = new Layer();

        skin.current = new Paint();
        skin.current.as(Paint).color = 0x000000;
        skin.current.as(Paint).paddingBottom = 3;

        skin.behind = new Paint();
        skin.behind.as(Paint).color = 0x33b5e5;

        return skin;
    }//function BlackBlueStripe()


    /**
    * Dark gray fill
    *
    */
    static public function DarkGray () : Paint {
        var skin = new Paint();
        skin.color = 0x222222;
        return skin;
    }//function DarkGray()


    /**
    * Light gray fill
    *
    */
    static public function LightGray () : Paint {
        var skin = new Paint();
        skin.color = 0x555555;
        return skin;
    }//function LightGray()

}//class Skins