package ru.stablex.backend.geom;

#if (flash || openfl)
typedef Matrix = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("flash", "geom.Matrix")]>;

#else
typedef Matrix = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "geom.Matrix.MatrixRef")]>;


/**
* Reference for Matrix implementation
*
*/
class MatrixRef {

    /**
    * Translates the matrix along the x and y axes, as specified by the dx and dy parameters
    *
    */
    public function translate (tx:Float, ty:Float) : Void {
        //code...
    }//function translate()

}//class MatrixRef

#end
