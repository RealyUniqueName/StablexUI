/**
@manual Creating custom widget classes with xml markup.

If you want to create your custom widget class, you have another option in addition to
one described in <type>manual.05_Custom_widgets</type>.

StablexUI provides data-driven way to create classes based on xml. You can convert
any ui xml file to class definition with <type>ru.stablex.ui.UIBuilder</type>.createClass()

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

Next step: create a class for this widget:

<haxe>
    /**
    * Enrty point
    *
    */
    static public function main () : Void{

        //register classes for usage in xml.
        // UIBuilder.regClass(...);
        // ...

        //create class for custom widget
        ru.stablex.ui.UIBuilder.createClass("custom.xml", "com.example.Custom");

        //initialize StablexUI
        ru.stablex.ui.UIBuilder.init("defaults.xml");

        //...
    }//function main()
</haxe>

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
@manual Tips

Since generated classes don't exist untill compiler find <type>ru.stablex.ui.UIBuilder</type>.createClass(...) calls, you
can get errors like "Class not found: com.example.Custom" if you try to import this class somewhere or extend it.
To avoid this problem it's recommended to dedicate main haxe file (one with static main() function) to StablexUI initialization.
Take a look at <a href="https://github.com/RealyUniqueName/StablexUI/tree/master/samples/xmlClasses" target="_blank">sample project</a> for this technique
and for example of extending generated class.

*/