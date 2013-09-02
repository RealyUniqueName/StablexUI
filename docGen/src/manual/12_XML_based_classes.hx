/**
@manual Creating custom widget classes with xml markup.

If you want to create your custom widget class, you have another option in addition to
one described in <type>manual.05_Custom_widgets</type>.

StablexUI provides data-driven way to create classes based on xml. You can convert
any ui xml file to class definition with <type>ru.stablex.ui.UIBuilder</type>.buildClass()

Let's dig into example. Imagine, you need a square widget with button in the middle.
And you need to use it in several places with different properties for button and different widget colors.
Let's start with xml for such widget - custom.xml:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Widget w="100" h="100" skin:Paint-color="0xFF0000">
    <HBox name="'box'" widthPt="100" heightPt="100" childPadding="4">
        <Button name="'btn'" text="'Yeah!'" skin:Paint-color="0x00FF55" on-click="trace('it works!');"/>
    </HBox>
</Widget>
</xml>

Now we need to let compiler know where to look for new class. For this purpose create
separate class Init.hx:

<haxe>
class Init{
    /**
    * Function called with `--macro` compiler flag
    *
    */
    macro static public function init () : Void{
        //create xml-based classes for custom widgets
        ru.stablex.ui.UIBuilder.buildClass("custom.xml", "com.example.Custom");
    }//function init()
}//class Init
</haxe>

And make compiler run Init.init() by adding `--macro` flag to your project file:

<xml>
<?xml version="1.0" encoding="utf-8"?>
<|project>

    <|meta title="StablexUI example" package="ru.stablex.ui" version="0.0.1" company="R.U.N" />
    <|app path="./build" file="stablexui" main="Main"/>

    <|window width="800" height="600" background="0xFFFFFF" fps="60"/>

    <!-- call this function before compilling the app -->
    <|haxeflag name="--macro" value="Init.init()"/>

    <|haxelib name="openfl" />
    <|haxelib name="actuate" />
    <|haxelib name="stablexui" />
</|project>
</xml>

Now you can instantiate com.example.Custom or use 'Custom' tag in xml to create widgets!
As a bonus this class also has fields 'box' and 'btn', which are <type>ru.stablex.ui.widgets.HBox</type> and <type>ru.stablex.ui.widgets.Button</type> instances.
Take a look at source xml. You'll see <type>ru.stablex.ui.widgets.HBox</type> and <type>ru.stablex.ui.widgets.Button</type> widgets with constant `name` attributes.
The rule is simple: all widgets with constant names in xml-based classes become class fields.
To clarify what i mean (my english is really bad :) ), i'll show you an example usage of generated class:
In haxe:

<haxe>
    //instantiate xml-based class
    var w = ru.stablex.ui.UIBuilder.create(Custom);
    trace( Type.typeof(w.box) ); //ru.stablex.ui.widgets.HBox
    trace( Type.typeof(w.btn) ); //ru.stablex.ui.widgets.Button
</haxe>

Or in xml:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<HBox w="800" h="600" childPadding="20">

    <!-- use generated widget class as usual -->
    <|Custom />
    <|Custom skin:Paint-color="0x0000FF"/>

    <!-- access widgets assigned to fields of generated class -->
    <|Custom h="200" btn-text="'no-no!'" box-align="'bottom,right'" box-padding="10" />

</HBox>
</xml>

Here is how it looks in <a href="http://ui.stablex.ru/demo/xmlClasses.swf" target="_blank">flash</a> and in <a href="http://ui.stablex.ru/demo/xmlClasses" target="_blank">html5</a>.
Source code can be found in Github repository in <a href="https://github.com/RealyUniqueName/StablexUI/tree/master/samples/xmlClasses" target="_blank">samples/xmlClasses</a> directory.

*/


/**
@manual Side effects

If you want to use custom widgets in your xml-based classes, you have to place
<type>ru.stablex.ui.UIBuilder</type>.regClass("com.examle.MyWidget") calls in Init.init()
right before the <type>ru.stablex.ui.UIBuilder</type>.buildClass() calls.
You can find example <a href="https://github.com/RealyUniqueName/StablexUI/tree/master/samples/xmlClasses" target="_blank">here</a>
*/