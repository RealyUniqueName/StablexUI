package ru.stablex.ui.transitions;

import flash.display.DisplayObject;
import ru.stablex.ui.widgets.Widget;
import motion.Actuate;


/**
* This transition method manipulates `.alpha` of changing a widgets children
*
*/
class Scale extends Transition{

    //Scale "0 to 1" (true) or "1 to 0" (false) ?
    public var scaleUp : Bool = true;
    //The origin from which the element should scaled from/too. -1.0 means not set
    public var scaleOriginX : Float = -1.0;
    public var scaleOriginY : Float = -1.0;


    /**
    * Switch children visibility
    *
    * @param cb - callback to call after visible object was hidden
    */
    override public function change (vs:Widget, toHide:DisplayObject, toShow:DisplayObject, cb:Void->Void = null, reverse : Bool = false) : Void{
        var usedScaleUp = scaleUp;
        if (reverse) {
          usedScaleUp = !scaleUp;
        }

        if( usedScaleUp ){
          this._scaleUp(vs, toHide, toShow, cb);
        }else{
            this._scaleDown(vs, toHide, toShow, cb);
        }
    }//function change()


    /**
    * Set `.visible` = false for provided object
    *
    */
    private function _hide (vs:Widget, toHide:DisplayObject, toShow:DisplayObject, swap:Bool, toHideReset : {left : Float, top : Float, scaleX : Float, scaleY : Float}, cb:Void->Void = null) : Void {
        vs.mouseChildren = true;
        var w : Widget;

        if (toHide != null) {
          toHide.visible = false;
        }
        if (toShow != null) {
          toShow.visible = true;
        }

        if( Std.is(toHide, Widget) ){
            w = cast(toHide, Widget);
            if (toHideReset != null) {
              w.top = toHideReset.top;
              w.left = toHideReset.left;
              toHide.scaleX = toHideReset.scaleX;
              toHide.scaleY = toHideReset.scaleY;
            }
        }

        /* To show is at its final position, no need to change anything
        if( Std.is(toShow, Widget) ){
            w = cast(toShow, Widget);
            w.top = w.left = 0;
            toShow.scaleX = toShow.scaleY = 1;
        }*/

        //if objects were swapped, swap them back
        if( swap ){
            vs.swapChildren(toHide, toShow);
        }

        if( cb != null ) cb();
    }//function _hide()


    /**
    * Scale DOWN
    *
    */
    private inline function _scaleDown (vs:Widget, toHide:DisplayObject, toShow:DisplayObject, cb:Void->Void = null) : Void {
        vs.mouseChildren = false;
        //hide
        if( Std.is(toHide, Widget) ){
            var w    : Widget = cast(toHide, Widget);
            var swap : Bool = false;

            //stop previous tween
            w.tweenStop(["scaleX", "scaleY", "left", "top"], true, true);

            //swap objects if needed
            if( toHide != null && toShow != null && vs.getChildIndex(toHide) < vs.getChildIndex(toShow) ){
                swap = true;
                vs.swapChildren(toHide, toShow);
            }

            var top = (scaleOriginY<0.0)?(w.top + w.height)/2.0:scaleOriginY;
            var left = (scaleOriginX<0.0)?(w.left + w.width)/2.0:scaleOriginX;
            w.tween(this.duration, {
                top    : top,
                left   : left,
                scaleX : 0,
                scaleY : 0
            }, this.easing).onComplete(this._hide, [vs, toHide, toShow, swap, {left : w.left, top : w.top, scaleX : w.scaleX, scaleY : w.scaleY}, cb]);
        }else{
            if (toHide != null) {
              toHide.visible = false;
            }
            if( cb != null ) cb();
        }

        //show
        if (toShow != null) {
          toShow.visible = true;
          if( Std.is(toShow, Widget) ){
            cast(toShow, Widget).tweenStop(["scaleX", "scaleY", "left", "top"], true, true);
          }
        }
    }//function _scaleDown()


    /**
    * Scale UP
    *
    */
    private inline function _scaleUp (vs:Widget, toHide:DisplayObject, toShow:DisplayObject, cb:Void->Void = null) : Void {
        vs.mouseChildren = false;
        //hide
        if( Std.is(toHide, Widget) ){
            cast(toHide, Widget).tweenStop(["scaleX", "scaleY", "left", "top"], true, true);
        }else{
            if (toHide != null) {
              toHide.visible = false;
            }
        }

        //show
        if (toShow != null) {
          toShow.visible = true;
        }
        if( Std.is(toShow, Widget) ){
            var w    : Widget = cast(toShow, Widget);
            var swap : Bool = false;

            //stop previous tween
            w.tweenStop(["scaleX", "scaleY", "left", "top"], true, true);

            //swap objects if needed
            if( toHide != null && toShow != null && vs.getChildIndex(toHide) > vs.getChildIndex(toShow) ){
                swap = true;
                vs.swapChildren(toHide, toShow);
            }

            var topGoal = w.top;
            var leftGoal = w.left;
            var scaleXGoal = w.scaleX;
            var scaleYGoal = w.scaleY;
            w.top  = (scaleOriginY<0.0)?(w.top  + w.height / 2):scaleOriginY;
            w.left = (scaleOriginX<0.0)?(w.left + w.width / 2):scaleOriginX;
            w.scaleX = w.scaleY = 0.0;
            w.tween(this.duration, {
                top    : topGoal,
                left   : leftGoal,
                scaleX : scaleXGoal,
                scaleY : scaleYGoal
            }, this.easing).onComplete(this._hide, [vs, toHide, toShow, swap, null, cb]);
        }else{
            if( cb != null ) cb();
        }
    }//function _scaleUp()
}//class Scale