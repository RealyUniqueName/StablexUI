/**
@manual Skinnable widgets

<i>... IN PROGRESS ...</i>

Basic scinnable widget is <type>ru.stablex.ui.widgets.Panel</type>. You can apply skins to every widget,
wich is or extends <type>ru.stablex.ui.widgets.Panel</type>. There are three basic bethods for skins.
Plus regardless skin method you can draw borders. You can find examples of skin usage in samples/ on <a href="https://github.com/RealyUniqueName/StablexUI" target="_blank">GitHub</a>.
*/

/**
@manual Fill with color

To set widget's background color you need to specify .bgColor property and .bgAlpha property.
StablexUI uses <type>nme.display.Graphics</type>.beginFill(bgColor, bgAlpha) and .drowRoundRect()
methods to paint widget's background. Also note, till .bgAlpha is set to zero, widget won't be
painted at all. Here is example xml for half-transparent red panel:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Panel w="200" h="200" bgColor="0xFF0000" bgAlpha="0.5" />
</xml>
*/


/**
@manual Fill with bitmap

To fill widget's background with bitmap you need to specify .texture property.
StablexUI uses <type>nme.display.Graphics</type>.beginBitmapFill() for this method.
And .bgAlpha won't affect this method. Here is example xml for bitmap filled panel:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Panel w="200" h="200" texture="'assets/img/somePic.png'"/>
</xml>
*/


/**
@manual 3-slice-scaling, 9-slice-scaling

To use these methods you need to define .skinBmp property (wich is path to bitmap or asset ID)
and .skinSlices property. Here is description for .skinSlices:

<pre>
.skinSlices is <type>Array</type>&lt;<type>Int</type>&gt;. Depending on its length StablexUI will
choose 3- or 9-slice method:
Zero - 3-slice-scaling (horizontal). Bitmap is divided into two equal sized bitmaps.
       Middle part is filled with central column of pixels;
One  - 3-slice-scaling (horizontal). Bitmap is divided into two bitmaps. Middle part is
       filled with column of pixels with x = specified integer;
Two  - 3-slice-scaling (horizontal). Integers - left and right guidelines for slicing;
Four - 9-slice-scaling. Integers - vertical left, vertical right, horizontal top, horizontal bottom
       guidlines for slicing.
</pre>

You can also create skin-list with <type>ru.stablex.ui.UIBuilder</type>.regSkins() and then
instead of specifying .skinBmp and .skinSlices properties for every widget, just set .skin = &lt;skin_name&gt;
You can find examples of skin usage in samples/ on <a href="https://github.com/RealyUniqueName/StablexUI" target="_blank">GitHub</a>.
*/
