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
import msignal.EventSignal;

/**
The XmlLoader is an extension of the HttpLoader responsible for loading 
Xml resources. If the format of the Xml file is incorrect the a failed event is 
dispatched indicting the nature of the fault.

Provides an optional callback <code>parseData</code> to validate/intercept the
parsed Xml object prior to triggering loaderComplete

<pre><code>

function execute()
{
	var loader:XmlLoader = new XmlLoader("http://localhost/data.xml");
	loader.parseData = customDataParser;
	loader.loaded.add(errorHandler).forType(LoaderEventType.Fail(null));
	loader.loaded.add(completedHandler).forType(LoaderEventType.complete);
	loader.load();
}

function customDataParser(xml:Xml):Xml
{
	for(element in xml.elements())
	{
		if(element.nodeName == "errorCode")
		{
			throw "XML Error " + element.nodeValue;
		}
		else if(element.nodeName == "payload")
		{
			return element;
		}
	}
	
	throw "Missing XML payload";
	return null;
}

function errorHandler(event:LoaderEvent)
{
	//error handling logic
}

function completedHandler(event:LoaderEvent)
{
	...
}
</code></pre>

*/

class XmlLoader extends HttpLoader<Xml>
{
	/**
	Optional method for post processing XML object before loaderComplete is triggered.
	This can be used to validate XML payload or extract a sub element to return
	as the content payload.
	
	@param raw xml object
	@returns the xml content to return on loaderComplete
	@throws any exception to trigger a Fail (exception will be wrapped in a LoaderErrorType.Data(e, raw))
	*/
	public var parseData:Xml->Xml;

	/**
	@param url  the url to load the resource from
	@param http optional Http instance to use for the load request
	*/
	public function new(?url:String, ?http:Http)
	{
		super(url, http);
	}

	override function httpData(data:String)
	{
		var xml:Xml = null;

		try
		{
			xml = Xml.parse(data);
		}
		catch (e:Dynamic)
		{
			loaderFail(Format(Std.string(e)));
			return;
		}

		if(parseData == null)
		{
			content = xml;
			loaderComplete();
			return;
		}

		try
		{
			content = parseData(xml);
			loaderComplete();
		}
		catch (loaderError:LoaderErrorType)
		{
			loaderFail(loaderError);
			return;
		}
		catch (e:Dynamic)
		{
			loaderFail(Data(Std.string(e), data));
			return;
		}

		
	}
}
