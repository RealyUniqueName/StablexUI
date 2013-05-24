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

/**
The XmlObjectLoader loads an Xml resource of a specific format. Node names are 
mapped against actual class names so that the Xml resource is parsed directly 
into a typed object.
*/
class XmlObjectLoader<T> extends HttpLoader<T>
{
	/**
	The XmlObjectParser used to parse responses into objects.
	*/
	var parser:XmlObjectParser;

	/**
	@param url  the url to load the resource from
	@param parser An instance of the parser to use. If an instance is not
			passed through a new instance will be created.
	@param http optional Http instance to use for the load request
	*/
	public function new(?url:String, ?parser:XmlObjectParser, ?http:Http)
	{
		super(url, http);
		
		if (parser == null)
		{
			this.parser = new XmlObjectParser();
		}
		else
		{
			this.parser = parser;
		}
	}

	override function httpData(data:String)
	{
		try
		{
			var xml = Xml.parse(data);
			content = cast parser.parse(xml);
		}
		catch (e:Dynamic)
		{
			loaderFail(Format(Std.string(e)));
			return;
		}
		
		loaderComplete();
	}

	/**
	Maps an Xml node to a class.
	*/
	public function mapClass(nodeName:String, nodeClass:Class<Dynamic>)
	{
		parser.classMap.set(nodeName, nodeClass);
	}

	/**
	Maps an Xml node to another Xml node.
	*/
	public function mapNode(fromNodeName:String, toNodeName:String)
	{
		parser.nodeMap.set(fromNodeName, toNodeName);
	}
}
