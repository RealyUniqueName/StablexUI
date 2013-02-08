function(__ui__arguments:Dynamic = null) : ru.stablex.ui.widgets.Floating {
var __ui__widget1 : ru.stablex.ui.widgets.Floating = new ru.stablex.ui.widgets.Floating();
if( ru.stablex.ui.UIBuilder.defaults.exists("Floating") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Floating");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget1);
     }
}
__ui__widget1.addEventListener(ru.stablex.ui.events.WidgetEvent.RESIZE, function(event:nme.events.Event){ru.stablex.ui.UIBuilder.get("screens").h = __ui__widget1.h - ru.stablex.ui.UIBuilder.get("bottomMenu").h - ru.stablex.ui.UIBuilder.get("topMenu").h;});
__ui__widget1.id = 'root';
__ui__widget1.widthPt = 100;
__ui__widget1.heightPt = 100;
if(__ui__widget1.skin == null ){
     __ui__widget1.skin = new ru.stablex.ui.skins.Paint();
     if( Std.is(__ui__widget1.skin, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget1.skin, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget1.skin, ru.stablex.ui.skins.Paint).color = 0x000000;
__ui__widget1._onInitialize();

var __ui__widget2 : ru.stablex.ui.widgets.HBox = new ru.stablex.ui.widgets.HBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("HBox") ){
     var defs = 'TopMenu'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("HBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget2);
     }
}
__ui__widget2.id = 'topMenu';
__ui__widget2.defaults = 'TopMenu';
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.Bmp = new ru.stablex.ui.widgets.Bmp();
if( ru.stablex.ui.UIBuilder.defaults.exists("Bmp") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Bmp");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.src = 'ui/android/img/ico/light/settings.png';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,H1'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'StablexUI';
__ui__widget3.defaults = 'Default,H1';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);

var __ui__widget2 : ru.stablex.ui.widgets.ViewStack = new ru.stablex.ui.widgets.ViewStack();
if( ru.stablex.ui.UIBuilder.defaults.exists("ViewStack") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("ViewStack");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget2);
     }
}
__ui__widget2.id = 'screens';
__ui__widget2.widthPt = 100;
if(__ui__widget2.trans == null ){
     __ui__widget2.trans = new ru.stablex.ui.transitions.Slide();
     if( Std.is(__ui__widget2.trans, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget2.trans, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget2.trans, ru.stablex.ui.transitions.Slide).direction = 'left';
cast(__ui__widget2.trans, ru.stablex.ui.transitions.Slide).duration = 0.2;
__ui__widget2._onInitialize();
//>>>> include ui/main.xml >>>>

__ui__widget2.addChild((function() : ru.stablex.ui.widgets.Widget {
var __ui__widget1 : ru.stablex.ui.widgets.Scroll = new ru.stablex.ui.widgets.Scroll();
if( ru.stablex.ui.UIBuilder.defaults.exists("Scroll") ){
     var defs = 'Screen'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Scroll");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget1);
     }
}
__ui__widget1.name = 'main';
__ui__widget1.defaults = 'Screen';
__ui__widget1._onInitialize();

var __ui__widget2 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = 'Menu'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget2);
     }
}
__ui__widget2.defaults = 'Menu';
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Buttons';
__ui__widget3.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){ru.stablex.ui.UIBuilder.getAs("screens", ru.stablex.ui.widgets.ViewStack).show('buttons');});
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HR';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Text fields';
__ui__widget3.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){ru.stablex.ui.UIBuilder.getAs("screens", ru.stablex.ui.widgets.ViewStack).show('textFields');});
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HR';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Toggles';
__ui__widget3.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){ru.stablex.ui.UIBuilder.getAs("screens", ru.stablex.ui.widgets.ViewStack).show('toggles');});
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HR';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Progress bar';
__ui__widget3.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){ru.stablex.ui.UIBuilder.getAs("screens", ru.stablex.ui.widgets.ViewStack).show('progressBars');});
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HR';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Options list';
__ui__widget3.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){ru.stablex.ui.UIBuilder.getAs("screens", ru.stablex.ui.widgets.ViewStack).show('options');});
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HR';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Sliders';
__ui__widget3.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){ru.stablex.ui.UIBuilder.getAs("screens", ru.stablex.ui.widgets.ViewStack).show('sliders');});
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HR';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'TabStack';
__ui__widget3.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){ru.stablex.ui.UIBuilder.getAs("screens", ru.stablex.ui.widgets.ViewStack).show('tabs');});
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HR';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'View stack transitions';
__ui__widget3.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){ru.stablex.ui.UIBuilder.getAs("screens", ru.stablex.ui.widgets.ViewStack).show('viewStack');});
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HR';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Fake item 1';
__ui__widget3.ico = null;
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HR';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Fake item 2';
__ui__widget3.ico = null;
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HR';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Fake item 3';
__ui__widget3.ico = null;
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HR';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Fake item 4';
__ui__widget3.ico = null;
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HR';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Fake item 5';
__ui__widget3.ico = null;
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HR';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Fake item 6';
__ui__widget3.ico = null;
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HR';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Fake item 7';
__ui__widget3.ico = null;
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HR';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Fake item 8';
__ui__widget3.ico = null;
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HR';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Fake item 9';
__ui__widget3.ico = null;
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HR';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Fake item 10';
__ui__widget3.ico = null;
__ui__widget3.defaults = 'MenuItem';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;})());
//<<<< include ui/main.xml <<<<

//>>>> include ui/buttons.xml >>>>

__ui__widget2.addChild((function() : ru.stablex.ui.widgets.Widget {
var __ui__widget1 : ru.stablex.ui.widgets.Scroll = new ru.stablex.ui.widgets.Scroll();
if( ru.stablex.ui.UIBuilder.defaults.exists("Scroll") ){
     var defs = 'Screen,Level1'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Scroll");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget1);
     }
}
__ui__widget1.name = 'buttons';
__ui__widget1.defaults = 'Screen,Level1';
__ui__widget1._onInitialize();

var __ui__widget2 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget2);
     }
}
__ui__widget2.childPadding = 20;
__ui__widget2.widthPt = 100;
__ui__widget2.paddingTop = 20;
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.HBox = new ru.stablex.ui.widgets.HBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("HBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("HBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.childPadding = 10;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Simple';
__ui__widget4.h = 60;
__ui__widget4.id = 'simpleButton';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'Default,Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){
                ru.stablex.ui.UIBuilder.getAs("screens", ru.stablex.ui.widgets.ViewStack).show('simpleButtonSettings');
            });
__ui__widget4.defaults = 'Default,Settings';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.HBox = new ru.stablex.ui.widgets.HBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("HBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("HBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.childPadding = 10;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Toggle = new ru.stablex.ui.widgets.Toggle();
if( ru.stablex.ui.UIBuilder.defaults.exists("Toggle") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Toggle");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.states.up.text = 'Toggle up';
__ui__widget4.states.down.text = 'Toggle down';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'Default,Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){
                var popup = com.example.Main.alert({
                    msg:'Toggle button has the same settings as simple one.\nPlus it has separate skin/icon/text for each state.'
                });
                popup.show();
            });
__ui__widget4.defaults = 'Default,Settings';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.HBox = new ru.stablex.ui.widgets.HBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("HBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("HBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.childPadding = 10;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.StateButton = new ru.stablex.ui.widgets.StateButton();
if( ru.stablex.ui.UIBuilder.defaults.exists("StateButton") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("StateButton");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.states.first.text = 'Multi-state button';
__ui__widget4.states.third.text = 'Third state';
__ui__widget4.states.second.text = 'Second state';
__ui__widget4.states.fourth.text = 'Fourth state';
__ui__widget4.order = ['first', 'second', 'third', 'fourth'];
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'Default,Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){
                var popup = com.example.Main.alert({
                    msg:'Multi-state button has the same settings as simple one.\nPlus it has separate skin/icon/text for each state.'
                });
                popup.show();
            });
__ui__widget4.defaults = 'Default,Settings';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;})());
//<<<< include ui/buttons.xml <<<<

//>>>> include ui/simpleButtonSettings.xml >>>>

__ui__widget2.addChild((function() : ru.stablex.ui.widgets.Widget {
var __ui__widget1 : ru.stablex.ui.widgets.Scroll = new ru.stablex.ui.widgets.Scroll();
if( ru.stablex.ui.UIBuilder.defaults.exists("Scroll") ){
     var defs = 'Screen,Level2'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Scroll");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget1);
     }
}
__ui__widget1.name = 'simpleButtonSettings';
__ui__widget1.defaults = 'Screen,Level2';
__ui__widget1._onInitialize();

var __ui__widget2 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget2);
     }
}
__ui__widget2.childPadding = 2;
__ui__widget2.widthPt = 100;
__ui__widget2.paddingTop = 20;
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Basic settings for button';
__ui__widget3.align = 'center,middle';
__ui__widget3.defaults = 'Default,Dark';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,DarkTip'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'There are more settings described in docs';
__ui__widget3.align = 'center,middle';
__ui__widget3.defaults = 'Default,DarkTip';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HRLight'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HRLight';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.HBox = new ru.stablex.ui.widgets.HBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("HBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("HBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.align = 'middle';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.left = 10;
__ui__widget4.align = 'left,middle';
__ui__widget4.widthPt = 60;
__ui__widget4._onInitialize();

var __ui__widget5 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Enable icon';
__ui__widget5.defaults = 'Default,Dark';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,DarkTip'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'It\'s also possible to set separate icon for each state';
__ui__widget5.defaults = 'Default,DarkTip';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Switch = new ru.stablex.ui.widgets.Switch();
if( ru.stablex.ui.UIBuilder.defaults.exists("Switch") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Switch");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.right = 10;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                var btn = ru.stablex.ui.UIBuilder.getAs("simpleButton", ru.stablex.ui.widgets.Button);

                if( __ui__widget4.selected ){
                    btn.ico.src = 'ui/android/img/ico/light/star.png';
                }else{
                    btn.ico = null;
                }

                btn.refresh();
            });
__ui__widget4.selected = false;
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HRLight'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HRLight';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.HBox = new ru.stablex.ui.widgets.HBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("HBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("HBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.align = 'middle';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.left = 10;
__ui__widget4.align = 'left,middle';
__ui__widget4.widthPt = 60;
__ui__widget4._onInitialize();

var __ui__widget5 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Vertical';
__ui__widget5.defaults = 'Default,Dark';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,DarkTip'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Whether label and icon should be placed top to bottom or left to right';
__ui__widget5.defaults = 'Default,DarkTip';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Switch = new ru.stablex.ui.widgets.Switch();
if( ru.stablex.ui.UIBuilder.defaults.exists("Switch") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Switch");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.right = 10;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                var btn = ru.stablex.ui.UIBuilder.getAs("simpleButton", ru.stablex.ui.widgets.Button);

                if( __ui__widget4.selected ){
                    btn.vertical = true;
                }else{
                    btn.vertical = false;
                }

                btn.alignElements();
            });
__ui__widget4.selected = false;
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HRLight'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HRLight';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.HBox = new ru.stablex.ui.widgets.HBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("HBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("HBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.align = 'middle';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.left = 10;
__ui__widget4.align = 'left,middle';
__ui__widget4.widthPt = 60;
__ui__widget4._onInitialize();

var __ui__widget5 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Icon before label';
__ui__widget5.defaults = 'Default,Dark';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Switch = new ru.stablex.ui.widgets.Switch();
if( ru.stablex.ui.UIBuilder.defaults.exists("Switch") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Switch");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.right = 10;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                var btn = ru.stablex.ui.UIBuilder.getAs("simpleButton", ru.stablex.ui.widgets.Button);

                if( __ui__widget4.selected ){
                    btn.icoBeforeLabel = true;
                }else{
                    btn.icoBeforeLabel = false;
                }

                btn.alignElements();
            });
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HRLight'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HRLight';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.HBox = new ru.stablex.ui.widgets.HBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("HBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("HBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.align = 'middle';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.left = 10;
__ui__widget4.align = 'left,middle';
__ui__widget4.widthPt = 60;
__ui__widget4._onInitialize();

var __ui__widget5 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Move apart';
__ui__widget5.defaults = 'Default,Dark';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,DarkTip'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Stick ico and text to opposite borders';
__ui__widget5.defaults = 'Default,DarkTip';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Switch = new ru.stablex.ui.widgets.Switch();
if( ru.stablex.ui.UIBuilder.defaults.exists("Switch") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Switch");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.right = 10;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                var btn = ru.stablex.ui.UIBuilder.getAs("simpleButton", ru.stablex.ui.widgets.Button);

                if( __ui__widget4.selected ){
                    btn.apart = true;
                }else{
                    btn.apart = false;
                }

                btn.alignElements();
            });
__ui__widget4.selected = false;
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HRLight'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'HRLight';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;})());
//<<<< include ui/simpleButtonSettings.xml <<<<

//>>>> include ui/textFields.xml >>>>

__ui__widget2.addChild((function() : ru.stablex.ui.widgets.Widget {
var __ui__widget1 : ru.stablex.ui.widgets.Scroll = new ru.stablex.ui.widgets.Scroll();
if( ru.stablex.ui.UIBuilder.defaults.exists("Scroll") ){
     var defs = 'Screen,Level1'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Scroll");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget1);
     }
}
__ui__widget1.name = 'textFields';
__ui__widget1.defaults = 'Screen,Level1';
__ui__widget1._onInitialize();

var __ui__widget2 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget2);
     }
}
__ui__widget2.widthPt = 100;
__ui__widget2.heightPt = 100;
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Text fields';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;})());
//<<<< include ui/textFields.xml <<<<

//>>>> include ui/toggles.xml >>>>

__ui__widget2.addChild((function() : ru.stablex.ui.widgets.Widget {
var __ui__widget1 : ru.stablex.ui.widgets.Scroll = new ru.stablex.ui.widgets.Scroll();
if( ru.stablex.ui.UIBuilder.defaults.exists("Scroll") ){
     var defs = 'Screen,Level1'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Scroll");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget1);
     }
}
__ui__widget1.name = 'toggles';
__ui__widget1.defaults = 'Screen,Level1';
__ui__widget1._onInitialize();

var __ui__widget2 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget2);
     }
}
__ui__widget2.widthPt = 100;
__ui__widget2.heightPt = 100;
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Toggles';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;})());
//<<<< include ui/toggles.xml <<<<

//>>>> include ui/progress.xml >>>>

__ui__widget2.addChild((function() : ru.stablex.ui.widgets.Widget {
var __ui__widget1 : ru.stablex.ui.widgets.Scroll = new ru.stablex.ui.widgets.Scroll();
if( ru.stablex.ui.UIBuilder.defaults.exists("Scroll") ){
     var defs = 'Screen,Level1'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Scroll");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget1);
     }
}
__ui__widget1.name = 'progressBars';
__ui__widget1.defaults = 'Screen,Level1';
__ui__widget1._onInitialize();

var __ui__widget2 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget2);
     }
}
__ui__widget2.widthPt = 100;
__ui__widget2.heightPt = 100;
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Progress bar';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;})());
//<<<< include ui/progress.xml <<<<

//>>>> include ui/options.xml >>>>

__ui__widget2.addChild((function() : ru.stablex.ui.widgets.Widget {
var __ui__widget1 : ru.stablex.ui.widgets.Scroll = new ru.stablex.ui.widgets.Scroll();
if( ru.stablex.ui.UIBuilder.defaults.exists("Scroll") ){
     var defs = 'Screen,Level1'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Scroll");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget1);
     }
}
__ui__widget1.name = 'options';
__ui__widget1.defaults = 'Screen,Level1';
__ui__widget1._onInitialize();

var __ui__widget2 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget2);
     }
}
__ui__widget2.widthPt = 100;
__ui__widget2.heightPt = 100;
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Options lists';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;})());
//<<<< include ui/options.xml <<<<

//>>>> include ui/sliders.xml >>>>

__ui__widget2.addChild((function() : ru.stablex.ui.widgets.Widget {
var __ui__widget1 : ru.stablex.ui.widgets.Scroll = new ru.stablex.ui.widgets.Scroll();
if( ru.stablex.ui.UIBuilder.defaults.exists("Scroll") ){
     var defs = 'Screen,Level1'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Scroll");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget1);
     }
}
__ui__widget1.name = 'sliders';
__ui__widget1.defaults = 'Screen,Level1';
__ui__widget1._onInitialize();

var __ui__widget2 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget2);
     }
}
__ui__widget2.widthPt = 100;
__ui__widget2.heightPt = 100;
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Sliders';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;})());
//<<<< include ui/sliders.xml <<<<

//>>>> include ui/tabs.xml >>>>

__ui__widget2.addChild((function() : ru.stablex.ui.widgets.Widget {
var __ui__widget1 : ru.stablex.ui.widgets.Scroll = new ru.stablex.ui.widgets.Scroll();
if( ru.stablex.ui.UIBuilder.defaults.exists("Scroll") ){
     var defs = 'Screen,Level1'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Scroll");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget1);
     }
}
__ui__widget1.name = 'tabs';
__ui__widget1.defaults = 'Screen,Level1';
__ui__widget1._onInitialize();

var __ui__widget2 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget2);
     }
}
__ui__widget2.widthPt = 100;
__ui__widget2.heightPt = 100;
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Tabs';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;})());
//<<<< include ui/tabs.xml <<<<

//>>>> include ui/viewStack.xml >>>>

__ui__widget2.addChild((function() : ru.stablex.ui.widgets.Widget {
var __ui__widget1 : ru.stablex.ui.widgets.Scroll = new ru.stablex.ui.widgets.Scroll();
if( ru.stablex.ui.UIBuilder.defaults.exists("Scroll") ){
     var defs = 'Screen,Level1'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Scroll");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget1);
     }
}
__ui__widget1.name = 'viewStack';
__ui__widget1.defaults = 'Screen,Level1';
__ui__widget1._onInitialize();

var __ui__widget2 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget2);
     }
}
__ui__widget2.widthPt = 100;
__ui__widget2.heightPt = 100;
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'ViewStack transitions';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;})());
//<<<< include ui/viewStack.xml <<<<

__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);

var __ui__widget2 : ru.stablex.ui.widgets.HBox = new ru.stablex.ui.widgets.HBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("HBox") ){
     var defs = 'BottomMenu'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("HBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget2);
     }
}
__ui__widget2.id = 'bottomMenu';
__ui__widget2.defaults = 'BottomMenu';
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MainBack'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){
            var vs = ru.stablex.ui.UIBuilder.getAs("screens", ru.stablex.ui.widgets.ViewStack);

            //change transition to slide back
            var transition     = vs.trans;
            vs.trans           = new ru.stablex.ui.transitions.Slide();
            vs.trans.duration  = 0.2;
            vs.trans.as(ru.stablex.ui.transitions.Slide).direction = 'right';

            //return previous screen
            vs.back();

            //recover default transition
            vs.trans = transition;
        });
__ui__widget3.defaults = 'MainBack';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MainHome'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){
            var vs = ru.stablex.ui.UIBuilder.getAs("screens", ru.stablex.ui.widgets.ViewStack);

            //change transition to slide back
            var transition     = vs.trans;
            vs.trans           = new ru.stablex.ui.transitions.Slide();
            vs.trans.duration  = 0.2;
            vs.trans.as(ru.stablex.ui.transitions.Slide).direction = 'right';

            //show main screen
            vs.show('main');
            vs.clearHistory();

            //recover default transition
            vs.trans = transition;
        });
__ui__widget3.defaults = 'MainHome';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MainRecent'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){});
__ui__widget3.defaults = 'MainRecent';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;}