/**
@manual Setup StablexUI

First of all you'll need the library sources.

<pre>
    <a href="https://github.com/RealyUniqueName/StablexUI" target="_blank">Get the latest version on GitHub</a>
</pre>

Take content of src/ folder to your project.
Then install Actuate if you still didn't installed it. Run in command line:

<pre>
    haxelib install actuate
</pre>

Now you need to add Actuate to .nmml file:

<pre>
    &lt;haxelib name="actuate" /&gt;
</pre>

At last, you need to initialize StablexUI before using it.
Here is a sample main class with StablexUI initialization:
(roll mouse pointer over underlined type to see full classpath, click to go to it's API)

<haxe>
/**
* Main class of an application
*/
class Test extends nme.display.Sprite{

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