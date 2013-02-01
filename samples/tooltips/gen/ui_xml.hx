function(__ui__arguments:Dynamic = null) : ru.stablex.ui.widgets.Box {
var __ui__widget1 : ru.stablex.ui.widgets.Box = new ru.stablex.ui.widgets.Box();
if( ru.stablex.ui.UIBuilder.defaults.exists("Box") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Box");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget1);
     }
}
__ui__widget1.h = 600;
__ui__widget1.w = 800;
__ui__widget1._onInitialize();

var __ui__widget2 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget2);
     }
}
__ui__widget2.text = 'Roll over me to see tooltip';
__ui__widget2.h = 100;
__ui__widget2.w = 300;
if(__ui__widget2.skin == null ){
     __ui__widget2.skin = new ru.stablex.ui.skins.Paint();
     if( Std.is(__ui__widget2.skin, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget2.skin, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget2.skin, ru.stablex.ui.skins.Paint).color = 0x55AA55;
if(__ui__widget2.tip == null ){
     __ui__widget2.tip = new ru.stablex.ui.widgets.Tip();
     if( Std.is(__ui__widget2.tip, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget2.tip, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget2.tip, ru.stablex.ui.widgets.Tip).text = 'I am basic tooltip!';
cast(__ui__widget2.skin, ru.stablex.ui.skins.Paint).corners = [20];
__ui__widget2._onInitialize();
__ui__widget1.addChild(__ui__widget2);
__ui__widget2._onCreate();
__ui__widget1._onCreate();
return __ui__widget1;}