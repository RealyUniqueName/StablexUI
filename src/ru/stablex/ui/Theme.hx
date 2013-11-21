package ru.stablex.ui;

/**
* :INFO:
* Special thanks to Dima (profelis) Granetchi for resource embedding code
* https://github.com/profelis
*/

using StringTools;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import sys.FileSystem;
import sys.io.File;

enum AssetType {
    AImage;
    ASound;
}

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

#if !macro
    /** _bmpMeta */
    static public var bmpMeta : Map<String,{width:Int,height:Int}> = new Map();
    /** cache of bitmaps retreived from assets */
    static private var _bmpCache : Map<String,BitmapData> = new Map();

#else
    /** match file name in full file path */
    static private var _erFile : EReg = ~/([^\\\/]+)$/;
    /** check if file is image */
    static private var _erImg : EReg = ~/^(jpg|jpeg|png)$/i;
    /** non alphanumeric characters */
    static private var _erNonAlphaNum : EReg = ~/[^0-9a-zA-Z]/g;

    /**
    * Get directory of a file for current context
    *
    */
    static private inline function _dir () : String {
        var file : String = Context.getPosInfos(Context.currentPos()).file;
        return Theme._erFile.replace(file, '');
    }//function _dir()


    /**
    * Get meta name for asset
    *
    */
    static private inline function _getMetaName(type:AssetType) {
            return switch (type) {
                    case AImage: ":bitmap";
                    case ASound: ":sound";
            }
    }//function _getMetaName()


    /**
    * Get base type for asset
    *
    */
    static private inline function _getKind(type:AssetType) {
            return switch (type) {
                case AImage: TDClass( { pack : ["flash", "display"], name : "BitmapData", params :[] } );
                case ASound: TDClass( { pack : ["flash", "media"], name : "Sound", params :[] } );
            }
    }//function _getKind()


    /**
    * Get prefix for asset class
    *
    */
    static private inline function _getPrefix(type:AssetType) {
            return switch (type) {
                case AImage: "Bitmap_";
                case ASound: "Sound_";
            }
    }//functionget _getPrefix()

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
    macro static public function addAssets (path:String) : Array<Field> {
        if( Context.defined('display') ) return null;

        var pos = Context.currentPos();
        var fields : Array<Field> = Context.getBuildFields();

        //package for assets classes
        var pack : Array<String> = Context.getLocalClass().get().pack.copy();
        pack.push('assets');

        var fnBody : Array<Expr> = [];

        path = (
            path.charAt(path.length - 1) == '/' || path.charAt(path.length - 1) == '\\'
                ? path
                : path + '/'
        ).replace('\\', '/');
        var dir : String = Theme._dir().replace('\\', '/') + path;

        for(fname in FileSystem.readDirectory(dir)){
            var name     : String = _erNonAlphaNum.replace(fname, '_');
            var fullpath : String = Context.resolvePath(dir + fname);
// trace(fullpath);
            //skip directories for now
            if( FileSystem.isDirectory(fullpath) ) continue;

            //asset type
            var ext : String = fullpath.split('.').pop();
            if( !_erImg.match(ext) ){
                //do nothing with other asset types for now
                continue;
            }

            var type : AssetType = AImage;

            var cls : TypeDefinition  = {
                    pos      : pos,
                    fields   : [],
                    params   : [],
                    pack     : pack,
                    name     : Theme._getPrefix(type) + name,
                    meta     : [{name:Theme._getMetaName(type), params:[macro $v{fullpath}], pos:pos}],
                    isExtern : false,
                    kind     : Theme._getKind(type),
            };

            Context.defineType(cls);

            var src : String = path + fname;
            var e   : Expr = Context.parse('new ' + cls.pack.join('.') + '.' + cls.name + '(0, 0)', pos);
            fnBody.push(macro if( path == $v{src} ) return $e);
        }

        //create method for retrieving bitmaps
        fnBody.push(macro return null);
        fields.push({
            pos  : pos,
            name : 'getBitmapData',
            meta : null,
            kind : FFun({
                ret    : TPath({pack:['flash', 'display'], name:'BitmapData', params:[]}),
                params : [],
                expr   : {expr:EBlock(fnBody), pos:pos},
                args   : [{name:'path', opt:false, type:TPath({pack:[], name:'String', params:[]})}]
            }),
            access : [AStatic, APublic]
        });

        return fields;
    }//function addAssets()

#if !macro


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
            trace("Can't find resource: " + path);
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