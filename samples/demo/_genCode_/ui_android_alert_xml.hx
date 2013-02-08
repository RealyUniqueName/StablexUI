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
__ui__widget1.skinName = 'popup';
__ui__widget1.addEventListener(nme.events.MouseEvent.MOUSE_DOWN, function(event:nme.events.Event){__ui__widget1.free();});
__ui__widget1.widthPt = 100;
__ui__widget1.heightPt = 100;
__ui__widget1._onInitialize();

var __ui__widget2 : ru.stablex.ui.widgets.Text = new ru.stablex.ui.widgets.Text();
if( ru.stablex.ui.UIBuilder.defaults.exists("Text") ){
     var defs = "Default".split(",");
     var defFns = ru.stablex.ui.UIBuilder.defaults.get("Text");
     for(i in 0...defs.length){
         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);
         if( defaultsFn != null ) defaultsFn(__ui__widget2);
     }
}
__ui__widget2.label.wordWrap = true;
__ui__widget2.text = __ui__arguments.msg;
__ui__widget2.widthPt = 90;
__ui__widget2._onInitialize();
__ui__widget2._onCreate();
__ui__widget1.addChild(__ui__widget2);
__ui__widget1._onCreate();
return __ui__widget1;}