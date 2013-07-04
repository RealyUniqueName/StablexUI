/**
@manual Setup StablexUI

First of all you'll need the library.

<pre>
    haxelib install stablexui
</pre>

Or get the latest dev version from <a href="https://github.com/RealyUniqueName/StablexUI" target="_blank">GitHub</a>.

StablexUI has several dependancies, which will be installed too.

Now you need to add StablexUI, OpenFL and Actuate (one of dependencies) to project `.xml` file:

<pre>
    &lt;haxelib name="stablexui" /&gt;
    &lt;haxelib name="openfl" /&gt;
    &lt;haxelib name="actuate" /&gt;
</pre>

At last, you need to initialize StablexUI before using it.
Here is a sample main class with StablexUI initialization:
(roll mouse pointer over underlined type to see full classpath, click to go to it's API)

<haxe>
/**
* Main class of an application
*/
class Test extends flash.display.Sprite{

    /**
    * Entry point
    *
    */
    static public function main () : Void{
        //initialize StablexUI
        ru.stablex.ui.UIBuilder.init();

        //Congratulations! You can use StablexUI!

    }//function main()
}//class Test
</haxe>

Go nuts with StablexUI now :)
Or read next manual: <type>manual.02_Basics</type>
*/