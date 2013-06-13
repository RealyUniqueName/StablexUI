/**
@manual Creating custom widget

To create your own widget you need to extend one of ru.stablex.ui.widgets.* classes.
All of those classes extend <type>ru.stablex.ui.widgets.Widget</type>.

Let's create widget wich background is always filled with some user-defined color :)
First of all we need to write class for this widget:

<haxe>
/**
* Simple custom widget. Background color of this widget is defined by .color property.
*
*/
class ColorWidget extends ru.stablex.ui.widgets.Widget{

    //property to define background color. By default it's black
    public var color : Int = 0x000000;


    /**
    * If you need to do something in constructor, here is how it's done.
    *
    */
    public function new () : Void {
        super();

        //any code, you need

    }//function new()


    /**
    * This method is called at least once - on widget creation is complete.
    * It's also called everytime widget is resized.
    * For this widget we want to update background color on refresh.
    */
    override public function refresh () : Void {
        super.refresh();
        this._paintBackground();
    }//function refresh()


    /**
    * This method fills background with defined by `color` property color
    *
    */
    private function _paintBackground () : Void {
        this.graphics.clear();
        this.graphics.beginFill(this.color);
        this.graphics.drawRect(0, 0, this.w, this.h);
        this.graphics.endFill();
    }//function _paintBackground()
}//class ColorWidget
</haxe>

Now, to demonstrate it in action, create `main.xml`:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<HBox padding="20" childPadding="20">
    <|ColorWidget id="'custom'" w="200" h="100" color="0x0000FF" />
    <Button text="'set random color'" skin:Paint-color="0x999999" on-click="
        #ColorWidget(custom).color = Std.random(0xFFFFFF);
        #custom.refresh();
    "/>
</HBox>
</xml>

And don't forget to register new widget in StablexUI:

<haxe>
class Main extends flash.display.Sprite{
    /**
    * Enrty point
    *
    */
    static public function main () : Void{

        //Register our custom widget, so we can use it in xml
        ru.stablex.ui.UIBuilder.regClass('ColorWidget');

        //initialize StablexUI
        ru.stablex.ui.UIBuilder.init();

        //Create our UI
        flash.Lib.current.addChild( ru.stablex.ui.UIBuilder.buildFn('main.xml')() );
    }//function main()
}//class Main
</haxe>

See it in action: <a href="/demo/05_custom_widget.swf" target="_blank">flash</a> or <a href="/demo/05_custom_widget" target="_blank">html5</a>.
You can find sample source code in samples/05_custom_widget on <a href="https://github.com/RealyUniqueName/StablexUI" target="_blank">GitHub</a>.

*/