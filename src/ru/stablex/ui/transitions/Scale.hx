package ru.stablex.ui.transitions;

import flash.display.DisplayObject;
import ru.stablex.ui.widgets.Widget;
import ru.stablex.ui.widgets.ViewStack;
import motion.Actuate;


/**
* This transition method manipulates `.alpha` of changing viewstack children
*
*/
class Scale extends Transition{

    //Scale "0 to 1" (true) or "1 to 0" (false) ?
    public var scaleUp : Bool = true;


    /**
    * Switch children visibility
    *
    * @param cb - callback to call after visible object was hidden
    */
    override public function change (vs:ViewStack, toHide:DisplayObject, toShow:DisplayObject, cb:Void->Void = null) : Void{
        if( this.scaleUp ){
            this._scaleUp(vs, toHide, toShow, cb);
        }else{
            this._scaleDown(vs, toHide, toShow, cb);
        }
    }//function change()


    /**
    * Set `.visible` = false for provided object
    *
    */
    private function _hide (vs:ViewStack, toHide:DisplayObject, toShow:DisplayObject, swap:Bool, cb:Void->Void = null) : Void {
        vs.mouseChildren = true;
        var w : Widget;

        if( Std.is(toHide, Widget) ){
            w = cast(toHide, Widget);
            w.top = w.left = 0;
            toHide.scaleX  = toHide.scaleY = 1;
        }

        if( Std.is(toShow, Widget) ){
            w = cast(toShow, Widget);
            w.top = w.left = 0;
            toShow.scaleX = toShow.scaleY = 1;
        }

        toHide.visible = false;
        toShow.visible = true;

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
    private inline function _scaleDown (vs:ViewStack, toHide:DisplayObject, toShow:DisplayObject, cb:Void->Void = null) : Void {
        vs.mouseChildren = false;
        //hide
        if( Std.is(toHide, Widget) ){
            var w    : Widget = cast(toHide, Widget);
            var swap : Bool = false;

            //stop previous tween
            w.tweenStop(["scaleX", "scaleY", "left", "top"], true, true);

            //swap objects if needed
            if( vs.getChildIndex(toHide) < vs.getChildIndex(toShow) ){
                swap = true;
                vs.swapChildren(toHide, toShow);
            }

            w.top = w.left = 0;
            w.scaleX = w.scaleY = 1;
            w.tween(this.duration, {
                top    : vs.h / 2,
                left   : vs.w / 2,
                scaleX : 0,
                scaleY : 0
            }).onComplete(this._hide, [vs, toHide, toShow, swap, cb]);
        }else{
            toHide.visible = false;
            if( cb != null ) cb();
        }

        //show
        toShow.visible = true;
        if( Std.is(toShow, Widget) ){
            cast(toShow, Widget).tweenStop(["scaleX", "scaleY", "left", "top"], true, true);
        }else{
            toShow.visible = true;
        }
    }//function _scaleDown()


    /**
    * Scale UP
    *
    */
    private inline function _scaleUp (vs:ViewStack, toHide:DisplayObject, toShow:DisplayObject, cb:Void->Void = null) : Void {
        vs.mouseChildren = false;
        //hide
        if( Std.is(toHide, Widget) ){
            cast(toHide, Widget).tweenStop(["scaleX", "scaleY", "left", "top"], true, true);
        }else{
            toHide.visible = false;
        }

        //show
        toShow.visible = true;
        if( Std.is(toShow, Widget) ){
            var w    : Widget = cast(toShow, Widget);
            var swap : Bool = false;

            //stop previous tween
            w.tweenStop(["scaleX", "scaleY", "left", "top"], true, true);

            //swap objects if needed
            if( vs.getChildIndex(toHide) > vs.getChildIndex(toShow) ){
                swap = true;
                vs.swapChildren(toHide, toShow);
            }

            w.top  = vs.h / 2;
            w.left = vs.w / 2;
            w.scaleX = w.scaleY = 0;
            w.tween(this.duration, {
                top    : 0,
                left   : 0,
                scaleX : 1,
                scaleY : 1
            }).onComplete(this._hide, [vs, toHide, toShow, swap, cb]);
        }else{
            toShow.visible = true;
            if( cb != null ) cb();
        }
    }//function _scaleUp()
}//class Scale