package ru.stablex;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import openfl.AssetType;
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
    static dynamic public function getBitmapData(src:String, useCache:Bool = true) : #if nme nme #else flash #end.display.BitmapData {
        return #if nme nme #else openfl #end.Assets.getBitmapData(src, useCache);
    }//function getBitmapData()


    /**
    * By default it is equal to nme.Assets.getBytes
    *
    */
    static dynamic public function getBytes(src:String) : #if nme nme #else flash #end.utils.ByteArray {
        return #if nme nme #else openfl #end.Assets.getBytes(src);
    }//function getBytes()


    /**
    * It is equal to nme.Assets.getFont and can not be overriden due to some strange bug:
    * if this method is declared as dynamic, cpp fails to compile (hxcpp 2.10.2)
    *
    */
    static public inline function getFont(src:String) : #if nme nme #else flash #end.text.Font {
        return #if nme nme #else openfl #end.Assets.getFont(src);
    }//function getFont()


    /**
    * By default it is equal to nme.Assets.getSound
    *
    */
    static dynamic public function getSound(src:String) : #if nme nme #else flash #end.media.Sound {
        return #if nme nme #else openfl #end.Assets.getSound(src);
    }//function getSound()


    /**
    * By default it is equal to nme.Assets.getText
    *
    */
    static dynamic public function getText(src:String) : String {
        return #if nme nme #else openfl #end.Assets.getText(src);
    }//function getText()

#end

    /**
    * Embed file content "as is" at compile time. This content can be any valid haxe code.
    *
    */
    #if haxe3 macro #else @:macro #end static public function embed (file:String) : Expr{
        return Context.parse( File.getContent(file), Context.makePosition({min:0, max:1, file:file}));
    }//function embed()


    /**
    * Embed file content as String at compile time.
    *
    * @return String - content of specified file
    */
    #if haxe3 macro #else @:macro #end static public function embedStr (fname:String) : Expr{
        return Context.makeExpr(File.getContent(fname), Context.currentPos());
    }//function embedStr()

}//class Assets