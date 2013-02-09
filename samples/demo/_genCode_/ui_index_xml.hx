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
__ui__widget1.addEventListener(ru.stablex.ui.events.WidgetEvent.RESIZE, function(event:nme.events.Event){
        ru.stablex.ui.UIBuilder.get("screens").h = __ui__widget1.h - ru.stablex.ui.UIBuilder.get("bottomMenu").h - ru.stablex.ui.UIBuilder.get("topMenu").h;

        if( nme.Lib.current.stage.stageWidth < 320 || nme.Lib.current.stage.stageHeight < 480 ){
            var popup = com.example.Main.alert({
                msg:'This app is designed for at least 320x480 screens. You may proceed but some things may go wrong.'
            });
            popup.show();
        }
    });
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
__ui__widget3.text = 'Radio & Checkboxes';
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
__ui__widget3.text = 'Skins';
__ui__widget3.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){ru.stablex.ui.UIBuilder.getAs("screens", ru.stablex.ui.widgets.ViewStack).show('skins');});
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
                    msg:'Toggle button has the same settings as simple one. Plus it has separate skin / icon / text for each state.'
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
                    msg:'Multi-state button has the same settings as simple one. Plus it has separate skin / icon / text for each state.'
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
__ui__widget2.align = '';
__ui__widget2.widthPt = 100;
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.left = 0;
__ui__widget3.padding = 15;
__ui__widget3.childPadding = 20;
__ui__widget3.align = 'left,top';
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Checkbox = new ru.stablex.ui.widgets.Checkbox();
if( ru.stablex.ui.UIBuilder.defaults.exists("Checkbox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Checkbox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'static text';
__ui__widget4.selected = true;
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Checkbox = new ru.stablex.ui.widgets.Checkbox();
if( ru.stablex.ui.UIBuilder.defaults.exists("Checkbox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Checkbox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.states.up.text = 'check me';
__ui__widget4.states.down.text = 'uncheck me';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Switch = new ru.stablex.ui.widgets.Switch();
if( ru.stablex.ui.UIBuilder.defaults.exists("Switch") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Switch");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Switch = new ru.stablex.ui.widgets.Switch();
if( ru.stablex.ui.UIBuilder.defaults.exists("Switch") ){
     var defs = 'Classic,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Switch");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.defaults = 'Classic,Dark';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Switch = new ru.stablex.ui.widgets.Switch();
if( ru.stablex.ui.UIBuilder.defaults.exists("Switch") ){
     var defs = 'DayNight,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Switch");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.labelOn.text = 'day';
__ui__widget4.defaults = 'DayNight,Dark';
__ui__widget4.labelOff.text = 'night';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.padding = 15;
__ui__widget3.right = 0;
__ui__widget3.childPadding = 20;
__ui__widget3.align = 'right,top';
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Radio = new ru.stablex.ui.widgets.Radio();
if( ru.stablex.ui.UIBuilder.defaults.exists("Radio") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Radio");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'radio 1';
__ui__widget4.group = 'demo';
__ui__widget4.icoBeforeLabel = false;
__ui__widget4.selected = true;
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Radio = new ru.stablex.ui.widgets.Radio();
if( ru.stablex.ui.UIBuilder.defaults.exists("Radio") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Radio");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'radio 2';
__ui__widget4.group = 'demo';
__ui__widget4.icoBeforeLabel = false;
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Radio = new ru.stablex.ui.widgets.Radio();
if( ru.stablex.ui.UIBuilder.defaults.exists("Radio") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Radio");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.states.up.text = 'radio?';
__ui__widget4.group = 'demo';
__ui__widget4.icoBeforeLabel = false;
__ui__widget4.states.down.text = 'radio!';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;})());
//<<<< include ui/toggles.xml <<<<

//>>>> include ui/skins.xml >>>>

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
__ui__widget1.name = 'skins';
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

var __ui__widget3 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'BASIC SKINS';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,LightTip'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'There are more skins + you can implement custom skin';
__ui__widget4.align = 'center,middle';
__ui__widget4.defaults = 'Default,LightTip';
__ui__widget4.widthPt = 100;
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.defaults = 'HR';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'Default,Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Paint';
__ui__widget3.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){ru.stablex.ui.UIBuilder.getAs("screens", ru.stablex.ui.widgets.ViewStack).show('paintSkin');});
__ui__widget3.w = 185;
__ui__widget3.defaults = 'Default,Settings';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'Default,Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Gradient';
__ui__widget3.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){ru.stablex.ui.UIBuilder.getAs("screens", ru.stablex.ui.widgets.ViewStack).show('gradientSkin');});
__ui__widget3.w = 185;
__ui__widget3.defaults = 'Default,Settings';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'Default,Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Tile';
__ui__widget3.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){ru.stablex.ui.UIBuilder.getAs("screens", ru.stablex.ui.widgets.ViewStack).show('tileSkin');});
__ui__widget3.w = 185;
__ui__widget3.defaults = 'Default,Settings';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = 'Default,Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'Slice9';
__ui__widget3.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){ru.stablex.ui.UIBuilder.getAs("screens", ru.stablex.ui.widgets.ViewStack).show('scale9Skin');});
__ui__widget3.w = 185;
__ui__widget3.defaults = 'Default,Settings';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;})());
//<<<< include ui/skins.xml <<<<

//>>>> include ui/paintSkin.xml >>>>

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
__ui__widget1.name = 'paintSkin';
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
__ui__widget2.childPadding = 10;
__ui__widget2.widthPt = 100;
__ui__widget2.paddingTop = 20;
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Paint skin options';
__ui__widget4.align = 'center,middle';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4.widthPt = 100;
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,DarkTip'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'There are more settings described in docs';
__ui__widget4.align = 'center,middle';
__ui__widget4.defaults = 'Default,DarkTip';
__ui__widget4.widthPt = 100;
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HRLight'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.defaults = 'HRLight';
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
__ui__widget3.unifyChildren = true;
__ui__widget3.align = 'middle,center';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Corners elipse width';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Slider = new ru.stablex.ui.widgets.Slider();
if( ru.stablex.ui.UIBuilder.defaults.exists("Slider") ){
     var defs = 'Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Slider");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.max = 300;
__ui__widget4.min = 1;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                ru.stablex.ui.UIBuilder.get("pex").skin.as(ru.stablex.ui.skins.Paint).corners[0] = __ui__widget4.value;
                ru.stablex.ui.UIBuilder.get("pex").refresh();
            });
__ui__widget4.defaults = 'Settings';
__ui__widget4.value = 50;
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
__ui__widget3.unifyChildren = true;
__ui__widget3.align = 'middle,center';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Corners elipse height';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Slider = new ru.stablex.ui.widgets.Slider();
if( ru.stablex.ui.UIBuilder.defaults.exists("Slider") ){
     var defs = 'Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Slider");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.max = 80;
__ui__widget4.min = 1;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                ru.stablex.ui.UIBuilder.get("pex").skin.as(ru.stablex.ui.skins.Paint).corners[1] = __ui__widget4.value;
                ru.stablex.ui.UIBuilder.get("pex").refresh();
            });
__ui__widget4.defaults = 'Settings';
__ui__widget4.value = 50;
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
__ui__widget3.unifyChildren = true;
__ui__widget3.align = 'middle,center';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Color';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Slider = new ru.stablex.ui.widgets.Slider();
if( ru.stablex.ui.UIBuilder.defaults.exists("Slider") ){
     var defs = 'Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Slider");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.max = 0xFFFFFF;
__ui__widget4.min = 0x000000;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                ru.stablex.ui.UIBuilder.get("pex").skin.as(ru.stablex.ui.skins.Paint).color = Std.int(__ui__widget4.value);
                ru.stablex.ui.UIBuilder.get("pex").refresh();
            });
__ui__widget4.defaults = 'Settings';
__ui__widget4.value = 0xAAAAAA;
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
__ui__widget3.unifyChildren = true;
__ui__widget3.align = 'middle,center';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Alpha';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Slider = new ru.stablex.ui.widgets.Slider();
if( ru.stablex.ui.UIBuilder.defaults.exists("Slider") ){
     var defs = 'Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Slider");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.max = 1;
__ui__widget4.min = 0;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                ru.stablex.ui.UIBuilder.get("pex").skin.as(ru.stablex.ui.skins.Paint).alpha = __ui__widget4.value;
                ru.stablex.ui.UIBuilder.get("pex").refresh();
            });
__ui__widget4.defaults = 'Settings';
__ui__widget4.value = 1;
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
__ui__widget3.unifyChildren = true;
__ui__widget3.align = 'middle,center';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Border width';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Slider = new ru.stablex.ui.widgets.Slider();
if( ru.stablex.ui.UIBuilder.defaults.exists("Slider") ){
     var defs = 'Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Slider");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.max = 20;
__ui__widget4.min = 0;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                ru.stablex.ui.UIBuilder.get("pex").skin.as(ru.stablex.ui.skins.Paint).border = __ui__widget4.value;
                ru.stablex.ui.UIBuilder.get("pex").refresh();
            });
__ui__widget4.defaults = 'Settings';
__ui__widget4.value = 2;
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
__ui__widget3.unifyChildren = true;
__ui__widget3.align = 'middle,center';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Border color';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Slider = new ru.stablex.ui.widgets.Slider();
if( ru.stablex.ui.UIBuilder.defaults.exists("Slider") ){
     var defs = 'Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Slider");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.max = 0xFFFFFF;
__ui__widget4.min = 0x000000;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                ru.stablex.ui.UIBuilder.get("pex").skin.as(ru.stablex.ui.skins.Paint).borderColor = Std.int(__ui__widget4.value);
                ru.stablex.ui.UIBuilder.get("pex").refresh();
            });
__ui__widget4.defaults = 'Settings';
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

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.h = 5;
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.h = 80;
__ui__widget3.id = 'pex';
__ui__widget3.widthPt = 90;
if(__ui__widget3.skin == null ){
     __ui__widget3.skin = new ru.stablex.ui.skins.Paint();
     if( Std.is(__ui__widget3.skin, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget3.skin, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget3.skin, ru.stablex.ui.skins.Paint).color = 0xAAAAAA;
cast(__ui__widget3.skin, ru.stablex.ui.skins.Paint).corners = [50, 50];
cast(__ui__widget3.skin, ru.stablex.ui.skins.Paint).border = 2;
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;})());
//<<<< include ui/paintSkin.xml <<<<

//>>>> include ui/gradientSkin.xml >>>>

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
__ui__widget1.name = 'gradientSkin';
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
__ui__widget2.childPadding = 10;
__ui__widget2.widthPt = 100;
__ui__widget2.paddingTop = 20;
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Gradient skin options';
__ui__widget4.align = 'center,middle';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4.widthPt = 100;
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,DarkTip'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'There are more settings described in docs';
__ui__widget4.align = 'center,middle';
__ui__widget4.defaults = 'Default,DarkTip';
__ui__widget4.widthPt = 100;
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HRLight'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.defaults = 'HRLight';
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
__ui__widget3.unifyChildren = true;
__ui__widget3.align = 'middle,center';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'First color';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Slider = new ru.stablex.ui.widgets.Slider();
if( ru.stablex.ui.UIBuilder.defaults.exists("Slider") ){
     var defs = 'Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Slider");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.max = 0xFFFFFF;
__ui__widget4.min = 0x000000;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                var colors = ru.stablex.ui.UIBuilder.get("gex").skin.as(ru.stablex.ui.skins.Gradient).colors;
                colors[0] = Std.int(__ui__widget4.value);
                colors[1] = colors[0] + Std.int((colors[2] - colors[0]) / 2);
                ru.stablex.ui.UIBuilder.get("gex").refresh();
            });
__ui__widget4.defaults = 'Settings';
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
__ui__widget3.unifyChildren = true;
__ui__widget3.align = 'middle,center';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Last color';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Slider = new ru.stablex.ui.widgets.Slider();
if( ru.stablex.ui.UIBuilder.defaults.exists("Slider") ){
     var defs = 'Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Slider");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.max = 0xFFFFFF;
__ui__widget4.min = 0x000000;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                var colors = ru.stablex.ui.UIBuilder.get("gex").skin.as(ru.stablex.ui.skins.Gradient).colors;
                colors[2] = Std.int(__ui__widget4.value);
                colors[1] = colors[0] + Std.int((colors[2] - colors[0]) / 2);
                ru.stablex.ui.UIBuilder.get("gex").refresh();
            });
__ui__widget4.defaults = 'Settings';
__ui__widget4.value = 0xFFFFFF;
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
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
__ui__widget3.text = 'Gradient skin can take any amount of colors';
__ui__widget3.h = 5;
__ui__widget3.align = 'left,bottom';
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
__ui__widget3.unifyChildren = true;
__ui__widget3.align = 'middle,center';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Ratio';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Slider = new ru.stablex.ui.widgets.Slider();
if( ru.stablex.ui.UIBuilder.defaults.exists("Slider") ){
     var defs = 'Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Slider");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.max = 255;
__ui__widget4.min = 0;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                ru.stablex.ui.UIBuilder.get("gex").skin.as(ru.stablex.ui.skins.Gradient).ratios[1] = Std.int(__ui__widget4.value);
                ru.stablex.ui.UIBuilder.get("gex").refresh();
            });
__ui__widget4.defaults = 'Settings';
__ui__widget4.value = 127;
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
__ui__widget3.unifyChildren = true;
__ui__widget3.align = 'middle,center';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Rotation';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Slider = new ru.stablex.ui.widgets.Slider();
if( ru.stablex.ui.UIBuilder.defaults.exists("Slider") ){
     var defs = 'Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Slider");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.max = Math.PI;
__ui__widget4.min = 0;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                ru.stablex.ui.UIBuilder.get("gex").skin.as(ru.stablex.ui.skins.Gradient).rotation = __ui__widget4.value;
                ru.stablex.ui.UIBuilder.get("gex").refresh();
            });
__ui__widget4.defaults = 'Settings';
__ui__widget4.value = Math.PI/2;
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

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.h = 5;
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.h = 80;
__ui__widget3.id = 'gex';
__ui__widget3.widthPt = 90;
if(__ui__widget3.skin == null ){
     __ui__widget3.skin = new ru.stablex.ui.skins.Gradient();
     if( Std.is(__ui__widget3.skin, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget3.skin, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget3.skin, ru.stablex.ui.skins.Gradient).colors = [0x000000, 0x888888, 0xFFFFFF];
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;})());
//<<<< include ui/gradientSkin.xml <<<<

//>>>> include ui/tileSkin.xml >>>>

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
__ui__widget1.name = 'tileSkin';
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
__ui__widget2.childPadding = 10;
__ui__widget2.widthPt = 100;
__ui__widget2.paddingTop = 20;
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Tile skin options';
__ui__widget4.align = 'center,middle';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4.widthPt = 100;
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,DarkTip'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'There are more settings described in docs';
__ui__widget4.align = 'center,middle';
__ui__widget4.defaults = 'Default,DarkTip';
__ui__widget4.widthPt = 100;
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HRLight'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.defaults = 'HRLight';
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
__ui__widget3.unifyChildren = true;
__ui__widget3.align = 'middle,center';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Width';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Slider = new ru.stablex.ui.widgets.Slider();
if( ru.stablex.ui.UIBuilder.defaults.exists("Slider") ){
     var defs = 'Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Slider");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.max = nme.Lib.current.stage.stageWidth * 0.9;
__ui__widget4.min = 10;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                ru.stablex.ui.UIBuilder.get("tex").w = __ui__widget4.value;
            });
__ui__widget4.defaults = 'Settings';
__ui__widget4.value = 64;
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
__ui__widget3.unifyChildren = true;
__ui__widget3.align = 'middle,center';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Height';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Slider = new ru.stablex.ui.widgets.Slider();
if( ru.stablex.ui.UIBuilder.defaults.exists("Slider") ){
     var defs = 'Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Slider");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.max = 200;
__ui__widget4.min = 10;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                ru.stablex.ui.UIBuilder.get("tex").h = __ui__widget4.value;
            });
__ui__widget4.defaults = 'Settings';
__ui__widget4.value = 64;
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

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.h = 5;
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.h = 64;
__ui__widget3.w = 64;
__ui__widget3.id = 'tex';
if(__ui__widget3.skin == null ){
     __ui__widget3.skin = new ru.stablex.ui.skins.Tile();
     if( Std.is(__ui__widget3.skin, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget3.skin, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget3.skin, ru.stablex.ui.skins.Tile).src = 'ui/android/img/nme.png';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;})());
//<<<< include ui/tileSkin.xml <<<<

//>>>> include ui/scale9Skin.xml >>>>

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
__ui__widget1.name = 'scale9Skin';
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
__ui__widget2.childPadding = 10;
__ui__widget2.widthPt = 100;
__ui__widget2.paddingTop = 20;
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Tile skin options';
__ui__widget4.align = 'center,middle';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4.widthPt = 100;
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,DarkTip'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'There are more settings described in docs';
__ui__widget4.align = 'center,middle';
__ui__widget4.defaults = 'Default,DarkTip';
__ui__widget4.widthPt = 100;
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HRLight'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.defaults = 'HRLight';
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
__ui__widget3.unifyChildren = true;
__ui__widget3.align = 'middle,center';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Width';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Slider = new ru.stablex.ui.widgets.Slider();
if( ru.stablex.ui.UIBuilder.defaults.exists("Slider") ){
     var defs = 'Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Slider");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.max = nme.Lib.current.stage.stageWidth * 0.9;
__ui__widget4.min = 10;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                ru.stablex.ui.UIBuilder.get("sex").w = __ui__widget4.value;
            });
__ui__widget4.defaults = 'Settings';
__ui__widget4.value = 64;
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
__ui__widget3.unifyChildren = true;
__ui__widget3.align = 'middle,center';
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,Dark'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Height';
__ui__widget4.defaults = 'Default,Dark';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Slider = new ru.stablex.ui.widgets.Slider();
if( ru.stablex.ui.UIBuilder.defaults.exists("Slider") ){
     var defs = 'Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Slider");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.max = 200;
__ui__widget4.min = 10;
__ui__widget4.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                ru.stablex.ui.UIBuilder.get("sex").h = __ui__widget4.value;
            });
__ui__widget4.defaults = 'Settings';
__ui__widget4.value = 64;
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

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.h = 5;
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.h = 64;
__ui__widget3.w = 64;
__ui__widget3.id = 'sex';
if(__ui__widget3.skin == null ){
     __ui__widget3.skin = new ru.stablex.ui.skins.Slice9();
     if( Std.is(__ui__widget3.skin, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget3.skin, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget3.skin, ru.stablex.ui.skins.Slice9).src = 'ui/android/img/winxp.png';
cast(__ui__widget3.skin, ru.stablex.ui.skins.Slice9).slice = [5, 10, 32, 48];
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;})());
//<<<< include ui/scale9Skin.xml <<<<

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

var __ui__widget3 : ru.stablex.ui.widgets.Progress = new ru.stablex.ui.widgets.Progress();
if( ru.stablex.ui.UIBuilder.defaults.exists("Progress") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Progress");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.max = 200;
__ui__widget3.addEventListener(nme.events.Event.ENTER_FRAME, function(event:nme.events.Event){
            __ui__widget3.value ++;
            if( __ui__widget3.value > __ui__widget3.max ) __ui__widget3.value = 0;
        });
__ui__widget3.widthPt = 95;
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
__ui__widget2.childPadding = 20;
__ui__widget2.align = 'top,center';
__ui__widget2.widthPt = 100;
__ui__widget2.paddingTop = 10;
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.widthPt = 100;
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Options list';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,LightTip'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Here are two most common cases for options list.';
__ui__widget4.align = 'center,middle';
__ui__widget4.defaults = 'Default,LightTip';
__ui__widget4.widthPt = 100;
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Widget = new ru.stablex.ui.widgets.Widget();
if( ru.stablex.ui.UIBuilder.defaults.exists("Widget") ){
     var defs = 'HR'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Widget");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.defaults = 'HR';
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Options = new ru.stablex.ui.widgets.Options();
if( ru.stablex.ui.UIBuilder.defaults.exists("Options") ){
     var defs = 'Default,Picker'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Options");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.options = [['apple', 'wow'], ['pancakes', 'yay'], ['peanut butter', 'doh']];
__ui__widget3.defaults = 'Default,Picker';
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Options = new ru.stablex.ui.widgets.Options();
if( ru.stablex.ui.UIBuilder.defaults.exists("Options") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Options");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.options = [['lion', 1], ['camel', 2], ['elephant', 3]];
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
__ui__widget2.childPadding = 30;
__ui__widget2.widthPt = 100;
__ui__widget2.paddingTop = 20;
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.Slider = new ru.stablex.ui.widgets.Slider();
if( ru.stablex.ui.UIBuilder.defaults.exists("Slider") ){
     var defs = 'Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Slider");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.h = 18;
__ui__widget3.defaults = 'Settings';
__ui__widget3.widthPt = 90;
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Slider = new ru.stablex.ui.widgets.Slider();
if( ru.stablex.ui.UIBuilder.defaults.exists("Slider") ){
     var defs = 'Settings'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Slider");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.slider.w = 50;
__ui__widget3.defaults = 'Settings';
__ui__widget3.widthPt = 90;
if(__ui__widget3.slider.skin == null ){
     __ui__widget3.slider.skin = new ru.stablex.ui.skins.Paint();
     if( Std.is(__ui__widget3.slider.skin, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget3.slider.skin, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget3.slider.skin, ru.stablex.ui.skins.Paint).color = 0x222222;
if(__ui__widget3.skin == null ){
     __ui__widget3.skin = new ru.stablex.ui.skins.Paint();
     if( Std.is(__ui__widget3.skin, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget3.skin, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget3.skin, ru.stablex.ui.skins.Paint).padding = 0;
cast(__ui__widget3.slider.skin, ru.stablex.ui.skins.Paint).padding = 2;
cast(__ui__widget3.skin, ru.stablex.ui.skins.Paint).corners = null;
cast(__ui__widget3.slider.skin, ru.stablex.ui.skins.Paint).corners = null;
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Slider = new ru.stablex.ui.widgets.Slider();
if( ru.stablex.ui.UIBuilder.defaults.exists("Slider") ){
     var defs = 'Haxe'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Slider");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.defaults = 'Haxe';
__ui__widget3.widthPt = 90;
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

var __ui__widget2 : ru.stablex.ui.widgets.TabStack = new ru.stablex.ui.widgets.TabStack();
if( ru.stablex.ui.UIBuilder.defaults.exists("TabStack") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("TabStack");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget2);
     }
}
__ui__widget2.name = 'tabs';
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.TabPage = new ru.stablex.ui.widgets.TabPage();
if( ru.stablex.ui.UIBuilder.defaults.exists("TabPage") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("TabPage");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.title.text = 'First tab';
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

var __ui__widget5 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.childPadding = 10;
__ui__widget5.align = 'left,middle';
__ui__widget5._onInitialize();

var __ui__widget6 : ru.stablex.ui.widgets.Radio = new ru.stablex.ui.widgets.Radio();
if( ru.stablex.ui.UIBuilder.defaults.exists("Radio") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Radio");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget6);
     }
}
__ui__widget6.text = 'Bottom tabs';
__ui__widget6.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                        if( !__ui__widget6.selected ) return;

                        var ts = __ui__widget6.getParentAs('tabs', ru.stablex.ui.widgets.TabStack);
                        ts.setChildIndex(ts.tabBar, ts.numChildren - 1);

                        //change tabs skins
                        var tab : ru.stablex.ui.widgets.TabPage;
                        for(i in 0...ts.numChildren){
                            tab = ( Std.is(ts.getChildAt(i), ru.stablex.ui.widgets.TabPage) ? cast(ts.getChildAt(i), ru.stablex.ui.widgets.TabPage) : null);
                            if( tab != null ){
                                tab.title.states.down.skinName = 'tabBottomActive';
                                tab.title.skinPressedName = 'tabBottomPressed';
                                tab.title.updateState();
                            }
                        }

                        ts.refresh();
                    });
__ui__widget6.group = 'tabsPos';
__ui__widget6._onInitialize();
__ui__widget6._onCreate();
__ui__widget5.addChild(__ui__widget6);

var __ui__widget6 : ru.stablex.ui.widgets.Radio = new ru.stablex.ui.widgets.Radio();
if( ru.stablex.ui.UIBuilder.defaults.exists("Radio") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Radio");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget6);
     }
}
__ui__widget6.text = 'Top tabs';
__ui__widget6.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                        if( !__ui__widget6.selected ) return;

                        var ts = __ui__widget6.getParentAs('tabs', ru.stablex.ui.widgets.TabStack);
                        ts.setChildIndex(ts.tabBar, 0);

                        //change tabs skins
                        var tab : ru.stablex.ui.widgets.TabPage;
                        for(i in 0...ts.numChildren){
                            tab = ( Std.is(ts.getChildAt(i), ru.stablex.ui.widgets.TabPage) ? cast(ts.getChildAt(i), ru.stablex.ui.widgets.TabPage) : null);
                            if( tab != null ){
                                tab.title.states.down.skinName = 'tabActive';
                                tab.title.skinPressedName = 'tabPressed';
                                tab.title.updateState();
                            }
                        }

                        ts.refresh();
                    });
__ui__widget6.group = 'tabsPos';
__ui__widget6._onInitialize();
__ui__widget6._onCreate();
__ui__widget5.addChild(__ui__widget6);
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.TabPage = new ru.stablex.ui.widgets.TabPage();
if( ru.stablex.ui.UIBuilder.defaults.exists("TabPage") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("TabPage");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.title.text = 'NME';
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

var __ui__widget5 : ru.stablex.ui.widgets.Bmp = new ru.stablex.ui.widgets.Bmp();
if( ru.stablex.ui.UIBuilder.defaults.exists("Bmp") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Bmp");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.src = 'ui/android/img/nme.png';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.TabPage = new ru.stablex.ui.widgets.TabPage();
if( ru.stablex.ui.UIBuilder.defaults.exists("TabPage") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("TabPage");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.title.text = 'HAXE';
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

var __ui__widget5 : ru.stablex.ui.widgets.Bmp = new ru.stablex.ui.widgets.Bmp();
if( ru.stablex.ui.UIBuilder.defaults.exists("Bmp") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Bmp");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.src = 'ui/android/img/haxe.png';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
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

var __ui__widget2 : ru.stablex.ui.widgets.ViewStack = new ru.stablex.ui.widgets.ViewStack();
if( ru.stablex.ui.UIBuilder.defaults.exists("ViewStack") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("ViewStack");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget2);
     }
}
__ui__widget2.id = 'vs';
__ui__widget2.widthPt = 100;
__ui__widget2.heightPt = 100;
__ui__widget2._onInitialize();

var __ui__widget3 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = 'DarkGray'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.name = 'page1';
__ui__widget3.align = 'center,top';
__ui__widget3.defaults = 'DarkGray';
__ui__widget3.paddingTop = 10;
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
__ui__widget4._onInitialize();

var __ui__widget5 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'ViewStack transitions';
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = 'Default,LightTip'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Also you can implement custom transitions.';
__ui__widget5.align = 'center,middle';
__ui__widget5.defaults = 'Default,LightTip';
__ui__widget5.widthPt = 100;
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
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Fade';
__ui__widget4.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){
                var trans : ru.stablex.ui.transitions.Fade = new ru.stablex.ui.transitions.Fade();
                trans.duration = 0.25;

                ru.stablex.ui.UIBuilder.getAs("vs", ru.stablex.ui.widgets.ViewStack).trans = trans;
                ru.stablex.ui.UIBuilder.getAs("vs", ru.stablex.ui.widgets.ViewStack).show('page2');
            });
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Random slide';
__ui__widget4.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){
                var direction : Array<String> = ['left', 'right', 'top', 'bottom'];
                var trans     : ru.stablex.ui.transitions.Slide = new ru.stablex.ui.transitions.Slide();
                trans.duration  = 0.25;
                trans.direction = direction[ Std.random(direction.length) ];

                ru.stablex.ui.UIBuilder.getAs("vs", ru.stablex.ui.widgets.ViewStack).trans = trans;
                ru.stablex.ui.UIBuilder.getAs("vs", ru.stablex.ui.widgets.ViewStack).show('page2');
            });
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.text = 'Scale up';
__ui__widget4.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){
                var trans : ru.stablex.ui.transitions.Scale = new ru.stablex.ui.transitions.Scale();
                trans.duration = 0.25;
                trans.scaleUp  = true;

                ru.stablex.ui.UIBuilder.getAs("vs", ru.stablex.ui.widgets.ViewStack).trans = trans;
                ru.stablex.ui.UIBuilder.getAs("vs", ru.stablex.ui.widgets.ViewStack).show('page2');
            });
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.name = 'btn';
__ui__widget4.text = 'Scale down';
__ui__widget4.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){
                var trans : ru.stablex.ui.transitions.Scale = new ru.stablex.ui.transitions.Scale();
                trans.duration = 0.25;
                trans.scaleUp  = false;

                ru.stablex.ui.UIBuilder.getAs("vs", ru.stablex.ui.widgets.ViewStack).trans = trans;
                ru.stablex.ui.UIBuilder.getAs("vs", ru.stablex.ui.widgets.ViewStack).show('page2');
            });
__ui__widget4._onInitialize();
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.VBox = new ru.stablex.ui.widgets.VBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("VBox") ){
     var defs = 'LightGray'.split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("VBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.name = 'page2';
__ui__widget3.defaults = 'LightGray';
__ui__widget3._onInitialize();

var __ui__widget4 : ru.stablex.ui.widgets.HBox = new ru.stablex.ui.widgets.HBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("HBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("HBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.paddingLeft = 10;
__ui__widget4.unifyChildren = true;
__ui__widget4.childPadding = 10;
__ui__widget4.paddingRight = 10;
__ui__widget4.widthPt = 100;
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
__ui__widget5.text = 'Fade';
__ui__widget5.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){
                    var trans : ru.stablex.ui.transitions.Fade = new ru.stablex.ui.transitions.Fade();
                    trans.duration = 0.25;

                    ru.stablex.ui.UIBuilder.getAs("vs", ru.stablex.ui.widgets.ViewStack).trans = trans;
                    ru.stablex.ui.UIBuilder.getAs("vs", ru.stablex.ui.widgets.ViewStack).show('page1');
                });
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.text = 'Random slide';
__ui__widget5.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){
                    var direction : Array<String> = ['left', 'right', 'top', 'bottom'];
                    var trans     : ru.stablex.ui.transitions.Slide = new ru.stablex.ui.transitions.Slide();
                    trans.duration  = 0.25;
                    trans.direction = direction[ Std.random(direction.length) ];

                    ru.stablex.ui.UIBuilder.getAs("vs", ru.stablex.ui.widgets.ViewStack).trans = trans;
                    ru.stablex.ui.UIBuilder.getAs("vs", ru.stablex.ui.widgets.ViewStack).show('page1');
                });
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);

var __ui__widget4 : ru.stablex.ui.widgets.HBox = new ru.stablex.ui.widgets.HBox();
if( ru.stablex.ui.UIBuilder.defaults.exists("HBox") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("HBox");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget4);
     }
}
__ui__widget4.paddingLeft = 10;
__ui__widget4.unifyChildren = true;
__ui__widget4.childPadding = 10;
__ui__widget4.paddingRight = 10;
__ui__widget4.widthPt = 100;
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
__ui__widget5.text = 'Scale up';
__ui__widget5.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){
                    var trans : ru.stablex.ui.transitions.Scale = new ru.stablex.ui.transitions.Scale();
                    trans.duration = 0.25;
                    trans.scaleUp  = true;

                    ru.stablex.ui.UIBuilder.getAs("vs", ru.stablex.ui.widgets.ViewStack).trans = trans;
                    ru.stablex.ui.UIBuilder.getAs("vs", ru.stablex.ui.widgets.ViewStack).show('page1');
                });
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);

var __ui__widget5 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget5);
     }
}
__ui__widget5.name = 'btn';
__ui__widget5.text = 'Scale down';
__ui__widget5.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){
                    var trans : ru.stablex.ui.transitions.Scale = new ru.stablex.ui.transitions.Scale();
                    trans.duration = 0.25;
                    trans.scaleUp  = false;

                    ru.stablex.ui.UIBuilder.getAs("vs", ru.stablex.ui.widgets.ViewStack).trans = trans;
                    ru.stablex.ui.UIBuilder.getAs("vs", ru.stablex.ui.widgets.ViewStack).show('page1');
                });
__ui__widget5._onInitialize();
__ui__widget5._onCreate();
__ui__widget4.addChild(__ui__widget5);
__ui__widget4._onCreate();
__ui__widget3.addChild(__ui__widget4);
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