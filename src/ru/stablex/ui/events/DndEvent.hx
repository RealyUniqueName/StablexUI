package ru.stablex.ui.events;

import nme.display.DisplayObjectContainer;
import nme.events.Event;
import nme.geom.Point;
import ru.stablex.ui.widgets.Widget;
import com.eclecticdesignstudio.motion.actuators.GenericActuator;


/**
* Drag'n'drop event
*
*/
class DndEvent extends Event{
    //Widget was dragged
    static public inline var DRAG = "dndDrag";
    //Widget was dropped
    static public inline var DROP = "dndDrop";
    //Widget was hit by dropped object
    static public inline var RECEIVE = "dndReceive";

    //Dragged object
    public var obj (default,null) : Widget;
    //dragged widget position before dragging
    public var srcPos : Point;
    //initial parent of dragged widget
    public var srcParent (default,null) : DisplayObjectContainer;
    //childIndex of dragged widget before dragging
    public var srcChildIndex (default,null) : Int;
    //if object was dropped already
    public var dropped (default,null) : Bool = false;
    //save object properties befor dragging{
        private var _mouseEnabled : Bool = false;
        private var _mouseChildren : Bool = false;
    //}
    //If dropped object was accepted by some other object, this will be equal `true`.
    public var accepted (default,null) : Bool = false;
    //Value passed to <type>Dnd</type>.drag() as third argument. Use it to filter dropped objects on <type>ru.stablex.ui.events.DndEvent</type>.RECEIVE.
    public var key : String = null;

/*******************************************************************************
*   STATIC METHODS
*******************************************************************************/



/*******************************************************************************
*   INSTANCE METHODS
*******************************************************************************/

    /**
    * Constructor
    * @private
    */
    public function new(type:String, obj:Widget, dragArea:DisplayObjectContainer, bubble:Bool = false, cloned:Bool = false, key:String = null) : Void {
        //store required data
        if( !cloned ){
            this.key            = key;
            this.obj            = obj;
            this.srcPos         = new Point(this.obj.left, this.obj.top);
            this.srcParent      = this.obj.parent;
            this.srcChildIndex  = (this.srcParent != null ? this.srcParent.getChildIndex(this.obj) : -1);
            this._mouseChildren = this.obj.mouseChildren;
            this._mouseEnabled  = this.obj.mouseEnabled;
        }

        super(type, bubble);
    }//function new()


    /**
    * Stop dragging
    * @param undo - Return dragged object to initial position?
    */
    public function drop(undo:Bool = false) : Void {
        if( this.dropped ) return;
        this.dropped = true;

        this.obj.stopDrag();

        //cancel
        if( undo ){
            //return to initial parent
            if( this.srcParent != this.obj.parent ){
                if( this.srcParent != null && this.obj.parent != null ){
                    this._moveTo(
                        this.obj.parent.globalToLocal( this.srcParent.localToGlobal(this.srcPos) )
                    ).onComplete(this._returnToParent);
                }else{
                    this._returnToParent();
                }

            //parent was not changed, just return to initial pos
            }else{
                //set initial position
                this._moveTo(this.srcPos);
            }
        }

        this._finish();
    }//function drop()


    /**
    * Tween object to position
    *
    */
    private inline function _moveTo(pos:Point) : IGenericActuator {
        return this.obj.tween(0.1, {left:pos.x, top:pos.y}, "Quad.easeOut");
    }//function _moveTo()


    /**
    * Return dragged object to parent
    *
    */
    private function _returnToParent() : Void {
        //remove from current parent
        if( this.obj.parent != null ){
            this.obj.parent.removeChild(this.obj);
        }

        //add to initial parent
        if( this.srcParent != null ){
            if( this.srcChildIndex >= 0 && this.srcParent.numChildren >= this.srcChildIndex ){
                this.srcParent.addChildAt(obj, this.srcChildIndex);
            }else{
                this.srcParent.addChild(obj);
            }
        }

        //set position
        this.obj.left = this.srcPos.x;
        this.obj.top  = this.srcPos.y;
    }//function _returnToParent()


    /**
    * Finish process, cleaning
    *
    */
    private function _finish() : Void {
        this.obj.mouseEnabled  = this._mouseEnabled;
        this.obj.mouseChildren = this._mouseChildren;

        Dnd.finish(this);
    }//function _finish()


    /**
    * Clone current event, but with another type
    *
    */
    public function cloneWithType(type:String) : DndEvent {
        var e : DndEvent = new DndEvent(type, this.obj, this.obj.parent, this.bubbles, true);

        e.key            = this.key;
        e.obj            = this.obj;
        e.srcParent      = this.srcParent;
        e.srcPos         = this.srcPos;
        e.srcChildIndex  = this.srcChildIndex;
        e._mouseChildren = this._mouseChildren;
        e._mouseEnabled  = this._mouseEnabled;

        return e;
    }//function cloneWithType()


    /**
    * Call this method to inidcate drag'n'drop routine was successeful.
    * @param newParent - add dropped object to this container
    */
    public function accept(newParent:DisplayObjectContainer = null) : Void {
        var p : Point = (
            this.obj.parent == null
                ? new Point(this.obj.left, this.obj.top)
                : this.obj.parent.localToGlobal( new Point(this.obj.left, this.obj.top) )
        );

        if( newParent != null ){
            p = newParent.globalToLocal(p);
        }

        this.accepted = true;
        this.drop();

        if( newParent != null ){
            if( this.obj.parent != null ){
                this.obj.parent.removeChild(this.obj);
            }
            this.obj.left = p.x;
            this.obj.top  = p.y;
            newParent.addChild(this.obj);
        }
    }//function accept()



/*******************************************************************************
*   GETTERS / SETTERS
*******************************************************************************/



}//class DndEvent