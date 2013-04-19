package ru.stablex.ui;

import hscript.Expr;
import hscript.Interp;
import hscript.Parser;
import ru.stablex.ui.widgets.Widget;

#if haxe3
private typedef Hash<T> = Map<String,T>;
#end

/**
* Runtime xml processing
*
*/
class RTXml {
    /**
    * hscript parser and interpretator
    * @private
    */
    static public var parser : Parser;
    public var interp : Interp;

    /**
    * classes registered for xml
    * @private
    */
    static public var imports : Hash<Class<Dynamic>>;

    /**
    * xml tag class
    * @private
    */
    public var cls : Class<Dynamic>;
    /**
    * the only special case attribute
    * @private
    */
    public var defaults : String;
    /**
    * xml tag attributes
    * @private
    */
    public var data : Array<Attribute>;
    /**
    * parsed children nodes
    * @private
    */
    public var children : Array<RTXml>;

/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/

    /**
    * Register class for usage in xml
    * @private
    */
    static public function regClass (cls:Class<Dynamic>) : Void {
        if( RTXml.imports == null ) RTXml.imports = new Hash();

        var clsName : String = Type.getClassName(cls);
        RTXml.imports.set(clsName.substr(clsName.lastIndexOf('.', clsName.length - 1) + 1), cls);
    }//function regClass()


    /**
    * Find imported class by shortcut
    * @private
    */
    static public inline function getImportedClass (className:String) : Class<Dynamic> {
        var cls : Class<Dynamic> = RTXml.imports.get(className);

        if( cls == null ){
            Err.trigger("Class is not registered for runtime xml: " + className);
        }

        return cls;
    }//function getImportedClass()


    /**
    * Parse provided xml
    *
    * @param xmlStr - valid xml string
    *
    * @return - method for ui creation
    */
    static public function buildFn (xmlStr:String) : ?Dynamic->Widget {
        if( RTXml.parser == null ){
            RTXml.parser = new Parser();
        }

        #if flash
            //flash does not like colons in attributes names.
            //workaround this by replacing them with dots
            var r : EReg = new EReg("([_a-zA-Z0-9]+)\\:([-_a-zA-Z0-9:]+\\s*=\\s*)", "");
            while( r.match(xmlStr) ){
                xmlStr = r.replace(xmlStr, "$1.$2");
            }
        #end

        return RTXml.processXml( Xml.parse(xmlStr).firstElement() ).create;
    }//function buildFn()


    /**
    * Get data from xml for ui creation
    * @private
    */
    static public function processXml (node:Xml, interp:Interp = null) : RTXml {
        var cache : RTXml = new RTXml(interp);
        cache.cls = RTXml.getImportedClass(node.nodeName);

        //attributes
        for(attr in node.attributes()){
            if(attr == "defaults"){
                cache.defaults = node.get(attr);
            }else{
                cache.data.push( new Attribute(attr, node.get(attr)) );
            }
        }

        //children
        for(child in node.elements()){
            cache.children.push( RTXml.processXml(child, cache.interp) );
        }

        return cache;
    }//function processXml()


/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/


    /**
    * Constructor
    * @private
    */
    public function new (interp:Interp = null) : Void {
        this.data     = [];
        this.children = [];
        this.interp = (interp == null ? new Interp() : interp);
        this.interp.variables.set("__ui__UIBuilder", UIBuilder);

        //register imported classes
        for(cls in RTXml.imports.keys()){
            this.interp.variables.set("__ui__" + cls, RTXml.imports.get(cls));
        }
    }//function new()


    /**
    * Creates objects for ui
    * @private
    */
    public function create (args:Dynamic = null) : Widget {
        if( args != null ){
            this.interp.variables.set("__ui__arguments", args);
        }

        //create widget instance
        var obj : Widget = Type.createInstance(this.cls, []);
        this.interp.variables.set("__ui__this", obj);

        //apply defaults  {
            obj.defaults = this.defaults;
            if( obj.defaults == null ) obj.defaults = "Default";
            UIBuilder.applyDefaults(obj);
        //}

        //apply properties
        for(prop in this.data){
            prop.apply(obj, this.interp);
        }

        obj._onInitialize();

        //add children
        if( this.children.length > 0 ){
            for(i in 0...this.children.length){
                obj.addChild( this.children[i].create() );
            }
        }

        obj._onCreate();

        if( args != null ){
            this.interp.variables.remove("__ui__arguments");
        }

        return cast obj;
    }//function create()


/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/


}//class RTXml


/**
* Xml tag attribute
* @private
*/
class Attribute {
    //for replacing @someVar with arguments passed to RTXml.buildFn()({arguments})
    static private var _erCodeArg : EReg = ~/(^|[^@])@([._a-z0-9]+)/i;
    //for replacing `this` keyword with object currently being processed
    static private var _erThis    : EReg = ~/(^|[^\$])\$this([^a-z0-9_])/i;
    //for replacing $ClassName with classes registered through UIBuilder.regClass('fully qualified class name')
    static private var _erCls     : EReg = ~/(^|[^\$])\$([a-z0-9_]+)([^a-z0-9_])/i;
    //for replacing #someId with UIBuilder.get('someId')
    static private var _erId      : EReg = new EReg("(^|[^#])#([a-z0-9_]+)([^a-z0-9_])", "i");
    //for replacing #SomeClass(someId) with UIBuilder.getAs('someId', SomeClass)
    static private var _erCastId  : EReg = new EReg("(^|[^#])#([a-z0-9_]+)\\(([a-z0-9_]+)\\)", "i");

    /**
    * attribute name
    * @private
    */
    public var name : String;
    //if this is nested property attribute
    private var _child : Attribute;
    //if property needs to be of specified type
    private var _instanceof : Class<Dynamic>;
    /**
    * attribute value interpretator
    * @private
    */
    public var value : Expr;

/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/

    /**
    * Replace placeholders with actual code
    * @private
    */
    static public inline function fillShortcuts (code:String) : String {
        //this
        while( _erThis.match(code) ){
            code = _erThis.replace(code, '$1__ui__this$2');
        }

        //class names
        while( _erCls.match(code) ){
            if( !RTXml.imports.exists(_erCls.matched(2)) ){
                Err.trigger("Class is not registered for runtime xml: " + _erCls.matched(2));
            }
            code = _erCls.replace(code, "$1__ui__$2$3");
        }

        //arguments
        while( _erCodeArg.match(code) ){
            code = _erCodeArg.replace(code, '$1__ui__arguments.$2');
        }

        //widget by id as specified class instance
        while( _erCastId.match(code) ){
            if( !RTXml.imports.exists(_erCastId.matched(2)) ){
                Err.trigger("Class is not registered for runtime xml: " + _erCastId.matched(2));
            }
            code = _erCastId.replace(code, "$1__ui__UIBuilder.getAs('$3', __ui__$2)");
        }

        //widget by id
        while( _erId.match(code) ){
            code = _erId.replace(code, "$1__ui__UIBuilder.get('$2')$3");
        }

        code = StringTools.replace(code, "##", "#");
        code = StringTools.replace(code, "$$", "$");
        code = StringTools.replace(code, "@@", "@");

        return code;
    }//function fillShortcuts()


/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/

    /**
    * Constructor
    * @private
    */
    public function new (name:String, expression:String) : Void {
        var all   : Array<String> = name.split("-");
        var local : Array<String> = all.shift().split(#if flash "." #else ":" #end);

        this.name = local.shift();

        //if property needs to be of specified type
        if( local.length > 0 ){
            this._instanceof = RTXml.getImportedClass(local[0]);
        }

        //if this is nested property attribute
        if( all.length > 0 ){
            this._child = new Attribute(all.join("-"), expression);
        }else{
            this.value = RTXml.parser.parseString( Attribute.fillShortcuts(expression) );
        }
    }//function new()


    /**
    * Apply attribute value to object
    * @private
    */
    public function apply (obj:Dynamic, interp) : Void {
        //if this attribute defines nested property
        if( this._child != null ){
            var subObj : Dynamic = Reflect.getProperty(obj, this.name);

            //if this property must be of specified type
            if( this._instanceof != null && !Std.is(subObj, this._instanceof) ){
                subObj = Type.createInstance(this._instanceof, []);
                Reflect.setProperty(obj, this.name, subObj);

                //if this is Widget instance, call required methods to finish instance creation
                if( Std.is(subObj, Widget) ){
                    var w : Widget = cast(subObj, Widget);
                    UIBuilder.applyDefaults(w);
                    w._onInitialize();
                    w._onCreate();
                }
            }

            this._child.apply(subObj, interp);

        //simple attribute
        }else{
            Reflect.setProperty(obj, this.name, interp.execute(this.value));
        }
    }//function apply()


/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

}//class Attribute