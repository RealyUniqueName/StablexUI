package ru.stablex.ui;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;
import sys.io.File;


/**
* Function to create xml-based widget classes
*
*/
class ClassBuilder {


/*******************************************************************************
*   STATIC METHODS
*******************************************************************************/


    /**
    * Create class for custom widget based on xml markup
    *
    */
    static public function createClass(xmlFile:String, cls:String) : Expr {
        var pos = Context.makePosition({min:0, max:0, file:xmlFile});

        //extract packages and class name
        var pack : Array<String> = cls.split(".");
        cls = pack.pop();

        //parse xml file
        var root = Xml.parse( File.getContent(xmlFile) ).firstElement();

        //get parent
        var parentPack : Array<String> = ClassBuilder.getPack(root.nodeName);
        // var parentClass : String = UIBuilder.imports().get(root.nodeName);
        // if( parentClass == null ) Err.trigger('Class is not registered: ' + root.nodeName);
        // var parentPack : Array<String> = parentClass.split(".");
        // parentClass = parentPack.pop();

        //find children, which must be assigned to new class properties
        // + gen code for children
        var fields = ClassBuilder._getFields(root, pos);

        //get constructor definition
        fields.push( ClassBuilder._genConstructor(root, pos) );

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
        Context.defineType(clazz);

        //register class
        UIBuilder.registerClass(cls);

        return Context.makeExpr(Void, Context.currentPos());
    }//function createClass()


    /**
    * Generate expressions structure for constructor
    *
    */
    static private function _genConstructor(xml:Xml, pos:Position) : Field {
        var code  :String = "";
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

        // //find children, which must be assigned to new class properties
        // // + gen code for children
        // var data = ClassBuilder._getFields(xml, pos);

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
    * Get fields to create for new class
    *
    */
    static private function _getFields(xml:Xml, pos:Position, fields:Array<Field> = null) : Array<Field> {
        if( fields == null ) fields = [];

        var name : String;
        var e : Expr;
        for(node in xml.elements()){
            name = node.get("name");
            //if this node has `name` attribute
            if( name != null ){
                e = Context.parse(name, pos);
                switch(e.expr){
                    case EConst(a):
                        switch(a){
                            //if value of `name` attribute is string constant, create class field definition
                            case CString(fieldName):
                                var nodePack : Array<String> = ClassBuilder.getPack(node.nodeName);
                                fields.push({
                                    pos    : pos,
                                    name   : fieldName,
                                    meta   : [],
                                    kind   : FVar(TPath({
                                        sub    : null,
                                        params : [],
                                        name   : nodePack.pop(),
                                        pack   : nodePack,
                                    })),
                                    doc    : null,
                                    access : [APublic]
                                });
                            default:
                        }
                    default:
                }
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

/*******************************************************************************
*   INSTANCE METHODS
*******************************************************************************/



/*******************************************************************************
*   GETTERS / SETTERS
*******************************************************************************/



}//class ClassBuilder

#end