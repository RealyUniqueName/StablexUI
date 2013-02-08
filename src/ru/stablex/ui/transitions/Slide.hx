package ru.stablex.ui.transitions;

import nme.display.DisplayObject;
import ru.stablex.ui.widgets.ViewStack;
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


    /**
    * Switch children visibility
    *
    */
    override public function change (vs:ViewStack, toHide:DisplayObject, toShow:DisplayObject) : Void {
        switch(this.direction){
            case 'right':   this._slideRight(vs, toHide, toShow);
            case 'top':     this._slideTop(vs, toHide, toShow);
            case 'bottom':  this._slideBottom(vs, toHide, toShow);
            default:        this._slideLeft(vs, toHide, toShow);
        }
    }//function change()


    /**
    * Set `.visible` = false for provided object
    *
    */
    private function _hide (obj:DisplayObject) : Void {
        obj.visible = false;
    }//function _hide()


    /**
    * Slide left
    *
    */
    private inline function _slideLeft (vs:ViewStack, toHide:DisplayObject, toShow:DisplayObject) : Void {
        var w : Widget;

        //hide
        if( Std.is(toHide, Widget) ){
            w = cast(toHide, Widget);
            w.tweenStop("right", true, true);
            w.top = w.right = 0;
            w.tween(this.duration, {right:vs.w});
        }

        //show
        if( Std.is(toShow, Widget) ){
            w = cast(toShow, Widget);
            w.tweenStop("left", true, true);
            w.visible = true;
            w.left    = vs.w;
            w.top     = 0;
            w.tween(this.duration, {left:0}).onComplete(this._hide, [toHide]);
        }else{
            toHide.visible = false;
            toShow.visible = true;
        }
    }//function _slideLeft()


    /**
    * Slide right
    *
    */
    private inline function _slideRight (vs:ViewStack, toHide:DisplayObject, toShow:DisplayObject) : Void {
        var w : Widget;

        //hide
        if( Std.is(toHide, Widget) ){
            w = cast(toHide, Widget);
            w.tweenStop("left");
            w.top = w.left = 0;
            w.tween(this.duration, {left:vs.w});
        }

        //show
        if( Std.is(toShow, Widget) ){
            w = cast(toShow, Widget);
            w.tweenStop("left", true, true);
            w.visible = true;
            w.right   = vs.w;
            w.top     = 0;
            w.tween(this.duration, {left:0}).onComplete(this._hide, [toHide]);
        }else{
            toHide.visible = false;
            toShow.visible = true;
        }
    }//function _slideRight()


    /**
    * Slide top
    *
    */
    private inline function _slideTop (vs:ViewStack, toHide:DisplayObject, toShow:DisplayObject) : Void {
        var w : Widget;

        //hide
        if( Std.is(toHide, Widget) ){
            w = cast(toHide, Widget);
            w.tweenStop("top", true, true);
            w.left = w.top = 0;
            w.tween(this.duration, {bottom:vs.h});
        }

        //show
        if( Std.is(toShow, Widget) ){
            w = cast(toShow, Widget);
            w.tweenStop("top", true, true);
            w.visible = true;
            w.top     = vs.h;
            w.left    = 0;
            w.tween(this.duration, {top:0}).onComplete(this._hide, [toHide]);
        }else{
            toHide.visible = false;
            toShow.visible = true;
        }
    }//function _slideTop()


    /**
    * Slide bottom
    *
    */
    private inline function _slideBottom (vs:ViewStack, toHide:DisplayObject, toShow:DisplayObject) : Void {
        var w : Widget;

        //hide
        if( Std.is(toHide, Widget) ){
            w = cast(toHide, Widget);
            w.tweenStop("top", true, true);
            w.left = w.top = 0;
            w.tween(this.duration, {top:vs.h});
        }

        //show
        if( Std.is(toShow, Widget) ){
            w = cast(toShow, Widget);
            w.tweenStop("top", true, true);
            w.visible = true;
            w.bottom  = vs.h;
            w.left    = 0;
            w.tween(this.duration, {top:0}).onComplete(this._hide, [toHide]);
        }else{
            toHide.visible = false;
            toShow.visible = true;
        }
    }//function _slideBottom()
}//class Slide