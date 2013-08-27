package starlingbackend.display;

import flash.display.Bitmap;
import starling.display.Image;
import starling.textures.Texture;

/**
* Sprite implementation
*
*/
class Sprite extends starling.display.Sprite{

    /** display object for drawings */
    @:noCompletion public var _graphics : Image;
    /** index of grpahics object */
    public var _graphicsIdx : Int = 0;


    /**
    * Clear all drawings on this sprite
    *
    */
    public function clearGraphics () : Void {
        if( this._graphics != null ){
            this.removeChild(this._graphics);
        }
    }//function clearGraphics()


    /**
    * Set sprite graphics
    *
    */
    public function setGraphics (bmp:Texture) : Void {
        if( this._graphics == null ){
            this._graphics = new Image(bmp);
        }else{
            this._graphics.texture = bmp;
        }

        if( this._graphics.parent != this ){
            this.addChild(this._graphics);
        }
    }//function setGraphics()


/*******************************************************************************
*   LISTENERS MANAGEMENT
*******************************************************************************/

    /** for compatibility */
    public var scrollRect : ru.stablex.backend.geom.Rectangle;
    public var mouseEnabled : Bool = true;
    public var mouseChildren : Bool = true;

    /** x coordinate of mouse pointer in this sprite */
    public var mouseX (get,never) : Float;
    /** y coordinate of mouse pointer in this sprite */
    public var mouseY (get,never) : Float;

    //registered event listeners
    private var _listeners : Map<String,List<Dynamic->Void>>;


    /**
    * Equal to <type>flash.display.Sprite</type>.addEventListener except this ignores `useCapture` and does not support weak references.
    *
    */
    override public function addEventListener (type:String, listener:Dynamic->Void) : Void{
        //if listeners list is not created
        if( this._listeners == null ){
            this._listeners = new Map();
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

        super.addEventListener(type, listener);
    }//function addEventListener()


    /**
    * Add event listener only if this listener is still not added to this object
    * Ignores `useCapture` and `useWeakReference`
    *
    * @return whether listener was added
    */
    public function addUniqueListener (type:String, listener:Dynamic->Void) : Bool{
        if( this.hasListener(type, listener) ){
            return false;
        }

        this.addEventListener(type, listener);
        return true;
    }//function addEventListener()


    /**
    * Equal to <type>flash.display.Sprite</type>.removeEventListener except this ignores `useCapture`
    *
    */
    override public function removeEventListener (type:String, listener:Dynamic->Void) : Void{
        //remove listener from the list of registered listeners
        if( this._listeners != null ){
            if( this._listeners.exists(type) ) this._listeners.get(type).remove(listener);
        }

        super.removeEventListener(type, listener);
    }//function removeEventListener()


    /**
    * Removes all listeners registered for this event
    *
    */
    public function clearEvent (type:String) : Void {
        if( this._listeners != null ){
            var listeners : List<Dynamic->Void> = this._listeners.get(type);
            if( listeners != null ){
                listeners.clear();
                this.removeEventListeners(type);
            }
        }
    }//function clearEvent()


    /**
    * Remove all attached event listeners
    *
    */
    public function clearAllEvents () : Void {
        this.removeEventListeners();
    }//function clearAllEvents()


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


/*******************************************************************************
*   CHILDREN MANAGEMENT
*******************************************************************************/

    /** dispose children after removal */
    public var disposeRemovedChild : Bool = false;


    /**
    * Add child to display list of this container
    *
    */
    public function sxAddChild (child:DisplayObject) : DisplayObject {
        if( this._graphics == child ){
            this._graphicsIdx = this.getChildIndex(this._graphics);
        }

        return super.addChild(child);
    }//function sxAddChild()


    /**
    * Remove child from display list
    *
    */
    public function sxRemoveChild (child:DisplayObject) : DisplayObject {
        if( child == this._graphics ){
            this._graphicsIdx == -1;
        }else if( this.getChildIndex(child) < this._graphicsIdx ){
            this._graphicsIdx --;
        }

        return super.removeChild(child, this.disposeRemovedChild);
    }//function sxRemoveChild()


    /**
    * Add child at specified index in display list
    *
    */
    public function sxAddChildAt (child:DisplayObject, index:Int) : DisplayObject {
        if( this._graphics != null && this._graphicsIdx >= index ){
            this._graphicsIdx ++;
        }

        return super.addChildAt(child, index);
    }//function sxAddChildAt()


    /**
    * Remove child from specified index in display list
    *
    */
    public function sxRemoveChildAt (index:Int) : DisplayObject {
        if( this._graphics != null ){
            if( index == this._graphicsIdx ){
                index ++;
            }else if( index < this._graphicsIdx ){
                this._graphicsIdx --;
            }
        }

        return super.removeChildAt(index, this.disposeRemovedChild);
    }//function sxRemoveChildAt()


    /**
    * Swap children in display list.
    * Required by transitions of ViewStack only.
    *
    */
    public function sxSwapChildren (child1:DisplayObject, child2:DisplayObject) : Void {
        super.swapChildren(child1, child2);
    }//function sxSwapChildren()


    /**
    * Add child to display list of this container
    *
    */
    override public function addChild (child:DisplayObject) : DisplayObject {
        return this.sxAddChild(child);
    }//function addChild()


    /**
    * Remove child from display list
    *
    */
    override public function removeChild (child:DisplayObject, dispose:Bool = false) : DisplayObject {
        this.disposeRemovedChild = dispose;
        return this.sxRemoveChild(child);
    }//function removeChild()


    /**
    * Add child at specified index in display list
    *
    */
    override public function addChildAt (child:DisplayObject, index:Int) : DisplayObject {
        return this.sxAddChildAt(child, index);
    }//function addChildAt()


    /**
    * Remove child from specified index in display list
    *
    */
    override public function removeChildAt (index:Int, dispose:Bool = false) : DisplayObject {
        this.disposeRemovedChild = dispose;
        return this.sxRemoveChildAt(index);
    }//function removeChildAt()


    /**
    * Swap children in display list.
    * Required by transitions of ViewStack only.
    *
    */
    override public function swapChildren (child1:DisplayObject, child2:DisplayObject) : Void {
        this.sxSwapChildren(child1, child2);
    }//function swapChildren()


    /**
    * Getter `mouseX`.
    *
    */
    private function get_mouseX () : Float {
        return flash.Lib.current.mouseX;
    }//function get_mouseX


    /**
    * Getter `mouseY`.
    *
    */
    private function get_mouseY () : Float {
        return flash.Lib.current.mouseY;
    }//function get_mouseY

}//class Sprite