/**
@manual Custom themes

Let's see how you can create your own theme.

Unlike <a href="#manual/07_Presets(Defaults).html">defautls</a> and <a href="#manual/06_Skin_system.html">skins</a> (which are written in xml)
themes are written in plain Haxe code.

In this example we will create a 'Rainbow' theme.
Create separate package for our theme.

<pre>
[project_source_directory]/rainbow/
</pre>

Since themes should be self-contained, all assets should be placed in that package in `assets` disrectory:

<pre>
[project_source_directory]/rainbow/assets/
</pre>

To the code! First of all our theme needs a main class which extends <type>ru.stablex.ui.Theme</type>

<haxe>
package rainbow;

class Main extends ru.stablex.ui.Theme {
    /**
    * This method will be automatically called after UIBuilder.init()
    * It's not required to define this method in theme.
    */
    static public function main () : Void {
        //do stuff on application start, if you need
    }//function main()
}
</haxe>

Now create skins definitions:

<haxe>
package rainbow;

class Skins {
    // helper method
    static private function colorSkin (color:Int) ru.stablex.ui.skins.Paint {
        var skin   = new ru.stablex.ui.skins.Paint();
        skin.color = color;
        return skin;
    }

    static public function rainbow () : ru.stablex.ui.skins.Img {
        var skin = new ru.stablex.ui.skins.Img();
        skin.scaleImg = true;
        /**
        * :NOTICE:
        *   To get resources of your theme (images, fonts, etc) use `Main.getBitmapData()`, `Main.getFont()` etc.
        *   Where `Main` - is the main class of your theme.
        */
        skin.src = Main.getBitmapData('assets/rainbow.png'); //This is `assets` folder of your theme, not your project.
        return skin;
    }

    static public function red () : ru.stablex.ui.skins.Paint {
        return colorSkin(0xFF0000);
    }

    static public function orange () : ru.stablex.ui.skins.Paint {
        return colorSkin(0xFF7F00);
    }

    static public function yellow () : ru.stablex.ui.skins.Paint {
        return colorSkin(0xFFFF00);
    }

    static public function green () : ru.stablex.ui.skins.Paint {
        return colorSkin(0x00FF00);
    }

    static public function blue () : ru.stablex.ui.skins.Paint {
        return colorSkin(0x0000FF);
    }

    static public function indigo () : ru.stablex.ui.skins.Paint {
        return colorSkin(0x4B0082);
    }

    static public function violet () : ru.stablex.ui.skins.Paint {
        return colorSkin(0x8B00FF);
    }
}
</haxe>

If you use this theme in your project at this point, you already will be able to use these
skins like this:

<xml>
 <!-- make green button using skin from Rainbow theme -->
 <Button text="'i am button'" skinName="'green'" />
</xml>

However to make a complete theme we need to define widgets sizes, fonts, behaviors on click etc.
Create a subpackage in your theme package and name it `defaults`:

<pre>
[project_source_directory]/rainbow/defaults
</pre>

In this package you need to create separate classes for each widget.
Let's do it for <type>ru.stablex.ui.widgets.Button</type> widget:

<haxe>
package rainbow.defaults;

//make an alias for widget class
import !ru.stablex.ui.widgets.Button in WButton;

class Button {
    /**
    *  Default button settings
    */
    static public function Default (w:ru.stablex.ui.widgets.Widget) : Void {
        var btn = cast(w, WButton);

        //make all buttons 185x40 by default
        btn.w = 185;
        btn.h = 40;

        //make them shift by 1 pixel down on mouse press and 1 pixel up on mouse release
        btn.onPress   = function() { btn.y ++; };
        btn.onRelease = function() { btn.y --; };

        //use green skin for normal state
        btn.skinName = 'green';
        //use yellow skin for hovered state
        btn.skinHoveredName = 'yellow';
        //make it rainbow on press
        btn.skinPressedName = 'rainbow';
    }//function Default()

    /**
    * Special `rainbow` buttons - they're always rainbow!
    */
    static public function Special (w:ru.stablex.ui.widgets.Widget) : Void {
        //apply default button settings:
        Default(w);

        var btn = cast(w, WButton);

        //make it rainbow in any state
        btn.skinName        = 'rainbow';
        btn.skinHoveredName = 'rainbow';
        btn.skinPressedName = 'rainbow';
    }
}
</haxe>

That's it! Our theme is ready. Now if we <a href="#manual/14_Using_themes.html">plug it in</a>, we can enjoy it in our UI
without any additional code:

<haxe>
    //somewhere in your app initialization code
    ru.stablex.ui.UIBuilder.setTheme('rainbow');
    ru.stablex.ui.UIBuilder.init();
</haxe>

<xml>
<VBox childPadding="10">
    <!-- Boring one color buttons -->
    <Button text="'Just green'" />
    <Button text="'Just red'" skinName="'red'" />
    <Button text="'Just orange'" skinName="'orange'" />
    <Button text="'Just blue'" skinName="'blue'" />
    <Button text="'Just yellow'" skinName="'yellow'" />
    <Button text="'Just violet'" skinName="'violet'" />
    <Button text="'Just indigo'" skinName="'indigo'" />
    <!-- Special `rainbow` button -->
    <Button defaults="'Special'" text="'I am so special!'"/>
</VBox>
</xml>

Since themes are written in plain Haxe you can do whatever you want. Like creating special widgets (e.g. Tachometer for racing theme :) )

PS: if you made a good theme and think it should be included in StablexUI, make a <a href="https://github.com/RealyUniqueName/StablexUI" target="_blank">pull request</a>!

*/
