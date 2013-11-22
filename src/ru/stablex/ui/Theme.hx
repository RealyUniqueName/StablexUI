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
import haxe.macro.Type;
import haxe.macro.TypeTools;
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


    /**
    * Get file list in directory. Recursive
    *
    */
    static public function listFiles (dir:String) : Array<String> {
        var inspect : Array<String> = [];
        for(fname in FileSystem.readDirectory(dir)){
            inspect.push(dir + fname);
        }

        var files   : Array<String> = [];

        var fname : String;
        while( inspect.length > 0 ){
            fname = inspect.pop();

            //skip directories for now
            if( FileSystem.isDirectory(fname) ) {
                for(path in FileSystem.readDirectory(fname)){
                    inspect.push(fname + '/' + path);
                }
            }else{
                files.push(fname);
            }
        }

        return files;
    }//function listFiles()


    /**
    * Add resources (images, texts, etc.) from specified directory.
    * Path should be relative to calling file.
    *
    */
    static public function addAssets (fields:Array<Field>, path:String) : Array<Field> {
        if( Context.defined('display') ) return fields;

        var pos = Context.currentPos();

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

        var name  : String;
        var fname : String;
        for(fullpath in Theme.listFiles(dir)){
            fname = fullpath.replace(dir, '');
            if( fname.charAt(0) == '/' ) fname = fname.substr(1, fname.length - 1);
            name  = _erNonAlphaNum.replace(fname, '_');

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
            var src = /* path + */ fname;
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


    /**
    * Get list of skins defined by specified theme.
    * Returns Map<skinName,skinType>
    *
    */
    static public function getSkinList (theme:String) : Map<String,String> {
        var skins : Map<String,String> = new Map();
        var definitions : Type = null;
        try{
            definitions = Context.getType(theme + '.Skins');
        }catch(e:Dynamic){
            return skins;
        }

        //Skins must be a class
        switch(definitions){
            case TInst(t,[]):
                //check if static fields describe skins
                for(field in t.get().statics.get()){
                    switch(field.kind){
                        case FMethod(_):
                            switch(field.type){
                                case TLazy(_):
                                    var type : String = TypeTools.toString(field.type);
                                    type = type.substring(type.lastIndexOf('->') + 2, type.length).trim();

                                    if( Theme.isSkin( Context.getType(type) ) ){
                                        skins.set(field.name, type);
                                    }
                                case _:
                            }
                        case _:
                    }
                }
            case _: throw theme + '.Skins must be a class without type parameters';
        }

        return skins;
    }//function getSkinList()


    /**
    * Check if specified type is descendant of ru.stablex.ui.skins.Skin
    *
    */
    static private function isSkin (type:Type) : Bool {
        switch(type){
            case TInst(t,_):
                var cls = t.get();
                if( cls.pack.join('.') + '.' + cls.name == 'ru.stablex.ui.skins.Skin' ){
                    return true;
                }
                return (
                    cls.superClass == null
                        ? false
                        : Theme.isSkin( Context.getType(cls.superClass.t.toString()) )
                );
            case _: return false;
        }

        return false;
    }//function isSkin()

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
    * Register your theme using build macro with this method
    *
    */
    macro static public function register () : Array<Field> {
        var fields : Array<Field> = Context.getBuildFields();

        Theme.addAssets(fields, 'assets');

        return fields;
    }//function register()


#if !macro



#end

}//class Theme