package ;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import ru.stablex.ui.UIBuilder;
import cocktail.api.CocktailView;


/**
* Simple demo project for StablexUI
*/
class Main extends ru.stablex.ui.widgets.Widget{

    /**
    * Enrty point after StablexUI was initialized
    *
    */
    static public function main () : Void{

        Lib.current.stage.align     = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        //instantiate xml-based class
        //var w = UIBuilder.create(Custom);
        //trace( Type.typeof(w.box) ); //ru.stablex.ui.widgets.HBox
        //trace( Type.typeof(w.btn) ); //ru.stablex.ui.widgets.Button
        //w.free();

        //Create our UI
		//var cocktailView = new CocktailView();
		//cocktailView.loadURL("assets/index.html");
		//cocktailView.viewport = { 
		//		x:229,
		//		y:200,
		//		width:300,
		//		height:200
		//		};
		//flash.Lib.current.addChild(cocktailView.root);
		//cocktail.Lib.init(cocktailView.document);
        Lib.current.addChild( UIBuilder.buildFn('ui/index.xml')() );
    }//function main()


}//class Main


