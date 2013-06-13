package ru.stablex.ui.transitions;

import flash.display.DisplayObject;
import ru.stablex.ui.widgets.Widget;
import ru.stablex.ui.widgets.ViewStack;


/**
* This transition method manipulates `.alpha` of changing viewstack children
*
*/
class Fade extends Transition{

    /**
    * Switch children visibility
    *
    * @param cb - callback to call after visible object was hidden
    */
    override public function change (vs:ViewStack, toHide:DisplayObject, toShow:DisplayObject, cb:Void->Void = null) : Void{
        var w : Widget;

        //hide
        if( Std.is(toHide, Widget) ){
            w = cast(toHide, Widget);
            w.tweenStop("alpha", true, true);
            w.alpha = 1;
            w.top   = w.left = 0;
            w.tween(this.duration, {alpha:0}).onComplete(this._hide, [toHide, cb]);
        }

        //show
        if( Std.is(toShow, Widget) ){
            w = cast(toShow, Widget);
            w.tweenStop("alpha", true, true);
            w.visible = true;
            w.alpha   = 0;
            w.top     = w.left = 0;
            w.tween(this.duration, {alpha:1}).onComplete(this._hide, [toHide, cb]);
        }else{
            toHide.visible = false;
            toShow.visible = true;
            if( !Std.is(toHide, Widget) && cb != null ) cb();
        }
    }//function change()


    /**
    * Set `.visible` = false for provided object
    *
    */
    private function _hide (obj:DisplayObject, cb:Void->Void = null) : Void {
        obj.alpha   = 1;
        obj.visible = false;
        if( cb != null ) cb();
    }//function _hide()
}//class Fade