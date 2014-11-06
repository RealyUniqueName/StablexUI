package ru.stablex.ui.transitions;

import flash.display.DisplayObject;
import ru.stablex.ui.widgets.Widget;


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
    override public function change (vs:Widget, toHide:DisplayObject, toShow:DisplayObject, cb:Void->Void = null, reverse : Bool = false) : Void{
        var w : Widget;

        //hide
        if( Std.is(toHide, Widget) ){
            w = cast(toHide, Widget);
            w.tweenStop("alpha", true, true);
            w.alpha = 1;
            w.top   = w.left = 0;
            w.tween(this.duration, {alpha:0}, this.easing).onComplete(this._hide, [toHide, cb]);
            // Ensure callback is not called below
            cb = null;
        }

        //show
        if( Std.is(toShow, Widget) ){
            w = cast(toShow, Widget);
            w.tweenStop("alpha", true, true);
            w.visible = true;
            w.alpha   = 0;
            w.top     = w.left = 0;
            w.tween(this.duration, {alpha:1}, this.easing).onComplete(this._hide, [toHide, cb]);
        }else{
            if (toHide != null) {
              toHide.visible = false;
            }
            if (toShow != null) {
              toShow.visible = true;
            }
            if( !Std.is(toHide, Widget) && cb != null ) cb();
        }
    }//function change()


    /**
    * Set `.visible` = false for provided object
    *
    */
    private function _hide (obj:DisplayObject, cb:Void->Void = null) : Void {
        if (obj != null) {
          obj.alpha   = 1;
          obj.visible = false;
        }
        if( cb != null ) cb();
    }//function _hide()
}//class Fade