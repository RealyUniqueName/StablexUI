package mloader;

/**
	This class is what happens when you override things in the std library.
**/

class Http extends haxe.Http
{

	public function new(?url:String)
	{
		super(url);
	}

	#if !haxe3
	public var responseData(default, null) : Null<String>;
	#end

#if flash9
	var loader:flash.net.URLLoader;

	public function cancel()
	{
		if (loader != null)
		{
			loader.close();
			loader = null;
		}
	}

	#if haxe3
	override public function request(?post:Bool):Void
	#else
	override public function request(post:Bool):Void
	#end
	{
		var me = this;
		me.responseData = null;
		loader = new flash.net.URLLoader();
		loader.addEventListener( "complete", function(e) {
			me.responseData = loader.data;
			me.loader = null;
			me.onData(me.responseData);
		});
		loader.addEventListener( "httpStatus", function(e:flash.events.HTTPStatusEvent){
			// on Firefox 1.5, Flash calls onHTTPStatus with 0 (!??)
			if( e.status != 0 )
				me.onStatus( e.status );
		});
		loader.addEventListener( "ioError", function(e:flash.events.IOErrorEvent) {
			me.responseData = loader.data;
			me.loader = null;
			me.onError(e.text);
		});
		loader.addEventListener( "securityError", function(e:flash.events.SecurityErrorEvent){
			me.loader = null;
			me.onError(e.text);
		});

		// headers
		var param = false;
		var vars = new flash.net.URLVariables();
		for( k in params.keys() ){
			param = true;
			Reflect.setField(vars,k,params.get(k));
		}
		var small_url = url;
		if( param && !post ){
			var k = url.split("?");
			if( k.length > 1 ) {
				small_url = k.shift();
				vars.decode(k.join("?"));
			}
		}
		// Bug in flash player 9 ???
		var bug = small_url.split("xxx");

		var request = new flash.net.URLRequest( small_url );
		for( k in headers.keys() )
			request.requestHeaders.push( new flash.net.URLRequestHeader(k,headers.get(k)) );

		if( postData != null ) {
			request.data = postData;
			request.method = "POST";
		} else {
			request.data = vars;
			request.method = if( post ) "POST" else "GET";
		}

		try {
			loader.load( request );
		}catch( e : Dynamic ){
			me.loader = null;
			onError("Exception: "+Std.string(e));
		}
	}
#elseif js
	#if haxe3
	var loader:js.html.XMLHttpRequest;
	#else
	var loader:js.XMLHttpRequest;
	#end

	public function cancel()
	{
		if (loader != null)
		{
			loader.abort();
			loader = null;
		}
	}

	#if haxe3
	override public function request(?post:Bool):Void
	#else
	override public function request(post:Bool):Void
	#end
	{
		var me = this;
		me.responseData = null;
		#if haxe3
		var r = loader = js.Browser.createXMLHttpRequest();
		var onreadystatechange = function(_) {
		#else
		var r = loader = new js.XMLHttpRequest();
		var onreadystatechange = function() {
		#end
			if( r.readyState != 4 )
				return;
			var s = try r.status catch( e : Dynamic ) null;
			if( s == untyped __js__("undefined") )
				s = null;
			if( s != null )
				me.onStatus(s);
			if( s != null && s >= 200 && s < 400 ) {
				me.loader = null;
				me.onData(me.responseData = r.responseText);
			} else if ( s == null ) {
				me.loader = null;
				me.onError("Failed to connect or resolve host");
			} else switch( s ) {
			case 12029:
				me.loader = null;
				me.onError("Failed to connect to host");
			case 12007:
				me.loader = null;
				me.onError("Unknown host");
			default:
				me.responseData = r.responseText;
				me.loader = null;
				me.onError("Http Error #"+r.status);
			}
		};
		if( async )
			r.onreadystatechange = onreadystatechange;
		var uri = postData;
		if( uri != null )
			post = true;
		else for( p in params.keys() ) {
			if( uri == null )
				uri = "";
			else
				uri += "&";
			uri += StringTools.urlEncode(p)+"="+StringTools.urlEncode(params.get(p));
		}
		try {
			if( post )
				r.open("POST",url,async);
			else if( uri != null ) {
				var question = url.split("?").length <= 1;
				r.open("GET",url+(if( question ) "?" else "&")+uri,async);
				uri = null;
			} else
				r.open("GET",url,async);
		} catch( e : Dynamic ) {
			me.loader = null;
			onError(e.toString());
			return;
		}
		if( headers.get("Content-Type") == null && post && postData == null )
			r.setRequestHeader("Content-Type","application/x-www-form-urlencoded");

		for( h in headers.keys() )
			r.setRequestHeader(h,headers.get(h));
		r.send(uri);
		if( !async )
			#if haxe3
			onreadystatechange(null);
			#else
			onreadystatechange();
			#end
	}
#end
}