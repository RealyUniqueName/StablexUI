package ru.stablex;


/**
*   Errors tracing and processing.
*
*/
class Err {


    /**
    * Throws an exception and (if -debug) traces message
    *
    * @throw <type>String</type>
    */
    static inline public function trigger(msg:String) : Void {
        #if debug
            trace(msg);
        #end
        #if macro
            haxe.macro.Context.error(msg, haxe.macro.Context.currentPos());
        #else
            throw msg;
        #end
    }//function trigger()



    /**
    * Constructor. Instancing is not allowed
    *
    */
    private function new() : Void {

    }//function new()

}//class Err