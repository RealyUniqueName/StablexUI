/**
@manual Nested properties

In xml you can define `properties of properties of &lt;indefinite deep&gt;` of widgets.
For example <type>ru.stablex.ui.widgets.Text</type> widget has property 'label' wich is of type <type>flash.text.TextField</type>.
lets set `selectable` property of <type>flash.text.TextField</type> to false:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Text label-selectable="false" text="'You can\'t select me'"/>
</xml>

Now that text field .label.selectable == false. It's easy :) Here is how this xml
is translated by StablexUI for haxe compiler:

<haxe>
var widget : ru.stablex.ui.widgets.Text = ... // UIBuilder actions to create widget object
widget.text = 'You can\'t select me';
widget.label.selectable = false;
widget.onCreate();
</haxe>

You can define nested properties when creating widgets dynamically (in haxe code) like this:

<haxe>
var widget = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Text, {
    text  : 'You can\'t select me',
    label : {
        selectable : false
    }
});
</haxe>
*/

/**
@manual Type casting and object creation via attributes in xml

Some widget fields (e.g. `.skin` property) are not scalar. Such fields can take values of
different classes. In case of `.skin` property it can be any class, wich extends <type>ru.stablex.ui.skins.Skin</type>.
Thus we need to cast `.skin` to that class to be able to use specific fields, wich were not
declared in <type>ru.stablex.ui.skins.Skin</type>. Also such properties can be <type>null</type> on start, so we need to create
objects for them. Fortunately StablexUI gives you the ability to do all that things.
Since we started on `.skin` property, let me show you, how type casting and object creation
works in xml attributes. `.skin` is declared in <type>ru.stablex.ui.widgets.Widget</type> as <type>ru.stablex.ui.skins.Skin</type>. Let's assign instance of <type>ru.stablex.ui.skins.Paint</type>
to it. <type>ru.stablex.ui.skins.Paint</type> extends <type>ru.stablex.ui.skins.Skin</type>, so we can assign instances of <type>ru.stablex.ui.skins.Paint</type> to variables and properties typed as <type>ru.stablex.ui.skins.Skin</type>.
Here is xml wich does the job:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Widget w="100" h="100" skin:Paint-color="0x00FF00" skin:Paint-border="2"/>
</xml>

`-color` and `-border` are properties of <type>ru.stablex.ui.skins.Paint</type>;
This xml is translated by StablexUI for haxe compiler as follows:

<haxe>
var widget : ru.stablex.ui.widgets.Widget = ... // UIBuilder actions to create widget object
if( widget.skin == null ) widget.skin = new ru.stablex.ui.skins.Paint();
cast(widget.skin, ru.stablex.ui.skins.Paint).color  = 0x002200;
cast(widget.skin, ru.stablex.ui.skins.Paint).border = 1;
widget.onInitialize();
widget.onCreate();
</haxe>

Class <type>ru.stablex.ui.skins.Paint</type> must be registered with <type>ru.stablex.ui.UIBuilder</type>.regClass() (It is by default. See section "Xml placeholders" below)
*/

/**
@manual Handlers

It is possible to create handlers in xml. To create one, add on-&lt;eventShortcut&gt; attributes to tags in xml.
For example to process click, use `on-click` handler:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Button skin:Paint-color="0x002200" text="'Click me'" on-click="trace('Oops! You clicked it again!');"/>
</xml>

Handler's body can be any valid haxe code. Here is how above xml is translated by StablexUI for
haxe compiler:

<haxe>
var widget : ru.stablex.ui.widgets.Button = ... // UIBuilder actions to create widget object
if( widget.skin == null ) widget.skin = new ru.stablex.ui.skins.Paint();
cast(widget.skin, ru.stablex.ui.skins.Paint).color  = 0x002200;
widget.text = 'Click me';
widget.addEventListener(flash.events.MouseEvent.CLICK, function(event:flash.events.MouseEvent){
    trace('Oops! You clicked it again!');'
})
widget.skin = skin;
widget.onInitialize();
widget.onCreate();
</haxe>

There are some predefined handler types for most frequently used events:
(may be out of date, see <type>ru.stablex.ui.UIBuilder</type>.init() source code for full list)
<haxe>
on-enterFrame  -&gt; flash.events.Event.ENTER_FRAME
on-click       -&gt; flash.events.MouseEvent.CLICK
on-mouseDown   -&gt; flash.events.MouseEvent.MOUSE_DOWN
on-mouseUp     -&gt; flash.events.MouseEvent.MOUSE_UP
on-display     -&gt; flash.events.Event.ADDED_TO_STAGE
on-create      -&gt; ru.stablex.ui.events.WidgetEvent.CREATE
on-free        -&gt; ru.stablex.ui.events.WidgetEvent.FREE
on-resize      -&gt; ru.stablex.ui.events.WidgetEvent.RESIZE
on-scrollStart -&gt; ru.stablex.ui.events.WidgetEvent.SCROLL_START
on-scrollStop  -&gt; ru.stablex.ui.events.WidgetEvent.SCROLL_STOP
on-drag        -&gt; ru.stablex.ui.events.DndEvent.DRAG
on-drop        -&gt; ru.stablex.ui.events.DndEvent.DROP
on-receiveDrop -&gt; ru.stablex.ui.events.DndEvent.RECEIVE
</haxe>
*/

/**
@manual Custom handlers

You can define your own event shortcuts for xml handlers.
Let's register shortcut for <type>flash.events.MouseEvent</type>.MOUSE_WHEEL event.
To complete this task, we need to execute following code before <type>ru.stablex.ui.UIBuilder</type>.init() :

<haxe>
 //last argument is optional. See API for details.
 ru.stablex.ui.UIBuilder.regEvent('mouseWheel', 'flash.events.MouseEvent.MOUSE_WHEEL', 'flash.events.MouseEvent');

//initialize StablexUI
 ru.stablex.ui.UIBuilder.init();
</haxe>

Now you can use on-mouseWheel attribute in xml:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Button skin:Paint-color="0x002200" text="'Use mouse wheel over me'" on-mouseWheel="trace('Oops! You wheel it again!);"/>
</xml>

And this xml will be translated for compiler like this:

<haxe>
var widget : ru.stablex.ui.widgets.Button = ... // UIBuilder actions to create widget object
if( widget.skin == null ) widget.skin = new ru.stablex.ui.skins.Paint();
cast(widget.skin, ru.stablex.ui.skins.Paint).color  = 0x002200;
widget.text    = 'Use mouse wheel over me';
widget.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, function(event:flash.events.MouseEvent){
    trace('Oops! You wheel it again!');
});
widget.skin = skin;
widget.onInitialize();
widget.onCreate();
</haxe>
*/

/**
@manual Xml placeholders for Haxe code

Since you can't use `import` directive in xml, StablexUI introduces placeholders
to shorten haxe code in xml.

<pre>
<span class="placeholder">$this</span>       - replaced with current widget. Type of <span class="placeholder">$this</span> is the same type as current widget;
<span class="placeholder">$SomeClass</span>  - replaced with com.some.package.SomeClass. If registered
               with <type>ru.stablex.ui.UIBuilder</type>.regClass('com.some.package.SomeClass');
               .regClass() should be called before <type>ru.stablex.ui.UIBuilder</type>.init();
<span class="placeholder">#widgetId</span>   - replaced with <type>ru.stablex.ui.UIBuilder</type>.get('widgetId').
               Type of <span class="placeholder">#widgetId</span> is <type>ru.stablex.ui.widgets.Widget</type>;
<span class="placeholder">#SomeClass(widgetId)</span> - replaced with <type>ru.stablex.ui.UIBuilder</type>.getAs('widgetId', SomeClass);
               SomeClass must be registered with <type>ru.stablex.ui.UIBuilder</type>.regClass('com.pack.SomeClass') (or one of standart widgets)
               and must be of <type>Class</type>&lt;<type>ru.stablex.ui.widgets.Widget</type>&gt;
<span class="placeholder">@someArg</span>    - read section "Xml arguments" below.
</pre>
If you need to use characters '@', '#' or '$' without replacing them with placeholders code, you need
to type these characters twice. E.g. "trace('It costs $$45')" will output "It costs $45".
Let's investigate how these placeholders work in examples.

<h3>$this</h3>
Following xml will output '100' on runtime:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Widget w="100" h="200" skin:Paint-color="0x002200" on-click=" trace( $this.w ); "/>
</xml>

Such xml will be translated by StablexUI for haxe compiler like this:

<haxe>
var widget : ru.stablex.ui.widgets.Widget = ... // UIBuilder actions to create widget object
widget.w       = 100;
widget.h       = 200;
if( widget.skin == null ) widget.skin = new ru.stablex.ui.skins.Paint();
cast(widget.skin, ru.stablex.ui.skins.Paint).color  = 0x002200;
widget.addEventListener(flash.events.MouseEvent.CLICK, function(event:flash.events.Event){
    trace( widget.w ); //output: 100
});
widget.skin = skin;
widget.onInitialize();
widget.onCreate();
</haxe>

<h3>$SomeClass</h3>
Let's imagine we have following class:

<haxe>
 package com.packg;

import flash.Lib;
import ru.stablex.ui.UIBuilder;

/**
* Random testing
*/
class MyClass extends flash.display.Sprite{
    static public inline var TEST = 'here is MyClass';

    /**
    * Entry point
    *
    */
    static public function main () : Void{
        //initialize StablexUI
        UIBuilder.init();

        //register class for usage in xml
        UIBuilder.regClass('com.packg.MyClass');

        //Create UI
        Lib.current.addChild( UIBuilder.buildFn('ui.xml')() );
    }//function main()
}//class MyClass
</haxe>

And content of 'ui.xml':

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Widget id="'root'" w="100" h="200">
    <Button w="50" h="20" text="hit" on-click=" trace( $MyClass.TEST ); "
</Widget>
</xml>

Now if we run this project and click the button, we'll see output: 'here is MyClass'.

There are frequently used classes preregistered in StablexUI. The list can change in the latest
version of StablexUI, see <type>ru.stablex.ui.UIBuilder</type>.init() source code for the full list)
Here are some of them:

<pre>
 ru.stablex.ui.widgets.Text;
 ru.stablex.ui.widgets.InputText;
 ru.stablex.ui.widgets.Widget;
 ru.stablex.ui.widgets.Bmp;
 ru.stablex.ui.widgets.Button;
 ru.stablex.ui.widgets.Box;
 ru.stablex.ui.widgets.VBox;
 ru.stablex.ui.widgets.HBox;
 ru.stablex.ui.widgets.ViewStack;
 ru.stablex.ui.widgets.Mask;
 ru.stablex.ui.events.WidgetEvent;
 ru.stablex.ui.skins.Paint;
 ru.stablex.ui.skins.Tile;
 ru.stablex.ui.skins.Slice3;
 ru.stablex.ui.skins.Slice9;
 ru.stablex.TweenSprite;
 ru.stablex.ui.UIBuilder;
 flash.Lib;
 ru.stablex.Assets;
 flash.events.Event;
 flash.events.MouseEvent;
</pre>

<h3>#widgetId</h3>

This placeholder is translated to haxe in following code:

<haxe>
 ru.stablex.ui.UIBuilder.get('widgetId');
</haxe>

So you can use it when you need to operate with properties inherited from <type>ru.stablex.ui.widgets.Widget</type> like here:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Widget id="'root'" w="100" h="200" skin:Paint-color="0x002200">
    <Button w="50" h="20" text="'hit'" on-click=" trace( #root.w ); " />
</Widget>
</xml>

will output: 100

<h3>#SomeClass(widgetId)</h3>

You need this placeholder if you need to work with property, wich is not in list of <type>ru.stablex.ui.widgets.Widget</type>
(such as .text of <type>ru.stablex.ui.widgets.Text</type>)
For example, `#Text(txt)` will be translated to:

<haxe>
 ru.stablex.ui.UIBuilder.getAs('txt', ru.stablex.ui.widgets.Text);
</haxe>

And following xml will output text field content:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<VBox w="100" h="200" skin:Paint-color="0x002200">
    <Text id="'txt'" text="'Hello, world!'" />
    <Button w="50" h="20" text="'hit'" on-click=" trace( #Text(txt).text ); "
</VBox>
</xml>
*/

/**
@manual Xml arguments (`@someArg` placeholder)

You can pass arguments to closures cretaed with <type>ru.stablex.ui.UIBuilder</type>.buildFn().
It's an easy way to change data in xml on runtime.

For example, let's implement alert box. Create `alert.xml` and place there following code:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<VBox left="100" top="100" skin:Paint-color="0xbbbbbb" skin:Paint-border="2" padding="10" childPadding="5">

    <!-- Here we use argument to set text for text field -->
    <Text text="@message" />
    <Button text="'close'" skin:Paint-color="0x777777" skin:Paint-border="1" on-click=" $this.wparent.free(); " />
</VBox>
</xml>

That will be our alert box template. Now wee need main interface, from wich we will create alert boxes.
Create `main.xml`:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<HBox padding="10" childPadding="5">
    <InputText id="'input'" skin:Paint-border="1" skin:Paint-color="0xFFFFFF" w="150" h="20" autoSize="false" text="'type any message here'"/>

    <!-- Here we create on-click handler wich shows our alert box with input message -->
    <Button h="20" padding="5" text="'Show me the alert!'" skin:Paint-color="0xbbbbbb" skin:Paint-border="1" on-click="
        $Lib.current.addChild( $UIBuilder.buildFn('alert.xml')(
            {
                message : #InputText(input).text
            }
        ) );
    "/>
</HBox>
</xml>

And the last file we need - main class for project. Here is the code for Main.hx:

<haxe>
 package;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import ru.stablex.ui.UIBuilder;

/**
* StablexUI example created in this manual: http://ui.stablex.ru/doc#manual/04_Advanced_XML.html
* Section: Xml arguments (`@someArg` placeholder)
*
*/
class Main extends flash.display.Sprite{
    /**
    * Enrty point
    *
    */
    static public function main () : Void{
        Lib.current.stage.align     = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        //initialize StablexUI
        UIBuilder.init();

        //Create our UI
        Lib.current.addChild( UIBuilder.buildFn('main.xml')() );
    }//function main()
}//class Main
</haxe>

Build project or try <a href="/demo/04_alert.swf" target="_blank">flash</a> version or <a href="/demo/04_alert" target="_blank">html5</a>.
Full sample code is included in samples/04_arguments on <a href="https://github.com/RealyUniqueName/StablexUI" target="_blank">GitHub</a>.
*/