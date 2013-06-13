/**
@manual Creating UI elements

For StablexUI widgets are objects wich can be used in gui. These are buttons,
boxes, text fields, etc. All widgets' classes extend <type>ru.stablex.ui.widgets.Widget</type> wich extends <type>flash.display.Sprite</type>.

To create our first gui, let's write xml like this:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Text left="50" top="100" text="'My first widget!'"/>
</xml>

Please, notice that it's necessary to use double quotes and single quotes simultaneously
for string properties. Call this file 'first.xml' and place it wherever to your project.
You don't need to include this file in your assets managed by OpenFL.
Let's analyze content of the file:
    Line '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' must be the first line of any xml file;
    <type>ru.stablex.ui.widgets.Text</type> - class of widget we want to create;
    left, top - properties of Text widget class inherited from <type>ru.stablex.ui.widgets.Widget</type>.
                These properties define widget position by x and y coordinates respectively.
                Of course,  instead of .left and .top you can assign .x and .y properties
                directly in xml since these properties are inherited from <type>flash.display.Sprite</type>.
                And in this example you will get the same result using .x and .y,
                but it is recommended to always use .left and .top for widgets.
    text - own property of <type>ru.stablex.ui.widgets.Text</type> class (click to see api for that class).
StablexUI will create text field based on first.xml with text 'My first widget!'.
This field will be placed with .x=50 and .y=100.
Here is the haxe code wich will do the job:

<haxe>
flash.Lib.current.addChild( ru.stablex.ui.UIBuilder.buildFn('first.xml')() );
</haxe>

Don't forget empty parentheses after 'first.xml'. That's all! You've just created your first UI :)
Build your project to any target or see result in <a href="/demo/02_first.swf" target="_blank">flash</a> or in <a href="/demo/02_first" target="_blank">html5</a>.
Full project code is included in samples on <a href="https://github.com/RealyUniqueName/StablexUI" target="_blank">GitHub</a>.
*/

/**
@manual Under the hood

Remember double and single quotes and empty parentheses? I bet you think: "What for?".
It's because <type>ru.stablex.ui.UIBuilder</type>.buildFn() is a macro function wich generates a closure for gui creation.
To make it clear, next code does the same thing as code above:

<haxe>
var fn : Dynamic->ru.stablex.ui.Widgets.Text = ru.stablex.ui.UIBuilder.buildFn('first.xml');
flash.Lib.current.addChild( fn() );
</haxe>

Type of closure is <type>Dynamic</type>-&gt;<type>ru.stablex.ui.Widgets.Text</type> because the type of root element in xml
is <type>ru.stablex.ui.widgets.Text</type>. To see what does StablexUI actualy do, look at next code. This is how your code
is translated by StablexUI for haxe compiler when you build project:

<haxe>
var fn : Dynamic->ru.stablex.ui.Widgets.Text = function(arguments:Dynamic = null) : ru.stablex.ui.widgets.Text {
    var widget : ru.stablex.ui.widgets.Text = ... // UIBuilder actions to create widget object
    widget.left = 50;
    widget.top  = 100;
    widget.text = 'My first widget!';
    widget.onInitialize(); //Here widget is notified properties were applied
    widget.onCreate(); //Here widget is notified it is created
    return widget;
};
flash.Lib.current.addChild( fn() );
</haxe>

I guess, you understand about parentheses now. And single quotes are required for string
properties in xml because otherwise StablexUI will generate code

<haxe>
widget.text = My first widget!;
</haxe>

wich of course breaks Haxe syntax.
*/

/**
@manual Nested widgets

Every widget can contain children since <type>ru.stablex.ui.widgets.Widget</type> inherits from <type>flash.display.DisplayObjectContainer</type>.
Child widgets behave like ordinary display objects in terms of position/scale/alpha etc.
Lets modify above sample. Place that text field to another widget:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<!-- .w and .h properties define widget's area width and height respectively -->
<Widget skin:Paint-border="1" w="400" h="400" left="50" top="100">
    <Text left="50" top="100" text="'My first widget!'" />
</Widget>

</xml>

Now text field will be positioned in root widget's system of axes. Build project to see how it
looks or look at <a href="/demo/02_nested.swf" target="_blank">flash</a> or at <a href="/demo/02_nested" target="_blank">html5</a>
You can create nested widgets indefinite levels deep.
*/

/**
@manual Creating widgets at runtime without xml

It's also possible to create widgets with plain Haxe without xml.
For this purpose you should use <type>ru.stablex.ui.UIBuilder</type>.create() method.
Here is example how to create exactly the same widget as in our first excercise without xml:

<haxe>
var widget = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Text, {
    left : 50,
    top  : 100,
    text : 'My first widget!'
});
flash.Lib.current.addChild( widget );
</haxe>

Also you can add children. E.g. to get the same result as in `Nested widgets` section of this manual,
use following code:

<haxe>
var widget = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Widget, {
    w    : 400,
    h    : 400,
    left : 50,
    top  : 50,
    children : [
        ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Text, {
            left : 50,
            top  : 100,
            text : 'My first widget!'
        })
    ]
});
flash.Lib.current.addChild( widget );
</haxe>

To dynamically manage widget's children, use ordinary <type>flash.display.DisplayObjectContainer</type> methods:

<haxe>
widget1.addChild(widget2);
widget1.removeChild(widget2);
widget1.addChildAt(widget2, 0);
widget1.removeChildAt(0);
</haxe>

*/

/**
@manual Widget ID

Every widget has its own unique id. So you can get any widget object from any place in code:
To set widget id in xml, use `id` attribute:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Text id="'myWidget'" left="50" top="100" text="'My first widget!'"/>
</xml>

Or in haxe use `.id` property:

<haxe>
ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Text, {
    id   : 'myWidget',
    left : 50,
    top  : 100,
    text : 'My first widget!'
});
</haxe>

You can also change .id property any time at runtime as long as new value is unique across all existing widgets.
Then to get widget object anywhere in code, use following snippet:

<haxe>
var widget : ru.stablex.ui.widgets.Text = cast ru.stablex.ui.UIBuilder.get('myWidget');
trace(widget.text); //outputs: My first widget!

// or

var widget : ru.stablex.ui.widgets.Text = ru.stablex.UIBuilder.getAs('myWidget', ru.stablex.ui.widgets.Text);
trace(widget.text); //outputs: My first widget!
</haxe>
*/


/**
@manual Destroying widgets

To destroy widget use .free() method of <type>ru.stablex.ui.Widget</type> class.
All widget children will be removed, widget will remove itself from parent's display list
and remove any added eventListeners. Make sure you cleared any other links to that widget.
Method .free() has optional <type>Bool</type> parameter. Use .free(true) to also destroy every
child widget.
*/