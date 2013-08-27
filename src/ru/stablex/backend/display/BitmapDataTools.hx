package ru.stablex.backend.display;

#if (flash || openfl)
typedef BitmapDataTools = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "display.BitmapDataToolsFlash")]>;

#else
typedef BitmapDataTools = haxe.macro.MacroType<[ru.stablex.ui.ClassBuilder.getBackendClass("ru.stablex.backend", "display.BitmapDataTools.BitmapDataToolsRef")]>;



/**
* Reference to implement methods for bitmapdata drawings on sprites
*
*/
class BitmapDataToolsRef {


    /**
    * Draw rectangle on specified sprite using this bitmap
    *
    * @param mx     - transformation matrix
    * @param x      - top left corner of drawing
    * @param y      - top left corner of drawing
    * @param width  - width of drawing
    * @param height - height of drawing
    * @param smooth - enable bitmap smoothing
    */
    static public function drawRect (sprite:Sprite, bmp:BitmapData, mx:Matrix, x:Float, y:Float, width:Float, height:Float, smooth:Bool = false) : Void {
    }//function drawRect()


    /**
    * Instantiating is not allowed
    *
    */
    private function new () : Void {
    }//function new()

}//class BitmapDataToolsRef

#end
