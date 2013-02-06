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

var __ui__widget3 : ru.stablex.ui.widgets.Scroll = new ru.stablex.ui.widgets.Scroll();
if( ru.stablex.ui.UIBuilder.defaults.exists("Scroll") ){
     var defs = 'Screen'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Scroll");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.name = 'main';
__ui__widget3.defaults = 'Screen';
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = 'Menu'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.defaults = 'Menu';
__ui__widget4._onInitialize();

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Buttons';
__ui__widget5.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){ru.stablex.ui.UIBuilder.getAs("screens", ru.stablex.ui.widgets.ViewStack).show('buttons');});
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Text fields';
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Toggles';
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Progress bar';
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Options list';
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Sliders';
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Tabs';
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Progress bar';
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'View stack';
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Fake item 1';
__ui__widget5.ico = null;
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Fake item 2';
__ui__widget5.ico = null;
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Fake item 3';
__ui__widget5.ico = null;
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Fake item 4';
__ui__widget5.ico = null;
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Fake item 5';
__ui__widget5.ico = null;
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Fake item 6';
__ui__widget5.ico = null;
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Fake item 7';
__ui__widget5.ico = null;
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Fake item 8';
__ui__widget5.ico = null;
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Fake item 9';
__ui__widget5.ico = null;
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.defaults = 'HR';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'MenuItem'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Fake item 10';
__ui__widget5.ico = null;
__ui__widget5.defaults = 'MenuItem';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Scroll = new ru.stablex.ui.widgets.Scroll();
if( ru.stablex.ui.UIBuilder.defaults.exists("Scroll") ){
     var defs = 'Screen'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Scroll");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.name = 'buttons';
__ui__widget3.defaults = 'Screen';
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
__ui__widget4.widthPt = 100;
__ui__widget4.heightPt = 100;
__ui__widget4._onInitialize();

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Simple button';
__ui__widget5.format.color = 0xFFFFFF;
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
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