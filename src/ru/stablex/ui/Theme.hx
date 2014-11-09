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


#end

/**
* Base class for themes
*
*/
#if !macro @:autoBuild(ru.stablex.ui.Theme.register()) #end
@:allow(ru.stablex)
class Theme {
    /**
    * Replacement for non-alphanumeric characters in class names generated from file names.
    * Using underscore '_' breaks compatibility with HTML5 target
    */
    static private inline var _NON_ALPHANUM_REPLACEMENT = 'DDOTT';
#if !macro


#else
    /** match file name in full file path */
    static private var _erFile : EReg = ~/([^\\\/]+)$/;
    /** check if file is image */
    static private var _erImg : EReg = ~/^(jpg|jpeg|png)$/i;
    /** check if file is font */
    static private var _erFont : EReg = ~/^(ttf)$/i;
    /** non alphanumeric characters */
    static private var _erNonAlphaNum : EReg = ~/[^0-9a-zA-Z]/g;
    /** defauls from registered themes */
    static private var _defaults : Map<String, Map<String,Array<String>> > = new Map();
    /** directories of themes */
    static private var _themeDirectory : Map<String,String> = new Map();

    /**
    * Get directory of a file for current context
    *
    */
    static private inline function _dir (pos:Position = null) : String {
        if (pos == null) pos = Context.currentPos();
        var file : String = Context.resolvePath( Context.getPosInfos(pos).file );

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
                case AImage : "Bitmap" + _NON_ALPHANUM_REPLACEMENT;
                case ASound : "Sound" + _NON_ALPHANUM_REPLACEMENT;
                case AFont  : "Font" + _NON_ALPHANUM_REPLACEMENT;
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
    static private function listFiles (dir:String) : Array<String> {
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
    * Get position of theme being built
    *
    */
    static private function _themeClassPos () : Position {
        return switch (Context.getLocalType()) {
            case TInst(t,_) : t.get().pos;
            case _: Context.currentPos();
        }
    }//function _themeClassPos()


    /**
    * Add resources (images, texts, etc.) from specified directory.
    * Path should be relative to calling file.
    *
    */
    static private function addAssets (fields:Array<Field>, path:String) : Array<Field> {
        if( Context.defined('display') ) return fields;

        var pos = Theme._themeClassPos();

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
        var dir : String = Theme._dir(pos).replace('\\', '/') + path;

        var name  : String;
        var fname : String;
        for(fullpath in Theme.listFiles(dir)){
            fname = fullpath.replace(dir, '');
            if( fname.charAt(0) == '/' ) fname = fname.substr(1, fname.length - 1);
            name  = _erNonAlphaNum.replace(fname, _NON_ALPHANUM_REPLACEMENT);

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
    * Register defaults of currently built theme
    *
    */
    static private function addDefaults (theme:String) : Void {
        var defDir : String = Theme._themeDirectory.get(theme) + 'defaults';
        var themeDefaults : Map<String,Array<String>> = new Map();

        if( Context.defined('display') || !FileSystem.exists(defDir) ){
            Theme._defaults.set(theme, themeDefaults);
            return;
        }

        for(fname in FileSystem.readDirectory(defDir)){
            if( fname.lastIndexOf('.hx') != fname.length - 3) continue;

            var name : String = fname.substr(0, fname.length - 3);
            var cls  : String = theme + '.defaults.' + name;

            var defaults : Array<String> = [];

            //get type
            var definitions : Type = null;
            try{
                definitions = Context.getType(cls);
            }catch(e:Dynamic){
                continue;
            }

            //collect fields as defaults
            switch(definitions){
                case TInst(t,[]):
                    //check if static fields describe defaults
                    for(field in t.get().statics.get()){
                        //skip private fields
                        if( !field.isPublic ) continue;

                        var type = TypeTools.toString(field.type);
                        type = type.substring(type.indexOf(':') + 1, type.length).trim();

                        if( type == 'ru.stablex.ui.widgets.Widget -> Void' ){
                            defaults.push(field.name);
                        }
                    }
                case _: throw cls + ' must be a class without type parameters';
            }

            themeDefaults.set(name, defaults);
        }

        Theme._defaults.set(theme, themeDefaults);
    }//function addDefaults()


    /**
    * Get list of skins defined by specified theme.
    * Returns Map<skinName,skinType>
    *
    */
    static private function getSkinList (theme:String) : Map<String,String> {
        var skins : Map<String,String> = new Map();
        if( Context.defined('display') ) return skins;

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

                                    if( Theme.isDescendantFor(Context.getType(type), 'ru.stablex.ui.skins.Skin') ){
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
    * Get list of defaults for specified theme
    * Returns Map<WidgetName,Array<DefaultsName>>
    */
    static private function getDefaultsList (theme:String) : Map<String, Array<String>> {
        //make compiler load theme files
        Context.getType(theme + '.Main');

        var defaults = Theme._defaults.get(theme);
        if( defaults == null ){
            Theme.addDefaults(theme);
            defaults = Theme._defaults.get(theme);
        }

        return defaults;
    }//function getDefaultsList()


    /**
    * Check if specified type is descendant of ru.stablex.ui.skins.Skin
    *
    */
    static private function isDescendantFor (type:Type, parent:String) : Bool {
        switch(type){
            case TInst(t,_):
                var cls = t.get();
                if( cls.pack.join('.') + '.' + cls.name == parent ){
                    return true;
                }
                return (
                    cls.superClass == null
                        ? false
                        : Theme.isDescendantFor(Context.getType(cls.superClass.t.toString()), parent)
                );
            case _: return false;
        }

        return false;
    }//function isSkin()


    /**
    * Check if theme has entry point defined in main class
    *
    */
    static private function hasMain (theme:String) : Bool {
        var type : Type = Context.getType('$theme.Main');
        switch(type){
            case TInst(t,_):
                for(field in t.get().statics.get()){
                    if( field.name == 'main' ) return true;
                }
            case _:
        }

        return false;
    }//function hasMain()

#end

    /**
    * Get directory of a file where this method is called
    *
    */
    macro static private function dir () : ExprOf<String> {
        var dir : String = Theme._dir();
        return macro $v{dir};
    }//function dir()


    /**
    * Register your theme using build macro with this method
    *
    */
    macro static private function register () : Array<Field> {
        var fields : Array<Field> = Context.getBuildFields();

        Theme.addAssets(fields, 'assets');
        // Theme.addDefaults();

        var theme : String = Context.getLocalClass().toString();
        theme = theme.substring(0, theme.lastIndexOf('.'));
        Theme._themeDirectory.set(theme, Theme._dir(Theme._themeClassPos()));

        return fields;
    }//function register()


#if !macro



#end

}//class Theme