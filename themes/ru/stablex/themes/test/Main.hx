package ru.stablex.themes.test;

import flash.Lib;
import flash.text.Font;
import ru.stablex.ui.Theme;

import flash.text.TextField;
import flash.text.TextFormat;


/**
* Entry
*
*/
@:build(ru.stablex.ui.Theme.register())
class Main extends Theme {


    /**
    * Entry point
    *
    */
    static public function main () : Void {

        var bmp = Main.getBitmapData('nested/evenMore/bg.png');

        Lib.current.addChild(new flash.display.Bitmap(bmp));


        var tf = new TextField();
        tf.embedFonts = true;

        var format = new TextFormat();
        format.font = Main.getFontName('kata.ttf');
        format.size = 30;
        tf.defaultTextFormat = format;
        tf.width = 400;

        Lib.current.addChild(tf);
        tf.x = 200;
        tf.y = 100;
        tf.text = 'Hello, world!';

        Skins.green();
    }//function main()

}//class Main