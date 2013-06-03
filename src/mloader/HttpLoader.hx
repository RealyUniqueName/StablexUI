/*
Copyright (c) 2012 Massive Interactive

Permission is hereby granted, free of charge, to any person obtaining a copy of 
this software and associated documentation files (the "Software"), to deal in 
the Software without restriction, including without limitation the rights to 
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do 
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all 
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
SOFTWARE.
*/

package mloader;

import mloader.Loader;

#if haxe3
import haxe.ds.StringMap;
#else
private typedef StringMap<T> = Hash<T>;
#end

/**
The HttpLoader class is responsible for loading content over Http, falling back 
to file system access for local paths under Neko (as haxe.Http does not support 
file:/// urls). Data can also be posted to a url using the `send` method, which 
automatically detects content-type (unless you set a custom content-type header).
*/
class HttpLoader<T> extends LoaderBase<T>
{
	#if nme
	/**
	The URLLoader used to load content.
	*/
	public var loader: nme.net.URLLoader;

	/**
	The URLRequest to load.
	*/
	var urlRequest: nme.net.URLRequest;
	#else
	/**
	The http instance used to load the content.
	*/
	var http:Http;
	#end

	/**
	The headers to pass through with the http request.
	*/
	public var headers(default, null):StringMap<String>;

	/**
	Http status code of response.
	*/
	public var statusCode(default, null):Int;

	/**
	@param url  the url to load the resource from
	@param http optional Http instance to use for the load request
	*/
    #if nme
	function new(?url:String)
    #else
    function new(?url:String, ?http:Http)    
    #end
	{
		super(url);
		
		headers = new StringMap();

		#if nme
		urlRequest = new nme.net.URLRequest();
		loader = new nme.net.URLLoader();

		loader.addEventListener(nme.events.HTTPStatusEvent.HTTP_STATUS, loaderEvent);
		loader.addEventListener(nme.events.Event.COMPLETE, loaderEvent);
		loader.addEventListener(nme.events.IOErrorEvent.IO_ERROR, loaderEvent);
		loader.addEventListener(nme.events.SecurityErrorEvent.SECURITY_ERROR, loaderEvent);
		#else
		if (http == null) http = new Http("");

		this.http = http;
		http.onData = httpData;
		http.onError = httpError;
		http.onStatus = httpStatus;
		#end
	}
	
	#if (sys||neko||cpp)

	/**
	Local urls are loaded from the file system in neko or cpp.
	*/
	function loadFromFileSystem(url:String)
	{
		if (!sys.FileSystem.exists(url))
		{
			loaderFail(IO("Local file does not exist: " + url));
		}
		else
		{
			var contents = sys.io.File.getContent(url);
			httpData(contents);
		}
	}
	#end
	
	/**
	Configures and makes the http request. The send method can also pass 
	through data with the request. It also traps any security errors and 
	dispatches a failed signal.
	
	@param url The url to load.
	@param data Data to post to the url.
	*/
	public function send(data:Dynamic)
	{
		// if currently loading, cancel
		if (loading) cancel();

		// if no url, throw exception
		if (url == null) throw "No url defined for Loader";

		// update state
		loading = true;

		// dispatch started
		loaded.dispatchType(Start);

		// default content type
		var contentType = "application/octet-stream";
		
		if (Std.is(data, Xml))
		{
			// convert to string and send as application/xml
			data = Std.string(data);
			contentType = "application/xml";
		}
		else if (!Std.is(data, String))
		{
			// stringify and send as application/json
			data = haxe.Json.stringify(data);
			contentType = "application/json";
		}
		
		// only set content type if not already set
		if (!headers.exists("Content-Type"))
		{
			headers.set("Content-Type", contentType);
		}

		httpConfigure();
		addHeaders();

		#if nme
		urlRequest.url = url;
		urlRequest.method = nme.net.URLRequestMethod.POST;
		urlRequest.data = data;
		loader.load(urlRequest);
		#else
		http.url = url;
		http.setPostData(data);
		
		try
		{
			http.request(true);
		}
		catch (e:Dynamic)
		{
			// js can throw synchronous security error
			loaderFail(Security(Std.string(e)));
		}
		#else
		#end
	}

	//-------------------------------------------------------------------------- private
	
	override function loaderLoad()
	{
		httpConfigure();
		addHeaders();
		
		#if nme
		urlRequest.url = url;
		if (url.indexOf("http:") == 0 || url.indexOf("https:") == 0)
		{
			//loader.load(urlRequest);
			//this.loadFromFileSystem(url);
            loader.load(urlRequest);
		}
		else
		{
			var result = nme.Assets.getText(url);
			//haxe.Timer.delay(callback(httpData, result), 10);
            haxe.Timer.delay(httpData.bind(result), 10);
		}
		#else
		http.url = url;
		#if (sys||neko||cpp)
		if (url.indexOf("http:") == 0 || url.indexOf("https:") == 0)
		{
			http.request(false);
		}
		else
		{	
			this.loadFromFileSystem(url);
		}
		#else
		try
		{
			http.request(false);
		}
		catch (e:Dynamic)
		{
			// js can throw synchronous security error
			loaderFail(Security(Std.string(e)));
		}
		#end
		#end
	}
	
	override function loaderCancel():Void
	{
		#if nme
		try { loader.close(); } catch(e:Dynamic) {}
		#elseif !(cpp || neko || php)
		http.cancel();
		#end
	}

	function httpConfigure()
	{
		// abstract
	}
	
	function addHeaders()
	{
		#if nme
		var requestHeaders = [];
		for (name in headers.keys())
		{
			requestHeaders.push(new nme.net.URLRequestHeader(name, headers.get(name)));
		}
		urlRequest.requestHeaders = requestHeaders;
		#else
		for (name in headers.keys())
		{
			http.setHeader(name, headers.get(name));
		}
		#end
	}
	
	function httpData(data:String)
	{
		content = cast data;
		loaderComplete();
	}
	
	function httpStatus(status:Int)
	{
		statusCode = status;
	}
	
	function httpError(error:String)
	{
		loaderFail(IO(error));
	}
	
	function httpSecurityError(error:String)
	{
		loaderFail(Security(error));
	}

	#if nme

	function loaderEvent(e:Dynamic)
	{
		switch (e.type)
		{
			case nme.events.HTTPStatusEvent.HTTP_STATUS:
			httpStatus(e.status);
			
			case nme.events.Event.COMPLETE:
			httpData(Std.string(e.target.data));

			case nme.events.IOErrorEvent.IO_ERROR:
			httpError(Std.string(e));
			
			case nme.events.SecurityErrorEvent.SECURITY_ERROR:
			httpSecurityError(Std.string(e));

		}
	}

	#end
}
