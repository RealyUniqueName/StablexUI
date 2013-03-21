/**
@manual Drag'n'drop basics

Drag'n'drop is easy :) Use <type>ru.stablex.ui.Dnd</type>.drag() to drag and <type>ru.stablex.ui.events.DndEvent</type>.drop() or <type>ru.stablex.ui.events.DndEvent</type>.accept() to drop.

Here is how to drag:

<xml>
<Bmp src="'assets/cool_pic.png'" on-mouseDown="$Dnd.drag($this);" />
</xml>

Here is how to drop:

<xml>
<Widget w="100" h="100" on-receiveDrop="event.accept($this);" />
</xml>

See <type>ru.stablex.ui.Dnd</type>.drag() for more options like filtering dropped objects, dropping on mouseDown etc.
More complex example:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Widget w="800" h="600">

    <!-- Objects to drag -->
    <Bmp src="'assets/cool_pic.png'" on-mouseDown="$Dnd.drag($this, null, 'cool');" />
    <Bmp src="'assets/another_pic.png'" top="100" on-mouseDown="$Dnd.drag($this);" />

    <!-- Drop area -->
    <Widget w="200" heightPt="100" right="0" skin:Paint-color="0x00FF00" on-receiveDrop="
        //we will accept only cool pictures
        if( event.key == 'cool' ){
            event.accept($this);
        }
    "/>

</Widget>
</xml>
*/