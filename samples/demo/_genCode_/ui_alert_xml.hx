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
__ui__widget1.name = 'popup';
__ui__widget1.skinName = 'popup';
__ui__widget1.widthPt = 100;
__ui__widget1.heightPt = 100;
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
__ui__widget2.padding = 10;
__ui__widget2.childPadding = 10;
__ui__widget2.widthPt = 90;
if(__ui__widget2.skin == null ){
     __ui__widget2.skin = new ru.stablex.ui.skins.Paint();
     if( Std.is(__ui__widget2.skin, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget2.skin, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget2.skin, ru.stablex.ui.skins.Paint).color = 0x333333;
cast(__ui__widget2.skin, ru.stablex.ui.skins.Paint).corners = [10];
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
__ui__widget3.label.wordWrap = true;
__ui__widget3.text = __ui__arguments.msg;
__ui__widget3.widthPt = 90;
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);

var __ui__widget3 : ru.stablex.ui.widgets.Button = new ru.stablex.ui.widgets.Button();
if( ru.stablex.ui.UIBuilder.defaults.exists("Button") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Button");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget3);
     }
}
__ui__widget3.text = 'OK';
__ui__widget3.addEventListener(nme.events.MouseEvent.CLICK, function(event:nme.events.Event){__ui__widget3.getParent('popup').free();});
__ui__widget3._onInitialize();
__ui__widget3._onCreate();
__ui__widget2.addChild(__ui__widget3);
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;}