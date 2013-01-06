StablexUI
=========

Macro driven ui engine

online api docs: http://stablex.ru/ui/api

Features:
---------------
* No xml parsing at runtime. All xmls are preprocessed at compile time, so your app is loading faster. Also everything is still strictly typed ;)
* Writing handlers (plain haxe code) right in xml;
* Really crossplatform! Works in cpp, flash, html5;
* Only parts of framework you use are compiled to your binaries. For example if you don't use buttons, their classes won't be compilled.
* Relative positioning (you can define position  by any border of element - left, right, top, bottom in pixels or percentage of parent's size. Define width/height in percentage etc);
* You can write haxe code right in attributes in xml to acces anything from anywhere! For example: < Text x="nme.Lib.current.stage.stageWidth/2" y="nme.Lib.current.stage.stageHeight/2" format-font="nme.Assets.getFont('fonts/myFont.ttf').fontName" text="'My hello world!'" / >
The only discomfort such flexibility leads to is that you need to use double quotes and single quotes simultaniousely for string attributes.
* Easy skinning with 3-slice-scaling, 9-slice-scaling, tiling with texture or filling with color;
* Don't worry about forgotten eventListeners. Just use widget.free() method to let GC destroy the object;
* More features are implemented and will be described in docs!

Only basic elements are implemented now. But i found that's enough for majority of mobile and web games, so i've decided to publish StablexUI

Currenlty implemented:
---------------
* Text fields
* Buttons
* Bitmaps
* Skinnable Panels, VBox, HBox
* View stacks (only one visible child at every moment)
* More will be available soon ;)





