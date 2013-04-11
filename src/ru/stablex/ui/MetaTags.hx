package ru.stablex.ui;

#if macro

import sys.io.File;


/**
* Class to create definitions for core meta tags
* You have no need to use this class.
*/
class MetaTags {


/*******************************************************************************
*   STATIC METHODS
*******************************************************************************/

    /**
    * Create definitions
    * @private
    */
    static public function create() : Void {
        include();
        inject();
        repeat();
    }//function create()


    /**
    * &lt;meta:include /&gt; - replace this meta tag with content of another xml file
    * attributes:
    *   src - path to xml file to include
    */
    static public function include() : Void {
        UIBuilder.meta.set('include', function(node:Xml, parentWidget:String) : String {
            var xmlFile : String = node.get('src');
            if( xmlFile == null ) Err.trigger('meta:include - file is not specified');

            var code : String = UIBuilder.construct( Xml.parse( File.getContent(xmlFile) ).firstElement(), 1, null, "__meta__include" );
            code += '\nreturn __meta__include1;';
            code = '\n' + parentWidget + '.addChild((function() : ru.stablex.ui.widgets.Widget {' + code + '})());';

            return '\n' + code + '\n';
        });
    }//function include()


    /**
    * &lt;meta:inject /&gt; - insert haxe code
    * attributes:
    *   code - haxe code to inject
    */
    static public function inject() : Void {
        UIBuilder.meta.set('inject', function(node:Xml, parentWidget:String) : String {
            var code : String = node.get('code');
            if( code == null ) Err.trigger('meta:inject - code is not specified');

            return '\n' + UIBuilder.fillCodeShortcuts(parentWidget, code);
        });
    }//function inject()


    /**
    * &lt;meta:repeat /&gt; - repeat children of meta tag several times
    * attributes:
    *   counter - name for counter variable. Default: i
    *   times   - how many times to repeat
    */
    static public function repeat() : Void {
        UIBuilder.meta.set('repeat', function(meta:Xml, parentWidget:String) : String {
            var counter : String = meta.get("counter");
            if( counter == null ) counter = "i";

            var times : String = meta.get("times");
            if( times == null ) Err.trigger("meta:repeat - `times` is not specified");

            var code = "\nfor(" + counter + " in 0..." + UIBuilder.fillCodeShortcuts(parentWidget, times) + "){";

            for(node in meta.elements()){
                //if this node defines some meta
                if( node.nodeName.indexOf('meta:') == 0 ){
                    var meta : String = node.nodeName.substr('meta:'.length);
                    var fn   : Xml->String->String = UIBuilder.meta.get(meta);
                    if( fn == null ) Err.trigger('Meta processor not found: ' + meta);

                    code += fn(node, parentWidget);

                //continue ordinary code generation
                }else{
                    var code2 : String = "\n" + UIBuilder.construct(node, 1, null, "__meta__repeat");
                    code2 += "\nreturn __meta__repeat1;";
                    code += "\n" + parentWidget + ".addChild( (function() : ru.stablex.ui.widgets.Widget {" + code2 + "})() );";
                }
            }

            code += "\n}";

            return code;
        });
    }//function repeat()


/*******************************************************************************
*   INSTANCE METHODS
*******************************************************************************/



/*******************************************************************************
*   GETTERS / SETTERS
*******************************************************************************/



}//class MetaTags

#end