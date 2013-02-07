(function(){
ru.stablex.ui.UIBuilder.skins.set("Black1", function():ru.stablex.ui.skins.Skin{
var skin = new ru.stablex.ui.skins.Paint();
skin.color = 0x111111;
return skin;
});
ru.stablex.ui.UIBuilder.skins.set("BlackGradient1", function():ru.stablex.ui.skins.Skin{
var skin = new ru.stablex.ui.skins.Gradient();
skin.colors = [0x000000, 0x2b3034];
return skin;
});
ru.stablex.ui.UIBuilder.skins.set("BlackBlueStripe", function():ru.stablex.ui.skins.Skin{
var skin = new ru.stablex.ui.skins.Layer();
if(skin.current == null ){
     skin.current = new ru.stablex.ui.skins.Paint();
     if( Std.is(skin.current, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(skin.current, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(skin.current, ru.stablex.ui.skins.Paint).paddingBottom = 3;
if(skin.behind == null ){
     skin.behind = new ru.stablex.ui.skins.Paint();
     if( Std.is(skin.behind, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(skin.behind, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(skin.behind, ru.stablex.ui.skins.Paint).color = 0x33b5e5;
cast(skin.current, ru.stablex.ui.skins.Paint).color = 0x000000;
return skin;
});})()