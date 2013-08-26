package ru.stablex;

import motion.Actuate;
import motion.actuators.GenericActuator;
import motion.easing.Quad;
import motion.easing.Expo;
import motion.easing.Bounce;
import motion.easing.Linear;
import motion.easing.Quint;
import motion.easing.Elastic;
import motion.easing.IEasing;
import motion.easing.Back;
import motion.easing.Quart;
import motion.easing.Cubic;
import motion.easing.Sine;

import ru.stablex.backend.display.DisplayObject;
import ru.stablex.backend.display.Sprite;

/**
* class TweenSprite implements easy access to <type>motion.Actuate</type> methods
*
*/
class TweenSprite extends Sprite{


    /**
    * Easy access to <type>motion.Actuate</type>.tween for this object. Equals to <type>motion.Actuate</type>.tween(this, ....).
    * Parameter `easing` should be like this: 'Quad.easeInOut' or 'Back.easeIn' etc. By default it is 'Linear.easeNone'
    *
    */
    public function tween (duration:Float, properties:Dynamic, easing:String = 'Linear.easeNone', overwrite:Bool = true, customActuator:Class<GenericActuator> = null) {
        switch(easing){
            case 'Quad.easeInOut'    : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quad.easeInOut);
            case 'Quad.easeOut'      : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quad.easeOut);
            case 'Quad.easeIn'       : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quad.easeIn);
            case 'Expo.easeInOut'    : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Expo.easeInOut);
            case 'Expo.easeOut'      : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Expo.easeOut);
            case 'Expo.easeIn'       : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Expo.easeIn);
            case 'Bounce.easeInOut'  : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Bounce.easeInOut);
            case 'Bounce.easeOut'    : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Bounce.easeOut);
            case 'Bounce.easeIn'     : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Bounce.easeIn);
            case 'Quint.easeInOut'   : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quint.easeInOut);
            case 'Quint.easeOut'     : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quint.easeOut);
            case 'Quint.easeIn'      : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quint.easeIn);
            case 'Elastic.easeInOut' : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Elastic.easeInOut);
            case 'Elastic.easeOut'   : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Elastic.easeOut);
            case 'Elastic.easeIn'    : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Elastic.easeIn);
            case 'Back.easeInOut'    : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Back.easeInOut);
            case 'Back.easeOut'      : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Back.easeOut);
            case 'Back.easeIn'       : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Back.easeIn);
            case 'Quart.easeInOut'   : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quart.easeInOut);
            case 'Quart.easeOut'     : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quart.easeOut);
            case 'Quart.easeIn'      : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quart.easeIn);
            case 'Cubic.easeInOut'   : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Cubic.easeInOut);
            case 'Cubic.easeOut'     : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Cubic.easeOut);
            case 'Cubic.easeIn'      : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Cubic.easeIn);
            case 'Sine.easeInOut'    : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Sine.easeInOut);
            case 'Sine.easeOut'      : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Sine.easeOut);
            case 'Sine.easeIn'       : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Sine.easeIn);

            case 'Linear.easeNone': return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Linear.easeNone);
            default               : return Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Linear.easeNone);
        }
    }//function tween()


    /**
    * Calls <type>motion.Actuate</type>.stop() for this object. By default `complete` and `sendEvent` equal to false
    *
    */
    public function tweenStop(properties:Dynamic = null, complete:Bool = false, sendEvent:Bool = false) : Void {
        Actuate.stop(this, properties, complete, sendEvent);
    }//function tweenStop()


    /**
    * Free object. Removes all registered eventListeners and children. Also removes itself from parent's display list.
    * If `recursive` is true (by default), tries to call .free(true) for each child (TweenSprite instances only)
    */
    public function free (recursive:Bool = true) : Void{
        this.tweenStop();

        //remove attached event listeners
        this.clearAllEvents();

        //release children
        this.freeChildren(recursive);

        //removing from parent's display list
        if( this.parent != null ){
            this.parent.removeChild(this);
        }
    }//function free()


    /**
    * Removes children. If `recursive` = true (default) tries to call .free(true) for TweenSprite instances
    */
    public function freeChildren(recursive:Bool = true) : Void {
        var child : DisplayObject;
        while( this.numChildren > 0 ){
            child = this.removeChildAt(0);

            if( recursive && Std.is(child, TweenSprite) ){
                cast(child, TweenSprite).free(true);
            }
        }
    }//function freeChildren()


}//class TweenSprite