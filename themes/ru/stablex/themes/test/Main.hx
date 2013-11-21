package ru.stablex.themes.test;

import flash.Lib;
import flash.text.Font;
import ru.stablex.ui.Theme;

import flash.text.TextField;
import flash.text.TextFormat;

@:font('../../themes/ru/stablex/themes/test/assets/kata.ttf') class MyFont extends Font{}


/**
* Entry
*
*/
@:build(ru.stablex.ui.Theme.addAssets('assets'))
class Main extends Theme {

    /**
    * Entry point
    *
    */
    static public function main () : Void {
        // Theme.addAssets('assets');

        var bmp = Main.getBitmapData('assets/bg.png');

        Lib.current.addChild(new flash.display.Bitmap(bmp));

        Font.registerFont (MyFont);

        var tf = new TextField();
        tf.embedFonts = true;

        var format = new TextFormat();
        format.font = "Katamotz Ikasi";
        format.size = 30;
        tf.defaultTextFormat = format;
        tf.width = 400;

        Lib.current.addChild(tf);
        tf.text = 'Hello, world!';

    }//function main()

}//class Main