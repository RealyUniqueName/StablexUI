/**
@manual Customizing text

All widgets which display text either extend or use <type>ru.stablex.ui.widget.Text</type> widget as a child.
To adjust text appearance you need to change fields of `.format` property which is <type>flash.text.TextFormat</type>

Here is how to do it in xml:
<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Text format-color="0xFF0000" format-italic="true" text="'Some text'"/>
<!-- Button widget extends Text widget -->
<Button format-size="28" text="'Hit me!'" />
<!-- TabPage uses <Radio> widget as `title`. And Radio extends Text -->
<TabStack>
    <TabPage title-format-color="0x00FF00" title-text="'Tab 1'"/>
</TabStack>
</xml>

And in Haxe:
<haxe>
var text = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Text, {
    text       : 'Some text',
    embedFonts : true,
    format     : {
        font   : ru.stablex.Assets.getFont('assets/font.ttf').fontName,
        italic : true,
        color  : 0xFF0000,
        size   : 18
    }
});
flash.Lib.current.addChild(text);
</haxe>

*/