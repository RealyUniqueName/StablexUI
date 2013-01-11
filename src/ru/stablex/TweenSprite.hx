package ru.stablex;

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.actuators.GenericActuator;
import com.eclecticdesignstudio.motion.easing.Quad;
import com.eclecticdesignstudio.motion.easing.Expo;
import com.eclecticdesignstudio.motion.easing.Bounce;
import com.eclecticdesignstudio.motion.easing.Linear;
import com.eclecticdesignstudio.motion.easing.Quint;
import com.eclecticdesignstudio.motion.easing.Elastic;
import com.eclecticdesignstudio.motion.easing.IEasing;
import com.eclecticdesignstudio.motion.easing.Back;
import com.eclecticdesignstudio.motion.easing.Quart;
import com.eclecticdesignstudio.motion.easing.Cubic;
import com.eclecticdesignstudio.motion.easing.Sine;

import nme.display.DisplayObject;
import nme.display.Sprite;


/**
* class TweenSprite implements easy access to <type>com.eclecticdesignstudio.motion.Actuate</type> methods and manages registered
* eventListeners
*
*/
class TweenSprite extends Sprite{

    //registered event listeners
    private var _listeners : Hash<List<Dynamic->Void>>;


    /**
    * Equal to <type>nme.display.Sprite</type>.addEventListener except this ignores `useCapture` and does not support weak references.
    *
    */
    override public function addEventListener (type:String, listener:Dynamic->Void, useCapture:Bool = false, priority:Int = 0, useWeakReference:Bool = false) : Void{
        //if listeners list is not created
        if( this._listeners == null ){
            this._listeners = new Hash();
        }

        var listeners : List<Dynamic->Void> = this._listeners.get(type);

        //if we don't have list of listeners for this event, create one
        if( listeners == null ){
            listeners = new List();
            listeners.add(listener);
            this._listeners.set(type, listeners);

        //add listener to the list
        }else{
            listeners.add(listener);
        }

        super.addEventListener(type, listener, false, priority, useWeakReference);
    }//function addEventListener()


    /**
    * Add event listener only if this listener is still not added to this object
    * Ignores `useCapture` and `useWeakReference`
    *
    * @return whether listener was added
    */
    public function addUniqueListener (type:String, listener:Dynamic->Void, useCapture:Bool = false, priority:Int = 0, useWeakReference:Bool = false) : Bool{
        if( this.hasListener(type, listener) ){
            return false;
        }

        this.addEventListener(type, listener, useCapture, priority, useWeakReference);
        return true;
    }//function addEventListener()


    /**
    * Equal to <type>nme.display.Sprite</type>.removeEventListener except this ignores `useCapture`
    *
    */
    override public function removeEventListener (type:String, listener:Dynamic->Void, useCapture:Bool = false) : Void{
        //remove listener from the list of registered listeners
        if( this._listeners != null ){
            if( this._listeners.exists(type) ) this._listeners.get(type).remove(listener);
        }

        super.removeEventListener(type, listener, false);
    }//function removeEventListener()


    /**
    * Removes all listeners registered for this event
    *
    */
    public function clearEvent (type:String) : Void {
        if( this._listeners != null ){
            var listeners : List<Dynamic->Void> = this._listeners.get(type);
            if( listeners != null ){
                while( listeners.length > 0 ){
                    this.removeEventListener(type, listeners.first());
                }
            }
        }
    }//function clearEvent()


    /**
    * Indicates whether this object has this listener registered for specified event type
    *
    */
    public function hasListener(event:String, listener:Dynamic->Void) : Bool {
        if( this._listeners == null ) return false;

        var lst : List<Dynamic->Void> = this._listeners.get(event);
        if( lst == null ) return false;

        for(l in lst){
            if( l == listener ) return true;
        }

        return false;
    }//function hasListener()


    /**
    * Easy access to <type>com.eclecticdesignstudio.motion.Actuate</type>.tween for this object. Equals to <type>com.eclecticdesignstudio.motion.Actuate</type>.tween(this, ....).
    * Parameter `easing` should be like this: 'Quad.easeInOut' or 'Back.easeIn' etc. By default it is 'Linear.easeNone'
    *
    */
    public inline function tween (duration:Float, properties:Dynamic, easing:String = 'Linear.easeNone', overwrite:Bool = true, customActuator:Class<GenericActuator> = null) : IGenericActuator{
        var actuator : IGenericActuator;

        switch(easing){
            case 'Quad.easeInOut'    : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quad.easeInOut);
            case 'Quad.easeOut'      : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quad.easeOut);
            case 'Quad.easeIn'       : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quad.easeIn);
            case 'Expo.easeInOut'    : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Expo.easeInOut);
            case 'Expo.easeOut'      : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Expo.easeOut);
            case 'Expo.easeIn'       : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Expo.easeIn);
            case 'Bounce.easeInOut'  : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Bounce.easeInOut);
            case 'Bounce.easeOut'    : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Bounce.easeOut);
            case 'Bounce.easeIn'     : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Bounce.easeIn);
            case 'Quint.easeInOut'   : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quint.easeInOut);
            case 'Quint.easeOut'     : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quint.easeOut);
            case 'Quint.easeIn'      : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quint.easeIn);
            case 'Elastic.easeInOut' : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Elastic.easeInOut);
            case 'Elastic.easeOut'   : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Elastic.easeOut);
            case 'Elastic.easeIn'    : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Elastic.easeIn);
            case 'Back.easeInOut'    : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Back.easeInOut);
            case 'Back.easeOut'      : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Back.easeOut);
            case 'Back.easeIn'       : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Back.easeIn);
            case 'Quart.easeInOut'   : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quart.easeInOut);
            case 'Quart.easeOut'     : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quart.easeOut);
            case 'Quart.easeIn'      : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Quart.easeIn);
            case 'Cubic.easeInOut'   : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Cubic.easeInOut);
            case 'Cubic.easeOut'     : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Cubic.easeOut);
            case 'Cubic.easeIn'      : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Cubic.easeIn);
            case 'Sine.easeInOut'    : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Sine.easeInOut);
            case 'Sine.easeOut'      : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Sine.easeOut);
            case 'Sine.easeIn'       : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Sine.easeIn);

            case 'Linear.easeNone': actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Linear.easeNone);
            default               : actuator = Actuate.tween(this, duration, properties, overwrite, customActuator).ease(Linear.easeNone);
        }

        return actuator;
    }//function tween()


    /**
    * Calls <type>com.eclecticdesignstudio.motion.Actuate</type>.stop() for this object. By default `complete` and `sendEvent` equal to false
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

        //clear listeners
        if( this._listeners != null ){
            for(event in this._listeners.keys()){
                var listeners : List<Dynamic->Void> = this._listeners.get(event);
                while( !listeners.isEmpty() ){
                    this.removeEventListener(event, listeners.first());
                }
            }
        }

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