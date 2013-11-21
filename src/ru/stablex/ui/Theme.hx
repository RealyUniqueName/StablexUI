package ru.stablex.ui;

using StringTools;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import sys.FileSystem;
import sys.io.File;

#else

import haxe.io.Bytes;
import flash.display.BitmapData;

#end

/**
* Base class for themes
*
*/
class Theme {
    /** prefix for resource names */
    static public inline var RESOURCE_PREFIX = 'theme-assets:';

#if macro
    /** match file name in full file path */
    static private var _erFile : EReg = ~/([^\\\/]+)$/;


    /**
    * Get directory of a file for current context
    *
    */
    static private inline function _dir () : String {
        var file : String = Context.getPosInfos(Context.currentPos()).file;
        return Theme._erFile.replace(file, '');
    }//function _dir()

#end

    /**
    * Get directory of a file where this method is called
    *
    */
    macro static public function dir () : ExprOf<String> {
        var dir : String = Theme._dir();
        return macro $v{dir};
    }//function dir()


    /**
    * Add resources (images, texts, etc.) from specified directory.
    * Path should be relative to calling file.
    *
    */
    macro static public function addAssets (path:String) : Expr {
        path = (
            path.charAt(path.length - 1) == '/' || path.charAt(path.length - 1) == '\\'
                ? path
                : path + '/'
        );
        var dir : String = Theme._dir() + path;

        for(path in FileSystem.readDirectory(dir)){
            //skip directories for now
            if( FileSystem.isDirectory(path) ) continue;
            Context.addResource(RESOURCE_PREFIX + path, File.getBytes(path));
        }

        return macro {};
    }//function addAssets()

#if !macro
    /** cache of bitmaps retreived from assets */
    static private var _bmpCache : Map<String,BitmapData> = new Map();


    /**
    * Destroy cached bitmaps
    *
    */
    static public function clearCache () : Void {
        //code...
    }//function clearCache()


    /**
    * Get bytes from stored assets
    *
    */
    static public function getBytes (path:String) : Bytes {
        var bytes : Bytes = haxe.Resource.getBytes(RESOURCE_PREFIX + path);
        if( bytes == null ){
            bytes = haxe.Resource.getBytes(RESOURCE_PREFIX + path.replace('/', '\\'));
            if( bytes == null ){
                bytes = haxe.Resource.getBytes(RESOURCE_PREFIX + path.replace('\\', '/'));
                if( bytes == null ){
                    trace("Can't find resource: " + path);
                }
            }
        }

        return bytes;
    }//function getBytes()


    /**
    * Get bitmap from stored assets
    *
    */
    static public function getBitmapData (path:String) : BitmapData {
        var bytes = Theme.getBytes(path);
        if( bytes == null ) return null;

        return null;
    }//function getBitmapData()

#end

}//class Theme