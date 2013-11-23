package ru.stablex.ui.themes.android4.defaults;

import ru.stablex.ui.themes.android4.Main;
import ru.stablex.ui.widgets.Slider in WSlider;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.widgets.Widget;
import ru.stablex.ui.skins.Layer;



/**
* Defaults for Slider widget
*
*/
class Slider {

    /**
    * Default section
    *
    */
    static public function Default (w:Widget) : Void {
        var slider = cast(w, WSlider);
        slider.h = slider.w = 20;
        slider.slider.w = slider.slider.h = 20;

        var skin = new Layer();
        skin.behind = new Paint();
        skin.behind.as(Paint).color = 0x000000;
        skin.behind.as(Paint).alpha = 0.01;
        skin.current = new Paint();
        skin.current.as(Paint).color   = 0x969696;
        skin.current.as(Paint).padding = 8;
        skin.current.as(Paint).corners = [20];
        slider.skin = skin;

        var skin = new Paint();
        skin.color   = 0x33b5e5;
        skin.corners = [20];
        slider.slider.skin = skin;
    }//function Default()


    /**
    * Rectangular slider
    *
    */
    static public function Rect (w:Widget) : Void {
        var slider = cast(w, WSlider);
        slider.h = slider.w = 20;
        slider.slider.h = 20;
        slider.slider.w = 50;

        var skin = new Paint();
        skin.color = 0x969696;
        slider.skin = skin;

        var skin = new Paint();
        skin.color   = 0x222222;
        skin.padding = 2;
        slider.slider.skin = skin;
    }//function Rect()

}//class Slider