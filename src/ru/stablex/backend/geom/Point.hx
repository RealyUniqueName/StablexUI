package ru.stablex.backend.geom;

#if (flash || openfl)
typedef Point = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("flash", "geom.Point")]>;

#else
typedef Point = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "geom.Point.PointRef")]>;

/**
* Reference for Point implementation
*
*/
class PointRef {
    /** x coordinate */
    public var x : Float = 0;
    /** y coordinate */
    public var y : Float = 0;


    /**
    * Constructor
    *
    */
    public function new (x:Float = 0, y:Float = 0) : Void {
        this.x = x;
        this.y = y;
    }//function new()

}//class PointRef

#end