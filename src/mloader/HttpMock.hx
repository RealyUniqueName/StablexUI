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

#if haxe3
import haxe.ds.StringMap;
#else
private typedef StringMap<T> = Hash<T>;
#end

/**
A utility class for moccking Http responses.
*/
class HttpMock extends Http
{
	public var publicHeaders:StringMap<String>;

	var responders:StringMap<HttpResponder>;
	
	public function new(url:String)
	{
		super(url);
		responders = new StringMap<HttpResponder>();
		publicHeaders = headers;
	}

	#if haxe3
	override public function request(?post:Bool):Void
	#else
	override public function request(post:Bool):Void
	#end
	{
		var responder = if (responders.exists(url)) responders.get(url);
		else new HttpResponder().with(Error("Http Error #404"));

		if (responder.delay == 0)
		{
			respond(responder.response);
		}
		else
		{
			#if (flash||js||nme)
				#if haxe3
				haxe.Timer.delay(respond.bind(responder.response), responder.delay);
				#else
				haxe.Timer.delay(callback(respond, responder.response), responder.delay);
				#end
			#else
				respond(responder.response);
			#end
		}
	}

	function respond(type:HttpResponse)
	{
		switch (type)
		{
			case Exception(message):
				throw message;
			case Data(data):
				if (onData != null) onData(data);
			case Status(status):
				if (onStatus != null) onStatus(status);
			case Error(error):
				if (onError != null) onError(error);
		}
	}

	public function getPostData():String
	{
		return postData;
	}

	public function respondTo(url:String):HttpResponder
	{
		var responder = new HttpResponder();
		responders.set(url, responder);
		return responder;
	}
}

private class HttpResponder
{
	public var delay(default, null):Int;
	public var response(default, null):HttpResponse;

	public function new()
	{
		delay = 0;
		response = Data("");
	}

	public function afterDelay(delay:Int):HttpResponder
	{
		this.delay = delay;
		return this;
	}

	public function with(response:HttpResponse):HttpResponder
	{
		this.response = response;
		return this;
	}
}

private enum HttpResponse
{
	Data(data:String);
	Status(status:Int);
	Error(error:String);
	Exception(message:String);
}
