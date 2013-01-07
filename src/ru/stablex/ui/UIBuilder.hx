package ru.stablex.ui;

import haxe.macro.Context;
import haxe.macro.Expr;
#if macro
import sys.io.File;
#else
import nme.text.TextField;
import ru.stablex.ui.widgets.Widget;
#end


/**
* Core class. All macro magic lives here
*/
class UIBuilder {
    //Regexps for checking attribute types and code generation in xml {
        //checks wether attribute declares event listener
        @:macro static private var _erEvent    : EReg = ~/^on-(.+)/i;
        //for replacing @someVar with arguments passed to UIBuilder.buildFn()({arguments})
        @:macro static private var _erCodeArg : EReg = ~/@([._a-z0-9]+)([^.a-z0-9_])/i;
        //for replacing $ClassName with classes registered through UIBuilder.regClass('fully qualified class name')
        @:macro static private var _erCls     : EReg = ~/\$([a-z0-9_]+)([^a-z0-9_])/i;
        //for replacing #someId with UIBuilder.get('someId')
        @:macro static private var _erId      : EReg = new EReg("#([a-z0-9_]+)([^a-z0-9_])", "i");
        //for replacing `this` keyword with object currently being processed
        @:macro static private var _erThis    : EReg = ~/\$this([^a-z0-9_])/i;
    //}

    @:macro static private var _events  : Hash<String> = new Hash();
    @:macor static private var _imports : Hash<String> = new Hash();

    @:macro static private var _initialized : Bool = false;

#if !macro
    //Closures for applaying default settings to widgets. Closures created with UIBuilder.init('defaults.xml')
    static public var defaults : Hash<Hash<Widget->Void>> = new Hash();

    //Widgets created with UIBuilder.buildFn() or UIBuilder.create()
    static private var _objects : Hash<Widget> = new Hash();

    //For id generator
    static private var _nextId : Int = 0;

    //Skins. Loaded with UIBuilder.regSkins() or set manualy by UIBuilder.skins.set(skinName, skinStructure)
    static public var skins : Hash<TSkin> = new Hash();
#end


    /**
    * Initializing UIBuilder. Should be called before using any other UIBuilder methods except .reg* methods
    * @param defaultsXmlFile - null (default) or path to xml file with default settings for widgets
    */
    @:macro static public function init(defaultsXmlFile:String = null) : Expr {
        var code : String = 'true';

        if( !UIBuilder._initialized ){
            UIBuilder._initialized = true;

            //registering frequently used events
            UIBuilder.regEvent('enterFrame','nme.events.Event.ENTER_FRAME');
            UIBuilder.regEvent('click',     'nme.events.MouseEvent.CLICK');
            UIBuilder.regEvent('mouseDown', 'nme.events.MouseEvent.MOUSE_DOWN');
            UIBuilder.regEvent('mouseUp',   'nme.events.MouseEvent.MOUSE_UP');
            UIBuilder.regEvent('display',   'nme.events.Event.ADDED_TO_STAGE');
            UIBuilder.regEvent('create',    'ru.stablex.ui.events.WidgetEvent.CREATE');
            UIBuilder.regEvent('free',      'ru.stablex.ui.events.WidgetEvent.FREE');
            UIBuilder.regEvent('resize',    'ru.stablex.ui.events.WidgetEvent.RESIZE');

            //registering frequently used classes
            UIBuilder.regClass('ru.stablex.ui.widgets.Text');
            UIBuilder.regClass('ru.stablex.ui.widgets.InputText');
            UIBuilder.regClass('ru.stablex.ui.widgets.Panel');
            UIBuilder.regClass('ru.stablex.ui.widgets.Widget');
            UIBuilder.regClass('ru.stablex.ui.widgets.Bmp');
            UIBuilder.regClass('ru.stablex.ui.widgets.Button');
            UIBuilder.regClass('ru.stablex.ui.widgets.Box');
            UIBuilder.regClass('ru.stablex.ui.widgets.VBox');
            UIBuilder.regClass('ru.stablex.ui.widgets.HBox');
            UIBuilder.regClass('ru.stablex.ui.widgets.ViewStack');
            UIBuilder.regClass('ru.stablex.ui.widgets.Mask');
            UIBuilder.regClass('ru.stablex.ui.events.WidgetEvent');
            UIBuilder.regClass('ru.stablex.TweenSprite');
            UIBuilder.regClass('ru.stablex.ui.UIBuilder');
            UIBuilder.regClass('nme.Lib');
            UIBuilder.regClass('ru.stablex.Assets');
            UIBuilder.regClass('nme.events.Event');
            UIBuilder.regClass('nme.events.MouseEvent');

            //If provided with file for defaults, generate closures for applying defaults to widgets
            if( defaultsXmlFile != null ){
                code = '';
                var root : Xml = Xml.parse( File.getContent(defaultsXmlFile) ).firstElement();
                for(widget in root.elements()){
                    code += '\nif( !ru.stablex.ui.UIBuilder.defaults.exists("' + widget.nodeName + '") ) ru.stablex.ui.UIBuilder.defaults.set("' + widget.nodeName + '", new Hash());';
                    for(node in widget.elements()){
                        code += '\nru.stablex.ui.UIBuilder.defaults.get("' + widget.nodeName + '").set("' + node.nodeName + '", function(__ui__widget0:ru.stablex.ui.widgets.Widget) : Void {';
                        code += UIBuilder.construct(node, 1, widget.nodeName);
                        code += '\n});';
                    }
                }

                code = '(function() : Void {' + code + '})()';
            }
        }

        return Context.parse(code, Context.makePosition({ min:0, max:0, file:'UIBuilder.hx'}) );
    }//function _init()


    /**
    * Generates closure for widget creation. xmlFile - path to xml file with markup.
    * In xml you can use these placeholders:
    *   $this - replaced with current widget;
    *   $SomeClass - replaced with com.some.package.SomeClass. If registered with UIBuilder.regClass('com.some.package.SomeClass');
    *   #widgetId - replaced with UIBuilder.get('widgetId');
    *   @someParam - replaced with arguments.someParam. Arguments can be passed like this: UIBuilder.buildFn(xmlFile)({someParam:'some value', someParam2: 3.14});
    *
    * @throw <type>String</type> if .init() was not called before
    * @throw <type>String</type> if one of used in xml widgets, classes or events was not registered by .regClass() or .regEvent()
    *
    * @return <type>Dynamic</type>->Root_Xml_Element_Class<Widget>
    */
    @:macro static public function buildFn (xmlFile:String) : Expr{
        if( !UIBuilder._initialized ) Err.trigger('Call UIBuilder.init()');

        var element = Xml.parse( File.getContent(xmlFile) ).firstElement();
        var cls : String = UIBuilder._imports.get(element.nodeName);

        var code : String = UIBuilder.construct(element);
        code += '\nreturn __ui__widget1;';
        code = 'function(__ui__arguments:Dynamic = null) : ' + cls + ' {' + code + '}';

        return Context.parse(code, Context.makePosition({ min:0, max:0, file:xmlFile}) );
    }//function buildFn()


    /**
    * Generates code based on Xml object.
    *
    * @throw <type>String</type> if one of used in xml widgets, classes or events was not registered by .regClass() or .regEvent()
    */
    static private function construct (element:Xml, n:Int = 1, zeroElementCls:String = null) : String{
        //get class for widget
        var cls  : String = UIBuilder._imports.get(zeroElementCls == null ? element.nodeName : zeroElementCls);
        if( cls == null ) Err.trigger('Widget class is not registered: ' + element.nodeName);

        var code : String = '';

        if( zeroElementCls != null ){
            code = '\nvar __ui__widget' + n + ' : ' + cls + ' = cast(__ui__widget0, ' + cls + ');';
        }else{
            code += '\nvar __ui__widget' + n + ' : ' + cls + ' = new ' + cls + '();';

            //default settings {
                var defaults : String = element.get('defaults');
                if( defaults == null ) {
                    defaults = '"Default"';
                }

                code += '\nif( ru.stablex.ui.UIBuilder.defaults.exists("' + element.nodeName + '") ){';
                code += '\n     var defaultsFn : ru.stablex.ui.widgets.Widget->Void = ru.stablex.ui.UIBuilder.defaults.get("' + element.nodeName + '").get(' + defaults + ');';
                code += '\n     if( defaultsFn != null ) defaultsFn(__ui__widget' + n + ');';
                code += '\n}';
            //}
        }

        //apply xml attributes to widget
        var value : String;
        for(attr in element.attributes()){

            var value : String = element.get(attr);

            //if this attribute defines event listener
            if( UIBuilder._erEvent.match(attr) ){
                cls = UIBuilder._events.get( UIBuilder._erEvent.matched(1) );
                if( cls == null ) Err.trigger('Event is not registered: ' + UIBuilder._erEvent.matched(1));

                //required code replacements
                value = UIBuilder._fillCodeShortcuts('__ui__widget' + n, value);

                code += '\n__ui__widget' + n + '.addEventListener('+ cls +', function(event:nme.events.Event){' + value + '});';

            //just apply attribute value to appropriate widget property
            }else{
                //change '-' to '.', so 'someProp-nestedProp' becomes 'someProp.nestedProp'
                attr  = StringTools.replace(attr, '-', '.');

                //required code replacements
                value = UIBuilder._fillCodeShortcuts('__ui__widget' + n, value);

                code += '\n__ui__widget' + n + '.' + attr + ' = ' + value + ';';
            }
        }//for( attr )

        if( n > 1 ){
            code += '\n__ui__widget' + Std.string(n - 1) + '.addChild(__ui__widget' + n + ');';
        }

        //if we have nested widgets, generate code for them
        for(node in element.elements()){
            code += '\n' + UIBuilder.construct(node, n + 1);
        }

        //call .onCreate method to notify widget that it is created
        if( zeroElementCls == null ){
            code += '\n__ui__widget' + n + '.onCreate();';
        }

        return code;
    }//function construct()


    /**
    * Register event type to declare event listeners in xml (attributes prefixed with `on-[shortcut]`).
    *
    * @throw <type>String</type> if this shortcut is already used
    */
    @:macro static public function regEvent (shortcut:String, eventType:String) : Expr{
        if( UIBuilder._events.exists(shortcut) ) Err.trigger('Event is already registered: ' + shortcut);
        UIBuilder._events.set(shortcut, eventType);
        return Context.parse('true', Context.currentPos());
    }//function register()


    /**
    * Register class to use it in xml code.
    * For example 'com.pack.SomeClass' can be referenced in xml like this: $SomeClass
    *
    * @throw <type>String</type> if fullyQualifiedName is wrong (does not match `com.package.ClassName` notation)
    * @throw <type>String</type> if class is already registered. E.g. com.pack1.MyClass and org.pack2.MyClass
    * can not be registered simultaniousely, because both will be shortened to $MyClass for usage in xml.
    * You still can register one of them and use another one by it's full classpath in xml
    */
    @:macro static public function regClass (fullyQualifiedName:String) : Expr{
        var cls : String;

        var sc : EReg = ~/\.([a-z0-9_]+)$/i;
        if( sc.match(fullyQualifiedName) ){
            cls = sc.matched(1);
        }else{
            var sc : EReg = ~/^([a-z0-9_]+)$/i;
            if( sc.match(fullyQualifiedName) ){
                cls = sc.matched(1);
            }
        }

        if( cls != null ){
            if( UIBuilder._imports.exists(cls) ) Err.trigger('Class is already imported: ' + cls);
            UIBuilder._imports.set(cls, fullyQualifiedName);

        }else{
            Err.trigger('Wrong class name: ' + fullyQualifiedName);
        }

        return Context.parse('true', Context.currentPos());
    }//function regClass()


    /**
    * Replace code shortcuts:
    *   $this - replaced with current widget;
    *   $SomeClass - replaced with com.some.package.SomeClass. If registered with UIBuilder.regClass('com.some.package.SomeClass');
    *   #widgetId - replaced with UIBuilder.get('widgetId');
    *   @someParam - replaced with arguments.someParam. Arguments can be passed by UIBuilder.buildFn(xmlFile)({arguments});
    */
    static private function _fillCodeShortcuts (thisObj:String, code:String) : String{
        var cls    = UIBuilder._erCls;
        var id     = UIBuilder._erId;
        var arg    = UIBuilder._erCodeArg;
        var erThis = UIBuilder._erThis;

        //this
        while( erThis.match(code) ){
            code = erThis.replace(code, thisObj+'$1');
        }

        //class names
        while( cls.match(code) ){
            if( !UIBuilder._imports.exists(cls.matched(1)) ) Err.trigger('Class is not imported: ' + cls.matched(1));
            code = cls.replace(code, UIBuilder._imports.get(cls.matched(1)) + '$2' );
        }

        //widgets by ids
        while( id.match(code) ){
            code = id.replace(code, 'ru.stablex.ui.UIBuilder.get("$1")$2');
        }

        //arguments
        while( arg.match(code) ){
            code = arg.replace(code, '__ui__arguments.$1$2');
        }

        return code;
    }//function _fillCodeShortcuts()


#if !macro

    /**
    * Register skin list
    *
    */
    static inline public function regSkins(skinList:Dynamic<TSkin>) : Void {
        for(name in Reflect.fields(skinList)){
            UIBuilder.skins.set(name, Reflect.field(skinList, name));
        }
    }//function regSkins()


    /**
    * Creates unique id for widgets
    * @private
    */
    static public inline function createId() : String {
        return '__widget__' + Std.string( UIBuilder._nextId ++ );
    }//function createId()


    /**
    * Creates widgets at runtime
    *
    * @throw <type>Dynamic</type> if requested widget class does not have one of the provided properties
    */
    static public function create (cls:Class<Widget>, properties:Dynamic = null) : Widget{
        //create widget instance
        var obj : Widget = Type.createInstance(cls, []);

        //apply defaults  {
            obj.defaults = Reflect.field(properties, 'defaults');
            if( obj.defaults == null ) obj.defaults = 'Default';

            var clsName : String = Type.getClassName(cls);
            var widgetDefaults : Hash<Widget->Void> = UIBuilder.defaults.get( clsName.substr(clsName.lastIndexOf('.', clsName.length - 1) + 1) );
            if( widgetDefaults != null ){
                var defaultsFn : Widget->Void = widgetDefaults.get(obj.defaults);
                if( defaultsFn != null ){
                    defaultsFn(obj);
                }
            }
        //}

        //apply provided properties
        if( properties != null ){
            for(property in Reflect.fields(properties)){
                Reflect.setProperty(obj, property, Reflect.field(properties, property));
            }
        }

        obj.onCreate();

        return obj;
    }//function create ()


    /**
    * Get widget object by its id
    *
    */
    static public inline function get(id:String) : Widget {
        return UIBuilder._objects.get(id);
    }//function get()


    /**
    * Associate widget with its id, so it can be acquired by UIBuilder.get()
    * @private
    */
    static public inline function save (obj:Widget) : Void{
        if( UIBuilder._objects.exists(obj.id) ){
            Err.trigger('Widget id "' + obj.id + '" is already used');
        }else{
            UIBuilder._objects.set(obj.id, obj);
        }
    }//function save()


    /**
    * "Forget" widget. Free its id for using in other widgets
    * @private
    */
    static public inline function forget (id:String) : Void{
        UIBuilder._objects.remove(id);
    }//function forget()
#end
}//class UIBuilder