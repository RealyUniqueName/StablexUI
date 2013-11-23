package;

import flash.Lib;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.*;


/**
* StablexUI example. How to use themes.
*/
class Main extends flash.display.Sprite{

    /**
    * Enrty point
    *
    */
    static public function main () : Void{
        //plug in theme
        UIBuilder.setTheme('ru.stablex.ui.themes.android4');

        //initialize StablexUI
        UIBuilder.init();

        Lib.current.addChild( UIBuilder.buildFn('ui/main.xml')() );

        // //Create some widgets {
        //     Lib.current.addChild( UIBuilder.create(Button, {
        //         left : 100,
        //         top  : 50,
        //         text : 'Hit me!'
        //     }) );

        //     var opts : Array<Array<Dynamic>> = [['apple', 'wow'], ['pancakes', 'yay'], ['peanut butter jelly time!', 'doh']];
        //     Lib.current.addChild( UIBuilder.create(Options, {
        //         left    : 100,
        //         top     : 150,
        //         options : opts
        //     }) );

        //     Lib.current.addChild( UIBuilder.create(Checkbox, {
        //         left : 100,
        //         top  : 250,
        //         text : 'Check me!'
        //     }) );

        //     Lib.current.addChild( UIBuilder.create(Slider, {
        //         left : 100,
        //         top  : 350,
        //         w    : 300
        //     }) );

        //     Lib.current.addChild( UIBuilder.create(Switch, {
        //         left : 400,
        //         top  : 50
        //     }) );

        //     Lib.current.addChild( UIBuilder.create(Progress, {
        //         left         : 400,
        //         top          : 150,
        //         w            : 300,
        //         interactive  : true,
        //         smoothChange : true,
        //         value        : 40
        //     }) );
        // //}
    }//function main()


}//class Main


