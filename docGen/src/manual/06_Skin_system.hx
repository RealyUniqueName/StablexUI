/**
@manual Skin system

Every widget can be skinned using <type>ru.stablex.ui.widgets.Widget</type>.skin property.
This property is of type <type>ru.stablex.ui.skins.Skin</type>. You can choose any skinning class
from ru.stablex.ui.skins.* package or your custom class, wich extends Skin.

Here is example of using <type>ru.stablex.ui.skins.Paint</type> class to skin widget:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Widget w="100" h="100" skin:Paint-color="0x00FF00" skin:Paint-border="2"/>
</xml>

It creates instance of <type>ru.stablex.ui.skins.Paint</type> and assigns `.color` and `.border` properties to
that instance.
This xml is translated by StablexUI for haxe compiler as follows:

<haxe>
var widget : ru.stablex.ui.widgets.Widget = ... // UIBuilder actions to create widget object
if( widget.skin == null ) widget.skin = new ru.stablex.ui.skins.Paint(); //create instance of skin class
cast(widget.skin, ru.stablex.ui.skins.Paint).color  = 0x00FF00;          //skin adjustments
cast(widget.skin, ru.stablex.ui.skins.Paint).border = 2;
widget.onInitialize();
widget.onCreate();  //skin will be applied inside this call
</haxe>
*/

/**
@manual Skin presets

What if you don't want to specify skin settings for every tag in ui xml? Solution exists!
You can use skin presets. To describe skin presets, you need to pass through 2 simple steps.

Step 1. Create xml with skin presets. For example, `skins.xml`:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<|Skins>
    <!-- here goes `skinName`:`SkinClass` with list of skin properties -->
    <|red:Paint
        color       = "0x550000"
        borderColor = "0xFF0000"
        border      = "8"
    />
    <!-- another skin preset -->
    <|background:Tile
        src         = "'assets/img/background.jpg'"
        borderColor = "0x00FF00"
        borderAlpha = "0.5"
        border      = "2"
    />
    <!-- and another one -->
    <|winxp:Slice9
        src   = "'assets/img/winxp.png'"
        slice = "[5, 10, 32, 48]"
    />
    <!-- and so on -->
    <!-- ... -->
</|Skins>
</xml>

Step 2. Register your skin presets using <type>ru.stablex.ui.UIBuilder</type>
Here is example main class:

<haxe>
class Main extends flash.display.Sprite{
    /**
    * Enrty point
    *
    */
    static public function main () : Void{
        //initialize StablexUI
        ru.stablex.ui.UIBuilder.init();

        //register skins. It is required to call .regSkins() after .init()
        ru.stablex.ui.UIBuilder.regSkins('skins.xml');

        //Create our UI
        flash.Lib.current.addChild( ru.stablex.ui.UIBuilder.buildFn('ui.xml')() );
    }//function main()


}//class Main
</haxe>

That is all! Now you can use your skins by theirs names as in following ui xml:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<VBox skinName="'background'" w="700" h="500">
    <Widget skinName="'red'" w="100" h="50" />
    <Widget skinName="'winxp'" w="100" h="50" />
    <Button skinName="'red'" text="'just a button'" />
</VBox>
</xml>
*/


/**
@manual Custom skin class

You can create your own skin classes by extending <type>ru.stablex.ui.skins.Skin</type>. For example,
let's create skin wich draws fractal rectangles on widget. Here is the source code for Fractal.hx:

<haxe>
 package;
/**
* Draw fractal rectangles
*
*/
class Fractal extends ru.stablex.ui.skins.Skin{

    //Thickness of line used to draw rectangles
    public var lineThickness : Int = 2;
    //Color of line used to draw rectangles
    public var lineColor : Int = 0x000000;
    //step between rectangles in pixels
    public var step : Int = 10;


    /**
    * Draw skin
    *
    */
    override public function draw (widget:ru.stablex.ui.widgets.Widget) : Void {
        //make sure `step` is valid
        if( this.step <= 0 ) this.step = 10;

        //size of initial rectangle
        var width  : Float = widget.w;
        var height : Float = widget.h;

        //top-left corner of initial rectangle
        var x : Int = 0;
        var y : Int = 0;

        widget.graphics.lineStyle(this.lineThickness, this.lineColor);

        //draw rectangles
        while( width > this.step && height > this.step ){

            widget.graphics.drawRect(x, y, width, height);

            width  -= this.step;
            height -= this.step;

            x += this.step;
            y += this.step;
        }//while()
    }//function draw()
}//class Fractal
</haxe>

Now we need to register our new skin class:

<haxe>
 package;

/**
* Main class
*/
class Main extends flash.display.Sprite{
    /**
    * Enrty point
    *
    */
    static public function main () : Void{
        //Register our custom skin class, so we can use it in xml
        ru.stablex.ui.UIBuilder.regClass('Fractal');

        //initialize StablexUI
        ru.stablex.ui.UIBuilder.init();

        //Create our UI
        flash.Lib.current.addChild( UIBuilder.buildFn('main.xml')() );
    }//function main()
}//class Main
</haxe>

And here is showcase `main.xml`:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Widget
    w="400"
    h="200"
    skin:Fractal-lineThickness = "8"
    skin:Fractal-lineColor     = "0x00FF00"
    skin:Fractal-step          = "20"
/>
</xml>

Enjoy!
You can find full source code for this example in samples/06_custom_skin_class on <a href="https://github.com/RealyUniqueName/StablexUI" target="_blank">GitHub</a>.
*/