package ru.stablex.backend.geom;

#if (flash || openfl)
typedef Rectangle = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("flash", "geom.Rectangle")]>;

#else
typedef Rectangle = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "geom.Rectangle", "geom.Rectangle.RectangleRef")]>;


/**
* Reference for Rectangle implementation
*
*/
class RectangleRef {

    /** top left x coordinate */
    public var x : Float = 0;
    /** top left y coordinate */
    public var y : Float = 0;
    /** width of this rectangle */
    public var width : Float = 0;
    /** height of this rectangle */
    public var height : Float = 0;


    /**
    * Constructor
    *
    */
    public function new (x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) : Void {
        this.x      = x;
        this.y      = y;
        this.width  = width;
        this.height = height;
    }//function new()

}//class RectangleRef

#end