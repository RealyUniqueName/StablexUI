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
    AFont;
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
    /** check if file is font */
    static private var _erFont : EReg = ~/^(ttf)$/i;
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
                    case AImage : ":bitmap";
                    case ASound : ":sound";
                    case AFont  : ":font";
            }
    }//function _getMetaName()


    /**
    * Get base type for asset
    *
    */
    static private inline function _getKind(type:AssetType) {
            return switch (type) {
                case AImage : TDClass( { pack : ["flash", "display"], name : "BitmapData", params :[] } );
                case ASound : TDClass( { pack : ["flash", "media"], name : "Sound", params :[] } );
                case AFont  : TDClass( { pack : ["flash", "text"], name : "Font", params :[] } );
            }
    }//function _getKind()


    /**
    * Get prefix for asset class
    *
    */
    static private inline function _getPrefix(type:AssetType) {
            return switch (type) {
                case AImage : "Bitmap_";
                case ASound : "Sound_";
                case AFont  : "Font_";
            }
    }//functionget _getPrefix()


    /**
    * Create field definition for caching purposes
    *
    */
    static private inline function _genCacheField (fieldName:String, objType:String) : Field {
        var cls : Array<String> = objType.split('.');
        return {
            kind : FVar(
                TPath({
                    name   : 'Map',
                    pack   : [],
                    params : [
                        TPType(TPath({ name : 'String', pack : [], params : [] })),
                        TPType(TPath({ name : cls.pop(), pack : cls, params : [] }))
                    ]
                }),
                macro new Map()
            ),
            meta   : [],
            name   : fieldName,
            doc    : null,
            pos    : Context.currentPos(),
            access : [APublic,AStatic]
        };
    }//function _genCacheField()

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

        //cache for bitmaps
        fields.push(Theme._genCacheField('bitmapDataCache', 'flash.display.BitmapData'));
        //cache for fonts
        fields.push(Theme._genCacheField('fontCache', 'String'));

        //package for assets classes
        var pack : Array<String> = Context.getLocalClass().get().pack.copy();
        pack.push('assets');

        var getBitmapDataBody : Array<Expr> = [];
        var getFontBody       : Array<Expr> = [];

        path = (
            path.charAt(path.length - 1) == '/' || path.charAt(path.length - 1) == '\\'
                ? path
                : path + '/'
        ).replace('\\', '/');
        var dir : String = Theme._dir().replace('\\', '/') + path;

        for(fname in FileSystem.readDirectory(dir)){
            var name     : String = _erNonAlphaNum.replace(fname, '_');
            var fullpath : String = Context.resolvePath(dir + fname);

            //skip directories for now
            if( FileSystem.isDirectory(fullpath) ) continue;

            //asset type
            var ext  : String = fullpath.split('.').pop();
            var type : AssetType = (_erImg.match(ext) ? AImage : (_erFont.match(ext) ? AFont : null));

            //do nothing with other asset types for now
            if( type == null ){
                continue;
            }

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

            //add code to asset getters
            var src = path + fname;
            switch(type){
                //getImageData
                case AImage:
                    var e : Expr = Context.parse('new ' + cls.pack.join('.') + '.' + cls.name + '(0, 0)', pos);
                    getBitmapDataBody.push(macro if( path == $v{src} ) {
                        var bmp = $e;
                        bitmapDataCache.set(path, bmp);
                        return bmp;
                    });
                //getFontName
                case AFont:
                    var className : String = cls.pack.join('.') + '.' + cls.name;
                    var e         : Expr = Context.parse('new $className()', pos);
                    var eclass    : Expr = Context.parse(className, pos);
                    getFontBody.push(macro if( path == $v{src} ) {
                        var fnt = $e;
                        flash.text.Font.registerFont($eclass);
                        fontCache.set(path, fnt.fontName);
                        return fnt.fontName;
                    });
                //other
                case _:
            }
        }//for(files in asset dir)

        //create method for retrieving bitmaps
        getBitmapDataBody.unshift(macro {var bmp = bitmapDataCache.get(path); if( bmp != null ) return bmp;});
        getBitmapDataBody.push(macro {trace('Asset not fount: ' + path); return null;});
        fields.push({
            pos  : pos,
            name : 'getBitmapData',
            meta : null,
            kind : FFun({
                ret    : TPath({pack:['flash', 'display'], name:'BitmapData', params:[]}),
                params : [],
                expr   : {expr:EBlock(getBitmapDataBody), pos:pos},
                args   : [{name:'path', opt:false, type:TPath({pack:[], name:'String', params:[]})}]
            }),
            access : [AStatic, APublic]
        });

        //create method for retrieving font names
        getFontBody.unshift(macro {var fnt = fontCache.get(path); if( fnt != null ) return fnt;});
        getFontBody.push(macro {trace('Asset not fount: ' + path); return null;});
        fields.push({
            pos  : pos,
            name : 'getFontName',
            meta : null,
            kind : FFun({
                ret    : TPath({pack:[], name:'String', params:[]}),
                params : [],
                expr   : {expr:EBlock(getFontBody), pos:pos},
                args   : [{name:'path', opt:false, type:TPath({pack:[], name:'String', params:[]})}]
            }),
            access : [AStatic, APublic]
        });

        return fields;
    }//function addAssets()

#if !macro



#end

}//class Theme