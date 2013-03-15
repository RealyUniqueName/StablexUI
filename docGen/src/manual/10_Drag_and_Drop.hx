/**
@manual Drag'n'drop basics

Drag'n'drop is easy :) Use <type>ru.stablex.ui.Dnd</type>.drag() to drag and <type>ru.stablex.ui.events.DndEvent</type>.drop() or <type>ru.stablex.ui.events.DndEvent</type>.accept() to drop.

Here is how to drag:

<xml>
<Bmp src="'assets/cool_pic.png'" on-mouseDown="$Dnd.drag($this);" />
</xml>

Here is how to drop:

<xml>
<Widget w="100" h="100" on-mouseDown="cast(event, $DndEvent).accept($this);" />
</xml>

More complex example:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Widget w="800" h="600">

    <!-- Objects to drag -->
    <Bmp name="'cool'" src="'assets/cool_pic.png'" on-mouseDown="$Dnd.drag($this);" />
    <Bmp name="'another'" src="'assets/another_pic.png'" top="100" on-mouseDown="$Dnd.drag($this);" />

    <!-- Drop area -->
    <Widget w="200" heightPt="100" right="0" skin:Paint-color="0x00FF00" on-receiveDrop="
        var e = cast(event, $DndEvent);

        //we will accept only cool pictures
        if( e.obj.name == 'cool' ){
            e.accept($this);

        //other objects will be sent back
        }else{
            e.drop(true);
        }
    "/>

</Widget>
</xml>
*/