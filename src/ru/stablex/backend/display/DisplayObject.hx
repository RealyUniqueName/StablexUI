package ru.stablex.backend.display;


#if (flash || openfl)
typedef DisplayObject = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("flash", "display.DisplayObject")]>;

#else
import ru.stablex.backend.geom.Point;
import ru.stablex.backend.geom.Rectangle;

typedef DisplayObject = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "display.DisplayObject.DisplayObjectRef")]>;

/**
* Reference for DisplayObject implementation (properties required by StablexUI)
* You have to implement event management and bubbling by yourself.
*
*/
class DisplayObjectRef {
    /** position: x coordinate */
    public var x : Float = 0;
    /** position: y coordinate */
    public var y : Float = 0;
    /** transparency */
    public var alpha : Float = 1;
    /** whether this object if visible or not */
    public var visible : Bool = true;
    /** width of this object */
    public var width : Float = 0;
    /** height of this object */
    public var height : Float = 0;
    /** parent container of this object */
    public var parent : DisplayObjectContainer;
    /** name for this object */
    public var name : String = null;
    /** the Stage of the display object */
    public var stage : Stage;


    /**
    * Transforms a point from the local coordinate system to global (stage) coordinates
    * Required by Drag'n'Drop manager only.
    *
    */
    public function localToGlobal (p:Point) : Point {
        return p;
    }//function localToGlobal()


    /**
    * Transforms a point from global (stage) coordinates to the local coordinate system.
    * Required by Drag'n'drop manager only.
    */
    public function globalToLocal (p:Point) : Point {
        return p;
    }//function globalToLocal()


    /**
    * Add listener for specified event type
    *
    */
    public function addEventListener (eventType:String, eventHandler:Dynamic->Void) : Void {
        //code...
    }//function addEventListener()


    /**
    * Remove previousely added listener for specified event type
    *
    */
    public function removeEventListener (eventType:String, eventHandler:Dynamic->Void) : Void {
        //code...
    }//function removeEventListener()


    /**
    * Returns a rectangle that defines the boundary of the display object, based
    * on the coordinate system defined by the targetCoordinateSpace parameter
    *
    */
    public function getRect (targetCoordinateSpace:DisplayObject) : Rectangle {
        //code...
    }//function getRect()

}//class DisplayObjectRef


#end
