package ru.stablex.ui.transitions;

import flash.display.DisplayObject;
import ru.stablex.ui.widgets.Widget;


/**
* This transition method switches children like screens on phones.
*
*/
class Slide extends Transition{
    /**
    * Direction for sliding.
    *   'left' for from right to left
    *   'right' for from left to right
    *   'top'   for from bottom to top
    *   'bottom' for from top to bottom
    */
    public var direction : String = 'left';

    /** Remember object to hide original position, so that it can be reseted after the animation
      */
    private var _reset_x : Float;
    private var _reset_y : Float;

    /**
    * Switch children visibility
    *
    * @param cb - callback to call after visible object was hidden
    */
    override public function change (vs:Widget, toHide:DisplayObject, toShow:DisplayObject, cb:Void->Void = null, reverse : Bool = false) : Void{
        if(toHide != null){
          _reset_x = toHide.x;
          _reset_y = toHide.y;
        }
        // Correct for reverse
        var usedDir = this.direction;
        if (reverse) {
          usedDir = switch(usedDir) {
          case 'right': 'left';
          case 'top': 'bottom';
          case 'bottom': 'top';
          case _: 'right';
          }
        }
        switch(usedDir){
            case 'right':   this._slideRight(vs, toHide, toShow, cb);
            case 'top':     this._slideTop(vs, toHide, toShow, cb);
            case 'bottom':  this._slideBottom(vs, toHide, toShow, cb);
            default:        this._slideLeft(vs, toHide, toShow, cb);
        }
    }//function change()


    /**
    * Set `.visible` = false for provided object, reset object position and call callback.
    *
    */
    private function _hide (obj:DisplayObject, cb:Void->Void = null) : Void {
        if (obj != null) {
          obj.visible = false;
          cast(obj, Widget).left = _reset_x;
          cast(obj, Widget).top  = _reset_y;
        }
        _callCallback(cb);
    }//function _hide()

    /**
      * Call the callback function if it is not null.
      */
    private function _callCallback(cb:Void->Void = null) {
      if (cb != null) cb();
    }//function _callCallback

    /**
    * Slide left
    *
    */
    private inline function _slideLeft (vs:Widget, toHide:DisplayObject, toShow:DisplayObject, cb:Void->Void = null) : Void {
        var w : Widget;

        //hide
        if( Std.is(toHide, Widget) ){
            w = cast(toHide, Widget);
            w.tweenStop("right", true, true);
            w.tween(this.duration, {right:vs.w}, this.easing).onComplete(this._hide,[toHide,cb]);
            // Set cb to null, so that it is not called bellow
            cb = null;
        } else {
          if (toHide != null) {
            toHide.visible = false;
          }
        }

        //show
        if( Std.is(toShow, Widget) ){
            w = cast(toShow, Widget);
            w.tweenStop("left", true, true);
            w.visible = true;
            var leftGoal = w.left;
            w.left    = vs.w;
            w.tween(this.duration, {left:leftGoal}, this.easing).onComplete(_callCallback, [cb]);
            // Set cb to null, so that it is not called bellow
            cb = null;
        }else{
            if (toShow != null) {
              toShow.visible = true;
            }
        }
        if( cb != null ) cb();
    }//function _slideLeft()


    /**
    * Slide right
    *
    */
    private inline function _slideRight (vs:Widget, toHide:DisplayObject, toShow:DisplayObject, cb:Void->Void = null) : Void {
        var w : Widget;

        //hide
        if( Std.is(toHide, Widget) ){
            w = cast(toHide, Widget);
            w.tweenStop("left", true, true);
            w.tween(this.duration, {left:vs.w}, this.easing).onComplete(this._hide,[toHide,cb]);
            // Set cb to null, so that it is not called bellow
            cb = null;
        } else {
          if (toHide != null) {
            toHide.visible = false;
          }
        }

        //show
        if( Std.is(toShow, Widget) ){
            w = cast(toShow, Widget);
            w.tweenStop("left", true, true);
            w.visible = true;
            var leftGoal = w.left;
            w.right    = vs.w;
            w.tween(this.duration, {left:leftGoal}, this.easing).onComplete(_callCallback, [cb]);
            // Set cb to null, so that it is not called bellow
            cb = null;
        }else{
            if (toShow != null) {
              toShow.visible = true;
            }
        }
        if( cb != null ) cb();
    }//function _slideRight()


    /**
    * Slide top
    *
    */
    private inline function _slideTop (vs:Widget, toHide:DisplayObject, toShow:DisplayObject, cb:Void->Void = null) : Void {
        var w : Widget;

        //hide
        if( Std.is(toHide, Widget) ){
            w = cast(toHide, Widget);
            w.tweenStop("bottom", true, true);
            w.tween(this.duration, {bottom:vs.h}, this.easing).onComplete(this._hide,[toHide,cb]);
            // Set cb to null, so that it is not called bellow
            cb = null;
        } else {
          if (toHide != null) {
            toHide.visible = false;
          }
        }

        //show
        if( Std.is(toShow, Widget) ){
            w = cast(toShow, Widget);
            w.tweenStop("top", true, true);
            w.visible = true;
            var topGoal = w.top;
            w.top    = vs.h;
            w.tween(this.duration, {top:topGoal}, this.easing).onComplete(_callCallback, [cb]);
            // Set cb to null, so that it is not called bellow
            cb = null;
        }else{
            if (toShow != null) {
              toShow.visible = true;
            }
        }
        if( cb != null ) cb();
    }//function _slideTop()


    /**
    * Slide bottom
    *
    */
    private inline function _slideBottom (vs:Widget, toHide:DisplayObject, toShow:DisplayObject, cb:Void->Void = null) : Void {
        var w : Widget;

        //hide
        if( Std.is(toHide, Widget) ){
            w = cast(toHide, Widget);
            w.tweenStop("top", true, true);
            w.tween(this.duration, {top:vs.h}, this.easing).onComplete(this._hide,[toHide,cb]);
            // Set cb to null, so that it is not called bellow
            cb = null;
        } else {
          if (toHide != null) {
            toHide.visible = false;
          }
        }

        //show
        if( Std.is(toShow, Widget) ){
            w = cast(toShow, Widget);
            w.tweenStop("top", true, true);
            w.visible = true;
            var topGoal = w.top;
            w.bottom    = vs.h;
            w.tween(this.duration, {top:topGoal}, this.easing).onComplete(_callCallback, [cb]);
            // Set cb to null, so that it is not called bellow
            cb = null;
        }else{
            if (toShow != null) {
              toShow.visible = true;
            }
        }
        if( cb != null ) cb();
    }//function _slideBottom()
}//class Slide