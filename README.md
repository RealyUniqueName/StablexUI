StablexUI
=========
Google group: https://groups.google.com/forum/#!forum/stablexui

Macro driven ui engine for Haxe OpenFL It's designed to give developer as much freedom as possible in customizing UI.
Supported targets: cpp (iOS, Android, Blackberry, webOS, Windows, Linux, MacOS), flash, html5, neko.

Online docs for API and basic features: http://ui.stablex.ru/doc

Demo with android-4.x-like theme (written completely in xml): http://ui.stablex.ru/demo/demo_flash/

[Projects using StablexUI](https://github.com/RealyUniqueName/Projects-using-StablexUI/blob/master/README.md)

Simple demos: http://ui.stablex.ru/demo


Features:
---------------
* Easy integration with any project. Just addChild StablexUI to any Sprite or Stage.
* Separate "view" from "controller". Create all UI via xml (but you still can create ui with plain haxe);
* Compile time xml parsing. All xmls can be preprocessed at compile time, so your app is loading faster. Also everything is still strictly typed ;)
* Run time xml parsing. You can update UI in already published apps without updating whole app.
* Custom meta tags for xml to implement functionality you need, but wich is not implemented in StablexUI;
* Writing handlers (plain haxe code) right in xml;
* Really crossplatform! Works in cpp, flash, html5;
* Easy Drag'n'Drop;
* Relative positioning (you can define position  by any border of element - left, right, top, bottom in pixels or percentage of parent's size. Define width/height in percentage etc);
* You can write haxe code right in attributes in xml to acces anything from anywhere! For example:
```xml
<Text text="'Hello world!'" x="flash.Lib.current.stage.stageWidth/2" />
```
* Easy skinning with 3-slice-scaling, 9-slice-scaling, tiling with texture, filling with color, gradient fill or your own custom skin processor;
* Flexible layout system (including custom layouts);
* Don't worry about forgotten eventListeners. Just use widget.free() method to let GC destroy the object;
* Ability to create custom classes for skinning, transitions, tooltips, etc;
* There is more! Some features are described in docs: http://ui.stablex.ru/doc;


Implemented widgets:
---------------
* Text: normal and input;
* Buttons: simple, toggle, multiple states;
* Checkbox;
* Radio;
* Bitmaps;
* VBox, HBox;
* Scroll container;
* Progress bar;
* Tabs;
* Tooltips;
* Sliders;
* Switch (on/off toggle);
* Options box (picker list / drop-down)
* View stacks (only one visible child at every moment);
* Clock (display time, display constant time value, countdown);
* More will be available soon ;)





