package ru.stablex.ui.widgets;

import nme.display.DisplayObject;
import cocktail.api.CocktailView;
import nme.Lib;
import ru.stablex.ui.events.WidgetEvent;
//import js.Lib;
/**
 * ...
 * @author 123
 */
class WebView extends Widget{

    private var cv:CocktailView;
	
	//private var resizeCallbacks : List < Void->Void > ;
    
    public var url(get_url, set_url) : String;
    private var _url : String = "assets/blank.html";
    
    private var _inited : Bool = false;

	public function new() 
	{
		super();
		//resizeCallbacks = new List();
		
		this.addEventListener( nme.events.Event.ADDED_TO_STAGE, onAdded );
	}
	
    /**
    * Refresh widgets. Re-apply skin box and realigns children
    *
    */
    override public function refresh() : Void {	
        super.refresh();
    }//function refresh()	
	
    /**
    * Display initial value on create
    *
    */
    //override public function onCreate() : Void {
    //    super.onCreate();
    //}//function onCreate()

    //override public function free(recursive:Bool = true) : Void {
    //    super.free(recursive);
    //}//function free()
	
	function onAdded(_)
	{
		this.removeEventListener(nme.events.Event.ADDED_TO_STAGE, onAdded);
		//this.addEventListener(nme.events.Event.RESIZE, _resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
		this.dispatchEvent(new WidgetEvent(WidgetEvent.RESIZE));
	}
	
	override public function onResize() 
	{
		//reset();
		if (!_inited) init();
		// else (resize or orientation change)
		//for( cb in resizeCallbacks )
		//	cb();
		//*	
		//	trace("onResize:"+this.x + " " + this.y + " " + this.w + " " + this.h);
        this.cv.viewport = { 
            x:0,
            y:0,
            width:Std.int(this.w),
            height:Std.int(this.h)
        };
		//*/	
		super.onResize();
	}
	
	function init()
	{
		this._inited = true;
		initCocktailView();
	}
	
	//function registerResizable( cb : Void->Void )
	//{
	//	resizeCallbacks.add( cb );
	//	return cb;
	//}

	/**
	 * build cocktail interface
	 */
	function initCocktailView()
	{
		//build a cocktail webview
		this.cv = new CocktailView();
		//function updateViewportPosition()
		//{
		//	//place the webview in the flash/NME app
		//	trace(this.x + " " + this.y + " " + this.w + " " + this.h);
		//	this.cv.viewport = { 
		//		x:Std.int(this.x),
		//		y:Std.int(this.y),
		//		width:Std.int(this.w),
		//		height:Std.int(this.h)
		//	};
		//}
		//registerResizable( updateViewportPosition )();
		
		//use an external html for the document
        if (this._url != "")
        {
            this.cv.loadURL(this._url);
        }
        this.cv.viewport = { 
            x:0,
            y:0,
            width:Std.int(this.w),
            height:Std.int(this.h)
        };	
		//wait for document ready
		//cv.window.onload = function(e) { 
			
		//	var document = cv.document;
			
			//access to DOM
			//var button = document.getElementById("button");
			//button.onclick = function(e) {
			//	//toggle flash interface visibility
			//	mc.visible = !mc.visible;
			//}
			
			//attach cocktail root to native flash root
			//this.addChildAt(cv.root,1);
		//};
		//Lib.current.addChild(cv.root);
		this.addChild(this.cv.root);
		cocktail.Lib.init(this.cv.document);
	}	
	
    private function set_url(url:String) : String {
        if (url == "") this._url = "assets/blank.html";
        else this._url = url;
        if (this._inited) {
            this.removeChild(this.cv.root);
            this.cv = new CocktailView();
            this.cv.loadURL(this._url);
             this.cv.viewport = { 
                x:0,
                y:0,
                width:Std.int(this.w),
                height:Std.int(this.h)
            };
            this.addChild(this.cv.root);
            cocktail.Lib.init(this.cv.document);
        }
        return this._url;
    }
    
    private function get_url() : String {
        return this._url;
    }
}