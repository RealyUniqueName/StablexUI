(function() : Void {
if( !ru.stablex.ui.UIBuilder.defaults.exists("Tip") ) ru.stablex.ui.UIBuilder.defaults.set("Tip", new Hash());
ru.stablex.ui.UIBuilder.defaults.get("Tip").set("Default", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Tip = cast(__ui__widget0, ru.stablex.ui.widgets.Tip);
__ui__widget1.label.padding = 5;
__ui__widget1.label.format.size = 14;
__ui__widget1.label.format.color = 0xFFFFFF;
if(__ui__widget1.label.skin == null ){
     __ui__widget1.label.skin = new ru.stablex.ui.skins.Paint();
     if( Std.is(__ui__widget1.label.skin, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget1.label.skin, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget1.label.skin, ru.stablex.ui.skins.Paint).alpha = 0.7;
cast(__ui__widget1.label.skin, ru.stablex.ui.skins.Paint).color = 0x000000;
cast(__ui__widget1.label.skin, ru.stablex.ui.skins.Paint).corners = [10];
});})()