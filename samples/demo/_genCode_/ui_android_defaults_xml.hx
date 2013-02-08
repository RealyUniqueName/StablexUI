(function() : Void {
nme.Lib.current.stage.removeEventListener(nme.events.Event.ENTER_FRAME, ru.stablex.ui.UIBuilder.skinQueue);
nme.Lib.current.stage.addEventListener(nme.events.Event.ENTER_FRAME, ru.stablex.ui.UIBuilder.skinQueue);
if( !ru.stablex.ui.UIBuilder.defaults.exists("Text") ) ru.stablex.ui.UIBuilder.defaults.set("Text", new Hash());
ru.stablex.ui.UIBuilder.defaults.get("Text").set("Default", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Text = cast(__ui__widget0, ru.stablex.ui.widgets.Text);
__ui__widget1.format.color = 0xFFFFFF;
__ui__widget1.format.font = ru.stablex.Assets.getFont('ui/android/fonts/regular.ttf').fontName;
__ui__widget1.format.size = 14;
__ui__widget1.label.selectable = false;
});
ru.stablex.ui.UIBuilder.defaults.get("Text").set("Dark", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Text = cast(__ui__widget0, ru.stablex.ui.widgets.Text);
__ui__widget1.format.color = 0x111111;
});
ru.stablex.ui.UIBuilder.defaults.get("Text").set("DarkTip", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Text = cast(__ui__widget0, ru.stablex.ui.widgets.Text);
__ui__widget1.label.wordWrap = true;
__ui__widget1.format.color = 0x7f7f7f;
__ui__widget1.format.size = 12;
__ui__widget1.widthPt = 100;
});
ru.stablex.ui.UIBuilder.defaults.get("Text").set("H1", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Text = cast(__ui__widget0, ru.stablex.ui.widgets.Text);
__ui__widget1.padding = 10;
__ui__widget1.format.size = 22;
});
if( !ru.stablex.ui.UIBuilder.defaults.exists("Scroll") ) ru.stablex.ui.UIBuilder.defaults.set("Scroll", new Hash());
ru.stablex.ui.UIBuilder.defaults.get("Scroll").set("Screen", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Scroll = cast(__ui__widget0, ru.stablex.ui.widgets.Scroll);
__ui__widget1.hBar = null;
__ui__widget1.hScroll = false;
__ui__widget1.vBar.w = 5;
__ui__widget1.vBar.visible = false;
__ui__widget1.skinName = 'Black1';
__ui__widget1.vBar.right = 2;
__ui__widget1.addEventListener(ru.stablex.ui.events.WidgetEvent.SCROLL_STOP, function(event:nme.events.Event){__ui__widget1.vBar.visible = false;});
__ui__widget1.widthPt = 100;
__ui__widget1.heightPt = 100;
__ui__widget1.addEventListener(ru.stablex.ui.events.WidgetEvent.SCROLL_START, function(event:nme.events.Event){__ui__widget1.vBar.visible = true;});
});
ru.stablex.ui.UIBuilder.defaults.get("Scroll").set("Level1", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Scroll = cast(__ui__widget0, ru.stablex.ui.widgets.Scroll);
__ui__widget1.skinName = 'BlackGradient1';
});
ru.stablex.ui.UIBuilder.defaults.get("Scroll").set("Level2", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Scroll = cast(__ui__widget0, ru.stablex.ui.widgets.Scroll);
if(__ui__widget1.skin == null ){
     __ui__widget1.skin = new ru.stablex.ui.skins.Paint();
     if( Std.is(__ui__widget1.skin, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget1.skin, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget1.skin, ru.stablex.ui.skins.Paint).color = 0xf2f2f2;
});
if( !ru.stablex.ui.UIBuilder.defaults.exists("Slider") ) ru.stablex.ui.UIBuilder.defaults.set("Slider", new Hash());
ru.stablex.ui.UIBuilder.defaults.get("Slider").set("Default", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Slider = cast(__ui__widget0, ru.stablex.ui.widgets.Slider);
__ui__widget1.h = 5;
__ui__widget1.w = 5;
if(__ui__widget1.slider.skin == null ){
     __ui__widget1.slider.skin = new ru.stablex.ui.skins.Paint();
     if( Std.is(__ui__widget1.slider.skin, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget1.slider.skin, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget1.slider.skin, ru.stablex.ui.skins.Paint).color = 0x33b5e5;
if(__ui__widget1.skin == null ){
     __ui__widget1.skin = new ru.stablex.ui.skins.Paint();
     if( Std.is(__ui__widget1.skin, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget1.skin, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget1.skin, ru.stablex.ui.skins.Paint).color = 0x969696;
cast(__ui__widget1.skin, ru.stablex.ui.skins.Paint).padding = 2;
cast(__ui__widget1.slider.skin, ru.stablex.ui.skins.Paint).corners = [3];
});
if( !ru.stablex.ui.UIBuilder.defaults.exists("HBox") ) ru.stablex.ui.UIBuilder.defaults.set("HBox", new Hash());
ru.stablex.ui.UIBuilder.defaults.get("HBox").set("TopMenu", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.HBox = cast(__ui__widget0, ru.stablex.ui.widgets.HBox);
__ui__widget1.padding = 5;
__ui__widget1.skinName = 'BlackBlueStripe';
__ui__widget1.align = 'left,middle';
__ui__widget1.widthPt = 100;
});
ru.stablex.ui.UIBuilder.defaults.get("HBox").set("BottomMenu", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.HBox = cast(__ui__widget0, ru.stablex.ui.widgets.HBox);
__ui__widget1.padding = 5;
__ui__widget1.unifyChildren = true;
__ui__widget1.align = 'top,center';
__ui__widget1.widthPt = 100;
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
});
if( !ru.stablex.ui.UIBuilder.defaults.exists("VBox") ) ru.stablex.ui.UIBuilder.defaults.set("VBox", new Hash());
ru.stablex.ui.UIBuilder.defaults.get("VBox").set("Menu", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.VBox = cast(__ui__widget0, ru.stablex.ui.widgets.VBox);
__ui__widget1.paddingBottom = 4;
__ui__widget1.childPadding = 2;
__ui__widget1.widthPt = 100;
__ui__widget1.paddingTop = 4;
});
if( !ru.stablex.ui.UIBuilder.defaults.exists("Button") ) ru.stablex.ui.UIBuilder.defaults.set("Button", new Hash());
ru.stablex.ui.UIBuilder.defaults.get("Button").set("Default", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Button = cast(__ui__widget0, ru.stablex.ui.widgets.Button);
__ui__widget1.skinHoveredName = 'buttonHovered';
__ui__widget1.format.color = 0xFFFFFF;
__ui__widget1.skinPressedName = 'buttonPressed';
__ui__widget1.format.font = ru.stablex.Assets.getFont('ui/android/fonts/regular.ttf').fontName;
__ui__widget1.format.size = 14;
__ui__widget1.h = 40;
__ui__widget1.w = 185;
__ui__widget1.skinName = 'button';
});
ru.stablex.ui.UIBuilder.defaults.get("Button").set("Settings", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Button = cast(__ui__widget0, ru.stablex.ui.widgets.Button);
__ui__widget1.childPadding = 0;
__ui__widget1.autoWidth = true;
__ui__widget1.ico.src = 'ui/android/img/ico/dark/settings.png';
});
ru.stablex.ui.UIBuilder.defaults.get("Button").set("MainBack", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Button = cast(__ui__widget0, ru.stablex.ui.widgets.Button);
__ui__widget1.ico.src = 'ui/android/img/ico/light/mainBack.png';
});
ru.stablex.ui.UIBuilder.defaults.get("Button").set("MainHome", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Button = cast(__ui__widget0, ru.stablex.ui.widgets.Button);
__ui__widget1.ico.src = 'ui/android/img/ico/light/mainHome.png';
});
ru.stablex.ui.UIBuilder.defaults.get("Button").set("MainRecent", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Button = cast(__ui__widget0, ru.stablex.ui.widgets.Button);
__ui__widget1.ico.src = 'ui/android/img/ico/light/mainRecent.png';
});
ru.stablex.ui.UIBuilder.defaults.get("Button").set("MenuItem", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Button = cast(__ui__widget0, ru.stablex.ui.widgets.Button);
__ui__widget1.padding = 5;
__ui__widget1.format.color = 0xFFFFFF;
__ui__widget1.format.font = ru.stablex.Assets.getFont('ui/android/fonts/regular.ttf').fontName;
__ui__widget1.format.size = 16;
__ui__widget1.h = 44;
__ui__widget1.align = 'middle';
__ui__widget1.apart = true;
__ui__widget1.ico.src = 'ui/android/img/ico/light/next.png';
__ui__widget1.icoBeforeLabel = false;
__ui__widget1.widthPt = 100;
if(__ui__widget1.skin == null ){
     __ui__widget1.skin = new ru.stablex.ui.skins.Paint();
     if( Std.is(__ui__widget1.skin, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget1.skin, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget1.skin, ru.stablex.ui.skins.Paint).color = 0x111111;
if(__ui__widget1.skinPressed == null ){
     __ui__widget1.skinPressed = new ru.stablex.ui.skins.Paint();
     if( Std.is(__ui__widget1.skinPressed, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget1.skinPressed, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget1.skinPressed, ru.stablex.ui.skins.Paint).color = 0x257390;
});
if( !ru.stablex.ui.UIBuilder.defaults.exists("Toggle") ) ru.stablex.ui.UIBuilder.defaults.set("Toggle", new Hash());
ru.stablex.ui.UIBuilder.defaults.get("Toggle").set("Default", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Toggle = cast(__ui__widget0, ru.stablex.ui.widgets.Toggle);
__ui__widget1.skinHoveredName = 'buttonHovered';
__ui__widget1.states.down.skinName = 'buttonPressed';
__ui__widget1.format.color = 0xFFFFFF;
__ui__widget1.skinPressedName = 'buttonPressed';
__ui__widget1.format.font = ru.stablex.Assets.getFont('ui/android/fonts/regular.ttf').fontName;
__ui__widget1.format.size = 14;
__ui__widget1.states.up.skinName = 'button';
__ui__widget1.h = 40;
__ui__widget1.w = 185;
__ui__widget1.skinName = 'button';
});
if( !ru.stablex.ui.UIBuilder.defaults.exists("StateButton") ) ru.stablex.ui.UIBuilder.defaults.set("StateButton", new Hash());
ru.stablex.ui.UIBuilder.defaults.get("StateButton").set("Default", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.StateButton = cast(__ui__widget0, ru.stablex.ui.widgets.StateButton);
__ui__widget1.skinHoveredName = 'buttonHovered';
__ui__widget1.format.color = 0xFFFFFF;
__ui__widget1.skinPressedName = 'buttonPressed';
__ui__widget1.format.font = ru.stablex.Assets.getFont('ui/android/fonts/regular.ttf').fontName;
__ui__widget1.format.size = 14;
__ui__widget1.h = 40;
__ui__widget1.w = 185;
__ui__widget1.skinName = 'button';
});
if( !ru.stablex.ui.UIBuilder.defaults.exists("Widget") ) ru.stablex.ui.UIBuilder.defaults.set("Widget", new Hash());
ru.stablex.ui.UIBuilder.defaults.get("Widget").set("HR", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Widget = cast(__ui__widget0, ru.stablex.ui.widgets.Widget);
__ui__widget1.h = 1;
__ui__widget1.skinName = 'hr';
__ui__widget1.widthPt = 100;
});
ru.stablex.ui.UIBuilder.defaults.get("Widget").set("HRLight", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Widget = cast(__ui__widget0, ru.stablex.ui.widgets.Widget);
__ui__widget1.h = 1;
__ui__widget1.skinName = 'hr';
__ui__widget1.widthPt = 100;
if(__ui__widget1.skin == null ){
     __ui__widget1.skin = new ru.stablex.ui.skins.Paint();
     if( Std.is(__ui__widget1.skin, ru.stablex.ui.widgets.Widget) ){
         var __tmp__ : ru.stablex.ui.widgets.Widget = cast(__ui__widget1.skin, ru.stablex.ui.widgets.Widget);
         ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
         __tmp__._onInitialize();
         __tmp__._onCreate();
     }
}
cast(__ui__widget1.skin, ru.stablex.ui.skins.Paint).color = 0xa9a9a9;
});
if( !ru.stablex.ui.UIBuilder.defaults.exists("Switch") ) ru.stablex.ui.UIBuilder.defaults.set("Switch", new Hash());
ru.stablex.ui.UIBuilder.defaults.get("Switch").set("Default", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {
var __ui__widget1 : ru.stablex.ui.widgets.Switch = cast(__ui__widget0, ru.stablex.ui.widgets.Switch);
__ui__widget1.labelOff.align = 'center,middle';
__ui__widget1.addEventListener(ru.stablex.ui.events.WidgetEvent.CREATE, function(event:nme.events.Event){
                if( __ui__widget1.selected ){
                    __ui__widget1.labelOn.visible = true;
                    __ui__widget1.labelOff.visible = false;
                    __ui__widget1.slider.skinName = 'switchSliderOn';
                }else{
                    __ui__widget1.labelOff.visible = true;
                    __ui__widget1.labelOn.visible = false;
                    __ui__widget1.slider.skinName = 'switchSliderOff';
                }
            });
__ui__widget1.labelOn.widthPt = 100;
__ui__widget1.labelOn.heightPt = 100;
__ui__widget1.labelOff.widthPt = 100;
__ui__widget1.labelOff.top = 0;
__ui__widget1.h = 24;
__ui__widget1.w = 97;
__ui__widget1.labelOff.heightPt = 100;
__ui__widget1.labelOn.left = 0;
__ui__widget1.slider.w = 47;
__ui__widget1.addEventListener(ru.stablex.ui.events.WidgetEvent.CHANGE, function(event:nme.events.Event){
                if( __ui__widget1.selected ){
                    __ui__widget1.labelOn.visible = true;
                    __ui__widget1.labelOff.visible = false;
                    __ui__widget1.slider.skinName = 'switchSliderOn';
                }else{
                    __ui__widget1.labelOff.visible = true;
                    __ui__widget1.labelOn.visible = false;
                    __ui__widget1.slider.skinName = 'switchSliderOff';
                }
            });
__ui__widget1.skinName = 'switch';
__ui__widget1.labelOn.top = 0;
__ui__widget1.labelOn.align = 'center,middle';
__ui__widget1.labelOff.left = 0;
});})()