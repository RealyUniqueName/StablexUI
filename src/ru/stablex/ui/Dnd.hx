package ru.stablex.ui;

import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.Lib;
import ru.stablex.ui.events.DndEvent;
import ru.stablex.ui.widgets.Widget;
import motion.actuators.GenericActuator;


/**
* Drag`n`drop manager
*
*/
class Dnd {
    //currently processed drag'n'drop event (exists since drag until drop)
    static public var current (default, null) : DndEvent;
    //required for proper dropping processing on mouseDown
    static private var _skipMouseDown : Bool = false;

/*******************************************************************************
*   STATIC METHODS
*******************************************************************************/

    /**
    * Start dragging specified widget
    * @param w - widget to drag
    * @param dragArea - widget will be added to dragArea's display list for dragging
    * @param key - key to filter dropped objects on <type>ru.stablex.ui.events.DndEvent</type>.RECEIVE. Any string you wish.
    * @param dropOnRelease - if true, <type>ru.stablex.ui.events.DndEvent</type>.RECEIVE will be dispatched on next <type>flash.events.MouseEvent</type>.MOUSE_UP.
    *                        If false, <type>ru.stablex.ui.events.DndEvent</type>.RECEIVE will be dispatched on next <type>flash.events.MouseEvent</type>.MOUSE_DOWN.
    */
    static public function drag(w:Widget, dragArea:DisplayObjectContainer = null, key:String = null, dropOnRelease:Bool = true) : Void {
        //if we still did not drop previousely dragged widget
        if( Dnd.current != null ){
            Dnd.current.drop(true);
        }

        Dnd.current = new DndEvent(DndEvent.DRAG, w, dragArea, true, false, key);
        w.dispatchEvent(Dnd.current);

        //if dropped while processing DRAG event
        if( Dnd.current == null || Dnd.current.dropped ) return;

        Dnd.current.obj.mouseEnabled = Dnd.current.obj.mouseChildren = false;

        //if we have to use another object as an area for dragging
        if( dragArea != null && dragArea != Dnd.current.srcParent ){
            Dnd.current.srcParent.removeChild(Dnd.current.obj);
            dragArea.addChild(Dnd.current.obj);

            var p : Point = dragArea.globalToLocal( Dnd.current.srcParent.localToGlobal(Dnd.current.srcPos) );
            Dnd.current.obj.left = p.x;
            Dnd.current.obj.top  = p.y;
        }

        //start dragging
        Dnd.current.obj.startDrag();

        //Start listening for mouse up
        Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, Dnd._onDrop);
        Lib.current.stage.removeEventListener(MouseEvent.MOUSE_DOWN, Dnd._onDrop);
        if( dropOnRelease ){
            Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, Dnd._onDrop);
        }else{
            Dnd._skipMouseDown = true;
            Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, Dnd._onDrop);
        }
    }//function drag()


    /**
    * Process drop
    *
    */
    static private function _onDrop(e:MouseEvent) : Void {
        if( e.type == MouseEvent.MOUSE_DOWN && Dnd._skipMouseDown ){
            Dnd._skipMouseDown = false;
            return;
        }

        Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, Dnd._onDrop);
        Lib.current.stage.removeEventListener(MouseEvent.MOUSE_DOWN, Dnd._onDrop);

        if( Dnd.current != null && !Dnd.current.dropped ){
            Lib.current.stage.removeEventListener(DndEvent.RECEIVE, Dnd._onStageReceive);
            Lib.current.stage.addEventListener(DndEvent.RECEIVE, Dnd._onStageReceive);

            var drop    = Dnd.current.cloneWithType(DndEvent.DROP);
            var receive = Dnd.current.cloneWithType(DndEvent.RECEIVE);

            Dnd.current.obj.dispatchEvent( drop );
            e.target.dispatchEvent( receive );
        }
    }//function _onDrop()


    /**
    * Finish dnd event processing
    *
    */
    static private function _onStageReceive(e:DndEvent) : Void {
        Lib.current.stage.removeEventListener(DndEvent.RECEIVE, Dnd._onStageReceive);
        if( !e.dropped ){
            e.drop(true);
        }
    }//function _onStageReceive()


    /**
    * Cleaning
    * @private
    */
    static public function finish(e:DndEvent) : Void {
        if( Dnd.current != null && Dnd.current.obj == e.obj ){
            Dnd.current = null;
        }
    }//function finish()



/*******************************************************************************
*   INSTANCE METHODS
*******************************************************************************/

    /**
    * Instantiating is not allowed
    *
    */
    private function new() : Void {
    }//function new()



/*******************************************************************************
*   GETTERS / SETTERS
*******************************************************************************/



}//class Dnd