package ru.stablex.ui;

import hscript.Expr;
import hscript.Interp;
import hscript.Parser;
import ru.stablex.ui.widgets.Widget;

#if haxe3
private typedef Hash<T> = Map<String,T>;
#end

/**
* Stores parsed xml data for ui creation
*
*/
class RTXml {
    //hscript parser and interpretator
    static public var parser : Parser;
    static public var interp : Interp;

    //classes registered for xml
    static public var imports : Hash<Class<Dynamic>>;

    //xml tag class
    public var cls : Class<Dynamic>;
    //the only special case attribute
    public var defaults : String;
    //xml tag attributes
    public var data : Array<Attribute>;
    //parsed children nodes
    public var children : Array<RTXml>;

/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/

    /**
    * Register class for usage in xml
    *
    */
    static public function regClass (cls:Class<Dynamic>) : Void {
        if( RTXml.imports == null ) RTXml.imports = new Hash();

        var clsName : String = Type.getClassName(cls);
        RTXml.imports.set(clsName.substr(clsName.lastIndexOf('.', clsName.length - 1) + 1), cls);
    }//function regClass()


    /**
    * Find imported class by shortcut
    *
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
    */
    static public function buildFn (xmlStr:String) : ?Dynamic->Widget {
        if( RTXml.parser == null ){
            RTXml.parser = new Parser();
            RTXml.interp = new Interp();
        }

        return RTXml.processXml( Xml.parse(xmlStr).firstElement() ).create;
    }//function buildFn()


    /**
    * Get data from xml for ui creation
    *
    */
    static public function processXml (node:Xml) : RTXml {
        var cache : RTXml = new RTXml();
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
            cache.children.push( RTXml.processXml(child) );
        }

        return cache;
    }//function processXml()


/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/


    /**
    * Constructor
    *
    */
    public function new () : Void {
        this.data     = [];
        this.children = [];
    }//function new()


    /**
    * Creates objects for ui
    *
    */
    public function create (args:Dynamic = null) : Widget {
        //create widget instance
        var obj : Widget = Type.createInstance(this.cls, []);

        //apply defaults  {
            obj.defaults = this.defaults;
            if( obj.defaults == null ) obj.defaults = "Default";
            UIBuilder.applyDefaults(obj);
        //}

        //apply properties
        for(prop in this.data){
            prop.apply(obj);
        }

        obj._onInitialize();

        //add children
        if( this.children.length > 0 ){
            for(i in 0...this.children.length){
                obj.addChild( this.children[i].create() );
            }
        }

        obj._onCreate();

        return cast obj;
    }//function create()


/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/


}//class RTXml


/**
* Xml tag attribute
*
*/
class Attribute {
    //attribute name
    public var name : String;
    //if this is nested property attribute
    private var _child : Attribute;
    //if property needs to be of specified type
    private var _instanceof : Class<Dynamic>;
    //attribute value interpretator
    public var value : Expr;

/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/



/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/

    /**
    * Constructor
    *
    */
    public function new (name:String, expression:String) : Void {
        var names : Array<String> = name.split("-");
        var name  : Array<String> = names.shift().split(":");
        this.name = name.shift();

        //if property needs to be of specified type
        if( name.length > 0 ){
            this._instanceof = RTXml.getImportedClass(name[0]);
        }

        //if this is nested property attribute
        if( names.length > 0 ){
            this._child = new Attribute(names.join("-"), expression);
        }else{
            this.value = RTXml.parser.parseString(expression);
        }
    }//function new()


    /**
    * Apply attribute value to object
    *
    */
    public function apply (obj:Dynamic, level:Int = 0) : Void {
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

            this._child.apply(subObj);

        //simple attribute
        }else{
            Reflect.setProperty(obj, this.name, RTXml.interp.execute(this.value));
        }
    }//function apply()


/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

}//class Attribute