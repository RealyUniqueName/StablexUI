package ru.stablex;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import sys.io.File;
#end


/**
* Assets class wraps nme.Assets.
* Its methods are dynamic so you can override them to implement
* different types of resource loading
*/
class Assets{

#if !macro
    /**
    * By default it is equal to nme.Assets.getBitmapData
    *
    */
    static dynamic public function getBitmapData(src:String, useCache:Bool = true) : nme.display.BitmapData {
        return nme.Assets.getBitmapData(src, useCache);
    }//function getBitmapData()


    /**
    * By default it is equal to nme.Assets.getBytes
    *
    */
    static dynamic public function getBytes(src:String) : nme.utils.ByteArray {
        return nme.Assets.getBytes(src);
    }//function getBytes()


    /**
    * It is equal to nme.Assets.getFont and can not be overriden due to some strange bug:
    * if this method is declared as dynamic, cpp fails to compile (hxcpp 2.10.2)
    *
    */
    static public inline function getFont(src:String) : nme.text.Font {
        return nme.Assets.getFont(src);
    }//function getFont()


    /**
    * By default it is equal to nme.Assets.getSound
    *
    */
    static dynamic public function getSound(src:String) : nme.media.Sound {
        return nme.Assets.getSound(src);
    }//function getSound()


    /**
    * By default it is equal to nme.Assets.getText
    *
    */
    static dynamic public function getText(src:String) : String {
        return nme.Assets.getText(src);
    }//function getText()

#end

    /**
    * Embed file content "as is" at compile time. This content can be any valid haxe code.
    *
    */
    @:macro static public function embed (file:String) : Expr{
        return Context.parse( File.getContent(file), Context.makePosition({min:0, max:1, file:file}));
    }//function embed()


    /**
    * Embed file content as String at compile time.
    *
    * @return String - content of specified file
    */
    @:macro static public function embedStr (fname:String) : Expr{
        return Context.makeExpr(File.getContent(fname), Context.currentPos());
    }//function embedStr()

}//class Assets