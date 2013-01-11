/**
@manual Nested properties

In xml you can define `properties of properties of &lt;indefinite deep&gt;` of widgets.
For example <type>ru.stablex.ui.widgets.Text</type> widget has property 'label' wich is of type <type>nme.text.TextField</type>.
lets set `selectable` property of <type>nme.text.TextField</type> to false:

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
@manual Handlers

It is possible to create handlers in xml. To create one, add on-&lt;eventShortcut&gt; attributes to tags in xml.
For example to process click, use `on-click` handler:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Button bgColor="0x002200" text="'Click me'" on-click="trace('Oops! You clicked it again!');"/>
</xml>

Handler's body can be any valid haxe code. Here is how above xml is translated by StablexUI for
haxe compiler:

<haxe>
var widget : ru.stablex.ui.widgets.Button = ... // UIBuilder actions to create widget object
widget.bgColor = 0x002200;
widget.text    = 'Click me';
widget.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){
    trace('Oops! You clicked it again!');'
})
widget.onCreate();
</haxe>

There are some predefined handler types for most frequently used events:

<haxe>
on-enterFrame -&gt; nme.events.Event.ENTER_FRAME
on-click      -&gt; nme.events.MouseEvent.CLICK
on-mouseDown  -&gt; nme.events.MouseEvent.MOUSE_DOWN
on-mouseUp    -&gt; nme.events.MouseEvent.MOUSE_UP
on-display    -&gt; nme.events.Event.ADDED_TO_STAGE
on-create     -&gt; ru.stablex.ui.events.WidgetEvent.CREATE
on-free       -&gt; ru.stablex.ui.events.WidgetEvent.FREE
on-resize     -&gt; ru.stablex.ui.events.WidgetEvent.RESIZE
</haxe>
*/

/**
@manual Custom handlers

You can define your own event shortcuts for xml handlers.
Let's register shortcut for <type>nme.events.MouseEvent</type>.MOUSE_WHEEL event.
To complete this task, we need to execute following code before <type>ru.stablex.ui.UIBuilder</type>.init() :

<haxe>
 ru.stablex.ui.UIBuilder.regEvent('mouseWheel', 'nme.events.MouseEvent.MOUSE_WHEEL');

//initialize StablexUI
 ru.stablex.ui.UIBuilder.init();
</haxe>

Now you can use on-mouseWheel attribute in xml:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Button bgColor="0x002200" text="'Use mouse wheel over me'" on-mouseWheel="trace('Oops! You wheel it again!);"/>
</xml>

And this xml will be translated for compiler like this:

<haxe>
var widget : ru.stablex.ui.widgets.Button = ... // UIBuilder actions to create widget object
widget.bgColor = 0x002200;
widget.text    = 'Use mouse wheel over me';
widget.addEventListener(nme.events.MouseEvent.MOUSE_WHEEL, function(event:nme.events.Event){
    trace('Oops! You wheel it again!');
});
widget.onCreate();
</haxe>
*/

/**
@manual Xml placeholders for Haxe code

Since you can't use `import` directive in xml, StablexUI introduces placeholders
to shorten haxe code in xml.

<pre>
 $this       - replaced with current widget. Type of $this is the same type as current widget;
 $SomeClass  - replaced with com.some.package.SomeClass. If registered
               with <type>ru.stablex.ui.UIBuilder</type>.regClass('com.some.package.SomeClass');
               .regClass() should be called before <type>ru.stablex.ui.UIBuilder</type>.init();
 #widgetId   - replaced with <type>ru.stablex.ui.UIBuilder</type>.get('widgetId').
               Type of #widgetId is <type>ru.stablex.ui.widgets.Widget</type>;
 #SomeClass(widgetId) - replaced with <type>ru.stablex.ui.UIBuilder</type>.getAs('widgetId', SomeClass);
               SomeClass must be registered with <type>ru.stablex.ui.UIBuilder</type>.regClass('com.pack.SomeClass') (or one of standart widgets)
               and must be of <type>Class</type>&lt;<type>ru.stablex.ui.widgets.Widget</type>&gt;
 @someArg    - read section "Xml arguments" below.
</pre>

Let's investigate how these placeholders work in examples.

<h3>$this</h3>
Following xml will output '100' on runtime:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Panel w="100" h="200" bgColor="0x002200" on-click=" trace( $this.w ); "/>
</xml>

Such xml will be translated by StablexUI for haxe compiler like this:

<haxe>
var widget : ru.stablex.ui.widgets.Panel = ... // UIBuilder actions to create widget object
widget.w       = 100;
widget.h       = 200;
widget.bgColor = 0x002200;
widget.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){
    trace( widget.w ); //output: 100
});
widget.onCreate();
</haxe>

<h3>$SomeClass</h3>
Let's imagine we have following class:

<haxe>
 package com.packg;

import nme.Lib;
import ru.stablex.ui.UIBuilder;

/**
* Random testing
*/
class MyClass extends nme.display.Sprite{
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

<Panel id="'root'" w="100" h="200">
    <Button w="50" h="20" text="hit" on-click=" trace( $MyClass.TEST ); "
</Panel>
</xml>

Now if we run this project and click the button, we'll see output: 'here is MyClass'.

There are some frequently used classes preregistered in StablexUI. Here is the list:

<pre>
 ru.stablex.ui.widgets.Text;
 ru.stablex.ui.widgets.InputText;
 ru.stablex.ui.widgets.Panel;
 ru.stablex.ui.widgets.Widget;
 ru.stablex.ui.widgets.Bmp;
 ru.stablex.ui.widgets.Button;
 ru.stablex.ui.widgets.Box;
 ru.stablex.ui.widgets.VBox;
 ru.stablex.ui.widgets.HBox;
 ru.stablex.ui.widgets.ViewStack;
 ru.stablex.ui.widgets.Mask;
 ru.stablex.ui.events.WidgetEvent;
 ru.stablex.TweenSprite;
 ru.stablex.ui.UIBuilder;
 nme.Lib;
 ru.stablex.Assets;
 nme.events.Event;
 nme.events.MouseEvent;
</pre>

<h3>#widgetId</h3>

This placeholder is translated to haxe in following code:

<haxe>
 ru.stablex.ui.UIBuilder.get('widgetId');
</haxe>

So you can use it when you need to operate with properties inherited from <type>ru.stablex.ui.widgets.Widget</type> like here:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Panel id="'root'" w="100" h="200" bgColor="0x002200">
    <Button w="50" h="20" text="'hit'" on-click=" trace( #root.w ); " />
</Panel>
</xml>

will output: 100

<h3>#SomeClass(widgetId)</h3>

You need this placeholder if you need to work with property, wich is not in list of <type>ru.stablex.ui.widgets.Widget</type>
(such as .bgColor of <type>ru.stablex.ui.widgets.Panel</type>)
For example, `#Panel(root)` will be translated to:

<haxe>
 ru.stablex.ui.UIBuilder.getAs('root', ru.stablex.ui.widgets.Panel);
</haxe>

And following xml will output panel's color:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Panel id="'root'" w="100" h="200" bgColor="0x002200">
    <Button w="50" h="20" text="'hit'" on-click=" trace( #Panel(root).bgColor ); "
</Panel>
</xml>
*/

/**
@manual Xml arguments (`@someArg` placeholder)

You can pass arguments to closures cretaed with <type>ru.stablex.ui.UIBuilder</type>.buildFn().
It's an easy way to change data in xml on runtime.

For example, let's implement alert box. Create `alert.xml` and place there following code:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<VBox left="100" top="100" bgColor="0xbbbbbb" border="2" autoSize="true" padding="10" childPadding="5">
    <Text text="@message" />
    <Button w="50" h="20" text="'close'" bgColor="0x777777" border="1" on-click=" $this.wparent.free(); " />
</VBox>
</xml>

That will be our alert box template. Now wee need main interface, from wich we will create alert boxes.
Create `main.xml`:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<HBox autoSize="true" padding="10" childPadding="5">
    <InputText id="'input'" border="1" bgColor="0xFFFFFF" w="150" h="20" autoSize="false" text="'type any message here'"/>

    <!-- Here we create on-click handler wich shows our alert box and pass input message as argument -->
    <Button autoWidth="true" h="20" padding="5" text="'Show me the alert!'" bgColor="0xbbbbbb" border="1" on-click="
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

import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.Lib;
import ru.stablex.ui.UIBuilder;

/**
* StablexUI example created in this manual: http://stablex.ru/ui/doc#manual/04_Advanced_XML.html
* Section: Xml arguments (`@someArg` placeholder)
*
*/
class Main extends nme.display.Sprite{
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

Build project or try <a href="/ui/demo/04_alert.swf" target="_blank">flash</a> version or <a href="/ui/demo/04_alert" target="_blank">html5</a>.
Full sample code is included in samples/04_arguments on <a href="https://github.com/RealyUniqueName/StablexUI" target="_blank">GitHub</a>.
*/