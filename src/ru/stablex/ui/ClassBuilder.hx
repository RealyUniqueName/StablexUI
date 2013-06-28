package ru.stablex.ui;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;
import sys.io.File;


/**
* Functions to create xml-based widget classes
* You have no need to use this class.
*/
class ClassBuilder {


/*******************************************************************************
*   STATIC METHODS
*******************************************************************************/


    /**
    * Create class for custom widget based on xml markup
    * @private
    */
    static public function createClass(xmlFile:String, cls:String) : TypeDefinition {
        var pos = Context.makePosition({min:0, max:0, file:xmlFile});

        //extract packages and class name
        var pack : Array<String> = cls.split(".");
        cls = pack.pop();

        //parse xml file
        var root = Xml.parse( File.getContent(xmlFile) ).firstElement();

        //get parent
        var parentPack : Array<String> = ClassBuilder.getPack(root.nodeName);

        //find children, which must be assigned to new class properties
        var fieldsData = ClassBuilder._getFields(root, pos);

        //create instances for properties
        var fields : Array<Field> = [];
        var code   : String = "";
        for(fdata in fieldsData){
            fields.push(fdata.field);

            //create instance
            code += '\nthis.' + fdata.field.name + ' = new ' + UIBuilder.imports().get(fdata.node.nodeName) + '();';

            //process 'defaults' attribute
            var defaults : String = fdata.node.get('defaults');
            if( defaults != null ){
                code += "\nthis." + fdata.field.name + ".defaults = " + defaults + ";";
            }
            code += "\nru.stablex.ui.UIBuilder.applyDefaults(this." + fdata.field.name + ");";

            code += UIBuilder.attr2Haxe(fdata.node, "this." + fdata.field.name);
        }

        //get `_onInitialize` definition
        fields.push( ClassBuilder._genOnInitialize(root, pos) );
        //get constructor definition
        fields.push( ClassBuilder._genConstructor(root, pos, code) );

        //create new class definition
        var clazz:TypeDefinition  = {
            pos      : pos,
            fields   : fields,
            params   : [],
            pack     : pack,
            name     : cls,
            meta     : [  ],
            isExtern : false,
            kind     : TDClass( { name : parentPack.pop(), pack : parentPack, params :[] } ),
        };

        return clazz;
    }//function createClass()


    /**
    * Generate expressions structure for constructor
    *
    */
    static private function _genConstructor(xml:Xml, pos:Position, code:String) : Field {
        //default settings{
            var defaults : String = xml.get('defaults');
            if( defaults != null ){
                code += '\nif( ru.stablex.ui.UIBuilder.defaults.exists("' + xml.nodeName + '") ){';
                code += '\n     var defs = ' + defaults + '.split(",");';
                code += '\n     var defFns = ru.stablex.ui.UIBuilder.defaults.get("' + xml.nodeName + '");';
                code += '\n     for(i in 0...defs.length){';
                code += '\n         var defaultsFn : ru.stablex.ui.widgets.Widget->Void = defFns.get(defs[i]);';
                code += '\n         if( defaultsFn != null ) defaultsFn(this);';
                code += '\n     }';
                code += '\n}';
            }
            code += "\nru.stablex.ui.UIBuilder.applyDefaults(this);";
        //}

        //generate dummy function to extract expressions for constructor method
        var dummy : Expr = Context.parse("function () { super(); " + code + UIBuilder.attr2Haxe(xml, "this") + " }", pos);

        //extract expressions
        var eblock : Expr = null;
        switch(dummy.expr){
            case EFunction(a,b) : eblock = b.expr;
            default:
        }

        //build Field structure
        return {
            pos    : pos,
            name   : "new",
            meta   : [],
            kind   : FFun({
                ret    : null,
                params : [],
                expr   : eblock,
                args   : [],
            }),
            doc    : null,
            access : [APublic]
        };
    }//function _genConstructor()


    /**
    * Generate '._onInitialize' method definition
    *
    */
    static private function _genOnInitialize(xml:Xml, pos:Position) : Field {
        //generate code
        var code : String = "";
        for(node in xml.elements()){
            code += ClassBuilder._construct(pos, node);
        }

        //generate dummy function to extract expressions
        var dummy : Expr = Context.parse("function () { super._onInitialize(); " + code + " }", pos);

        //extract expressions
        var eblock : Expr = null;
        switch(dummy.expr){
            case EFunction(a,b) : eblock = b.expr;
            default:
        }

        //build Field structure
        return {
            pos    : pos,
            name   : "_onInitialize",
            meta   : [],
            kind   : FFun({
                ret    : null,
                params : [],
                expr   : eblock,
                args   : [],
            }),
            doc    : null,
            access : [AOverride, APublic]
        };
    }//function _genOnInitialize()



    /**
    * Get fields to create for new class
    *
    */
    static private function _getFields(xml:Xml, pos:Position, fields:Array<{field:Field, node:Xml}> = null) : Array<{field:Field, node:Xml}> {
        if( fields == null ) fields = [];

        var field : String;
        for(node in xml.elements()){
            field = ClassBuilder._fieldName(node, pos);
            //if this node must be referenced by class field
            if( field != null ){
                var nodePack : Array<String> = ClassBuilder.getPack(node.nodeName);
                fields.push({
                    node  : node,
                    field : {
                        pos    : pos,
                        name   : field,
                        meta   : [],
                        kind   : FVar(TPath({
                            sub    : null,
                            params : [],
                            name   : nodePack.pop(),
                            pack   : nodePack,
                        })),
                        doc    : null,
                        access : [APublic]
                    }
                });
            }
            ClassBuilder._getFields(node, pos, fields);
        }

        return fields;
    }//function _getFields()


    /**
    * Return array of packages + class name for specified imported class
    * @private
    */
    static public inline function getPack(importedClass:String) : Array<String> {
        var cls : String = UIBuilder.imports().get(importedClass);
        if( cls == null ) Err.trigger('Class is not registered: ' + importedClass);
        return cls.split(".");
    }//function getPack()


    /**
    * Returns field name which must reference to this node in generated class
    *
    */
    static private function _fieldName(node:Xml, pos:Position) : Null<String> {
        var name : String = node.get("name");
        //if this node has `name` attribute
        if( name != null ){
            var e : Expr = Context.parse(name, pos);
            switch(e.expr){
                case EConst(a):
                    switch(a){
                        //if value of `name` attribute is string constant, return it as field name
                        case CString(fieldName):
                            name = fieldName;
                        default:
                            name = null;
                    }
                default:
                    name = null;
            }
        }

        return name;
    }//function _fieldName()


    /**
    * Generates code based on Xml object.
    * @private
    * @throw <type>String</type> if one of used in xml widgets, classes or events was not registered by UIBuilder.regClass() or UIBuilder.regEvent()
    */
    static public function _construct (pos:Position, element:Xml, n:Int = 1, parent:String = "this", wname:String = "__ui__widget") : String{
        var code   : String = '';
        var widget : String = wname + n;
        var field  : String = ClassBuilder._fieldName(element, pos);
        //if this element must be assigned to a field
        if( field != null ){
            widget = "this." + field;
        //create widget instance for this node
        }else{
            //get class for widget
            var cls  : String = UIBuilder.imports().get(element.nodeName);
            if( cls == null ) Err.trigger('Widget class is not registered: ' + element.nodeName);
            code += '\nvar '+ widget + ' = new ' + cls + '();';

            //default settings {
                var defaults : String = element.get('defaults');
                if( defaults != null ){
                    code += "\n" + widget + ".defaults = " + defaults + ";";
                }
                code += "\nru.stablex.ui.UIBuilder.applyDefaults(" + widget + ");";
            //}
            code += UIBuilder.attr2Haxe(element, widget);
        }

        //call .onInitialize method to notify widget that it is initialized
        code += '\n'+ widget + '._onInitialize();';

        //if we have nested widgets, generate code for them
        for(node in element.elements()){
            //if this node defines some meta
            if( node.nodeName.indexOf('meta:') == 0 ){
                var meta : String = node.nodeName.substr('meta:'.length);
                var fn   : Xml->String->String = UIBuilder.meta.get(meta);
                if( fn == null ) Err.trigger('Meta processor not found: ' + meta);

                code += fn(node, widget);

            //continue ordinary code generation
            }else{
                code += '\n' + ClassBuilder._construct(pos, node, n + 1, widget, wname);
            }
        }

        //call .onCreate method to notify widget that it is created
        code += '\n'+ widget + '._onCreate();';

        //add to parent's display list
        code += '\n'+ parent + '.addChild('+ widget + ');';

        return code;
    }//function _construct()


/*******************************************************************************
*   INSTANCE METHODS
*******************************************************************************/



/*******************************************************************************
*   GETTERS / SETTERS
*******************************************************************************/



}//class ClassBuilder

#end