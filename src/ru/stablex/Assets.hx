package ru.stablex;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import sys.io.File;
#end


/**
* Assets class wraps flash.Assets.
* Its methods are dynamic so you can override them to implement
* different types of resource loading
*/
class Assets{

#if !macro
    /**
    * By default it is equal to flash.Assets.getBitmapData
    *
    */
    static dynamic public function getBitmapData(src:String, useCache:Bool = true) : flash.display.BitmapData {
        return #if openfl openfl.Assets.getBitmapData(src, useCache) #else null #end;
    }//function getBitmapData()


    /**
    * By default it is equal to flash.Assets.getBytes
    *
    */
    static dynamic public function getBytes(src:String) : flash.utils.ByteArray {
        return #if openfl openfl.Assets.getBytes(src) #else null #end;
    }//function getBytes()


    /**
    * It is equal to flash.Assets.getFont and can not be overriden due to some strange bug:
    * if this method is declared as dynamic, cpp fails to compile (hxcpp 2.10.2)
    *
    */
    static public inline function getFont(src:String) : flash.text.Font {
        return #if openfl openfl.Assets.getFont(src) #else null #end;
    }//function getFont()


    /**
    * By default it is equal to flash.Assets.getSound
    *
    */
    static dynamic public function getSound(src:String) : flash.media.Sound {
        return #if openfl openfl.Assets.getSound(src) #else null #end;
    }//function getSound()


    /**
    * By default it is equal to flash.Assets.getText
    *
    */
    static dynamic public function getText(src:String) : String {
        return #if openfl openfl.Assets.getText(src) #else null #end;
    }//function getText()

#end

    /**
    * Embed file content "as is" at compile time. This content can be any valid haxe code.
    *
    */
    macro static public function embed (file:String) : Expr{
        return Context.parse( File.getContent(file), Context.makePosition({min:0, max:1, file:file}));
    }//function embed()


    /**
    * Embed file content as String at compile time.
    *
    * @return String - content of specified file
    */
    macro static public function embedStr (fname:String) : Expr{
        return Context.makeExpr(File.getContent(fname), Context.currentPos());
    }//function embedStr()

}//class Assets