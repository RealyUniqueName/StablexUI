package ru.stablex.ui.misc;

import flash.display.DisplayObject;
import flash.text.TextField;
import ru.stablex.ui.widgets.Widget;


/**
* Size calculations required due to some platforms inconsistency
*
*/
class SizeTools {


    /**
    * Get object width
    *
    */
    static public inline function width (obj:DisplayObject) : Float {
        // #if html5
            if( Std.is(obj, Widget) ){
                return cast(obj, Widget).w;
            }else if( Std.is(obj, TextField) ){
                return cast(obj, TextField).textWidth + 4;
            }else{
                return obj.width;
            }
    }//function width()


    /**
    * Get object height
    *
    */
    static public inline function height (obj:DisplayObject) : Float {
        if( Std.is(obj, Widget) ){
            return cast(obj, Widget).h;
        }else if( Std.is(obj, TextField) ){
            #if html5
                //hack for wrong textHeight calculations in html5 target of openfl 2.0
                var tf    = cast(obj, TextField).defaultTextFormat;
                var lines = cast(obj, TextField).numLines;
                var h : Float = Std.int(tf.size * 1.185 * lines);
                h = (Std.int(h) - h + 1) * lines + 1 + (lines - 1) * tf.leading + h;
                return h + 4;
            #else
                return cast(obj, TextField).textHeight + 4;
            #end
        }else{
            return obj.height;
        }
    }//function height()


    /**
    * Set object x
    *
    */
    static public inline function setX (obj:DisplayObject, x:Float) : Void {
        #if html5
            obj.x = (Std.is(obj, TextField) ? obj.x = x + 2 : x);
        #else
            obj.x = x;
        #end
    }//function setX()


    /**
    * Set object y
    *
    */
    static public inline function setY (obj:DisplayObject, y:Float) : Void {
        #if html5
            obj.y = (Std.is(obj, TextField) ? obj.y = y + 2 : y);
        #else
            obj.y = y;
        #end
    }//function setY()

}//class SizeTools