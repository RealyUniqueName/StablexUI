StablexUI
=========

Macro driven ui engine

Killer-features (i hope so):
1. No xml parsing at runtime. All xmls are preprocessed at compile time, so your app is loading faster. Also everything is still strictly typed ;)
2. Writing handlers (plain haxe code) right in xml;
3. Really crossplatform! Everything works in cpp, flash, html5;
4. Only parts of framework you use are compiled to your binaries. For example if you don't use buttons, their classes won't be compilled.
5. Relative positioning (you can define position  by any border of element - left, right, top, bottom in pixels or percentage of parent's size. Define width/height in percentage etc);
6. You can write haxe code right in attributes in xml to acces anything from anywhere! For example: < Text x="nme.Lib.current.stage.stageWidth/2" y="nme.Lib.current.stage.stageHeight/2" format-font="nme.Assets.getFont('fonts/myFont.ttf').fontName" text="'My hello world!'" / >
The only discomfort such flexibility leads to is that you need to use double quotes and single quotes simultaniousely for string attributes.
7. Easy skinning with 3-slice-scaling, 9-slice-scaling, tiling with texture or filling with color;
8. Don't worry about forgotten eventListeners. Just use widget.free() method to let GC destroy the object;
8. More features are implemented and will be described in docs!

Only basic elements are implemented for now. But i found that's enough for majority of mobile of and web games, so i've decided to publish StablexUI
Currenlty implemented:
1. Text fields
2. Buttons
4. Bitmaps
5. Skinnable Panels, VBox, HBox
6. View stacks (only one visible child at every moment)
7. More will be available soon ;)

Docs will be available soon.




