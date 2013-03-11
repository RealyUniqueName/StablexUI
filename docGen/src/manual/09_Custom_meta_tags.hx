/**
@manual Custom meta tags

You can define your own meta tags and create meta processors to affect StablexUI code generation flow.
Let's define meta tag wich will add specified amount of children for any widget this tag is attached to.
Here is how to create meta processor:
1. Define macro function, wich will create meta processors;
2. Call that function once before any UIBuilder.buildFn();

<haxe>
/**
* It's better to create separate class for this purpose to avoid a lot of errors
* and #if macro <...> #end usage
*/
@:macro class Macro {

    /**
    * Call this method before any UIBuilder.buildFn() calls
    *
    */
    static public function createMetas() : haxe.macro.Expr {
        //create meta for `createChildren`
        ru.stablex.ui.UIBuilder.meta.set('createChildren', function(node:<type>Xml</type>, parentWidget:<type>String</type>) : <type>String</type>{
            //how many children need to create?
            var amount = node.get('amount');
            //create code for that
            var code = 'for(i in 0...' + amount + '){ ' + parentWidget + '.addChild(new nme.display.Sprite()) ;}';

            return code;
        });

        return haxe.macro.Context.makeExpr(Void, haxe.macro.Context.currentPos());
    }//function createMetas()
}//class Macro
</haxe>

And

<haxe>
    //initialize StablexUI
    ru.stablex.ui.UIBuilder.init();

    //create custom metas
    Macro.createMetas();

    //create UI
    nme.Lib.current.addChild( ru.stablex.ui.UIBuilder.buildFn('ui.xml')() );
</haxe>

Now you can use it in ui.xml:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<Widget w="800" h="600"/>
    <!-- create 100 children for this widget -->
    <|meta:createChildren amount="100" />
</Widget>
</xml>

*/