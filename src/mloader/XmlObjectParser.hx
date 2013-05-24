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
import haxe.ds.IntMap;
#else
private typedef StringMap<T> = Hash<T>;
private typedef IntMap<T> = IntHash<T>;
#end

/**
Decoder is a utility class for automating the deserialization of raw xml into
data objects based on individual node names
By default, nodes matching standard HaXe types are converted directly. This includes:
<ul>
<li>Null</li>
<li>Bool</li>
<li>Int and Float</li>
<li>String</li>
<li>Xml</li>
<li>Array</li>
<li>Hash and IntHash</li>
<li>Object</li>
</ul>

Basic example:
<pre>
var decoder = new Decoder();
var str:String = decoder.parse("&lt;String&gt;hello world&lt;/String&gt;");
var array:Array&lt;Int&gt; = decoder.parse("&lt;Array&gt;&lt;Int&gt;2</Int&gt;&lt;/Array&gt;");
decoder.parse("&lt;Hash&gt;&lt;String id='foo'&gt;bar&lt;/String&gt;&lt;Object&gt;&lt;id&gt;bing&lt;/id&gt;&lt;test&gt;baz&lt;/test&gt;&lt;/Object&gt;&lt;/Hash&gt;");
</pre>

Attributes are automatically mapped as properties of an object based on their
likely value type:
<pre>
var decoder = new Decoder();
var result = decoder.parse("&lt;Object integer='12' hex='0xFF' float='1.3' boolTrue='true' boolFalse='false' array='[1,2]' object='{a:2}'/&gt;");
</pre>

To reduce the verbosity of xml, specific node names can be mapped to an existing
data type directly
<pre>
var decoder = new Decoder();
decoder.nodeMap.set("widget", "Int");
var result = decoder.parse("&lt;Object&gt;&lt;widget&gt;5&lt;/widget&gt;&lt;/Object&gt;"");
var widget:Int = result.widget;
</pre>

Lastly, a custom class can be registered as the object type for a specific node name:
<pre>
var decoder = new Decoder();
decoder.classMap.set("widget", my.examples.Widget);
var result = decoder.parse("&lt;Object&gt;&lt;widget/&gt;&lt;/Object&gt;");
var widget:Widget = result.widget;
</pre>
*/
class XmlObjectParser
{
	public var classMap(default, null):StringMap<Class<Dynamic>>;
	public var nodeMap(default, null):StringMap<String>;
	
	public function new()
	{
		classMap = new StringMap<Class<Dynamic>>();
		nodeMap = new StringMap<String>();
	}
	
	/**
	Parses a raw xml object into an object 

	@param node 	the original xml to deserialise
	@return a deserialised object
	*/
	public function parse(node:Xml):Dynamic
	{
		try
		{
			if (node.nodeType == Xml.Document)
			{
				node = node.firstElement();
			}
			
			return parseNode(node);
		}
		catch(e:Dynamic)
		{
			throw "Error parsing xml " + e.toString();
		}
	}
	
	/**
	Converts an individual node into an object based on the nodeName

	@param node 	the original xml to parse
	@return a deserialised object
	*/
	public function parseNode(node:Xml):Dynamic
	{
		var nodeName = node.nodeName;
		
		while (nodeMap.exists(nodeName))
		{
			nodeName = nodeMap.get(nodeName);
		}
		
		switch (nodeName)
		{
			case "Null":
				return null;
				
			case "Bool", "Int", "Float", "String":
				return parseString(StringTools.trim(node.firstChild().nodeValue));
				
			case "Xml":
				return Xml.parse(node.firstElement().toString());
			
			case "Array":
				return parseArray(node);
				
			case "Hash", "StringMap":
				return parseHash(node);
			
			case "IntHash", "IntMap":
				return parseIntHash(node);

			case "Object":
				var object = {};
				processAttributes(node, object);
				processElements(node, object);
				return object;
			
			default:
				if (!classMap.exists(nodeName)) return null;
				var theClass = classMap.get(nodeName);
				var instance = Type.createInstance(theClass, []);
				processAttributes(node, instance);
				processElements(node, instance);
				return instance;
		}
	}
	
	function processAttributes(node:Xml, instance:Dynamic)
	{
		for (attribute in node.attributes())
		{
			setStringProperty(instance, attribute, node.get(attribute));
		}
	}
	
	function processElements(node:Xml, instance:Dynamic)
	{
		for (element in node.elements())
		{
			var nodeName = element.nodeName;
			var mappedName = nodeName;
			
			while (nodeMap.exists(mappedName))
			{
				mappedName = nodeMap.get(mappedName);
			}
			
			if (mappedName != nodeName)
			{
				setProperty(instance, nodeName, parseNode(element));
			}
			else if (classMap.exists(nodeName))
			{
			
				var property = nodeName.charAt(0).toLowerCase() + nodeName.substr(1, nodeName.length);
				setProperty(instance, property, parseNode(element));
			}
			else if (element.firstElement() == null)
			{
				if (element.firstChild() != null)
				{
					setStringProperty(instance, nodeName, element.firstChild().nodeValue);
				}
				else
				{
					setProperty(instance, nodeName, null);
				}
			}
			else
			{
				var elements = element.elements();
				var first = elements.next();
				
				if (elements.hasNext())
				{
					var children = [];
					processElements(element, children);
					setProperty(instance, nodeName, children);
				}
				else
				{
					setProperty(instance, nodeName, parseNode(first));
				}
			}
		}
	}
	
	function parseString(string:String):Dynamic
	{
		if (string == null)
		{
			return null;
		}

		if (string.substr(0, 2) == "0x")
		{
			return Std.parseInt(string);
		}
		
		var float = Std.parseFloat(string);
		
		if (Std.string(float) == string)
		{
			return float;
		}
		
		if (string == "true" || string == "false")
		{
			return (string == "true");
		}
		
		var arrayString = extractPattern(string, "[", "]");
		
		if (arrayString != null)
		{
			var result = arrayString.split(",");
			
			for (i in 0...result.length)
			{
				var value = result[i];
				result[i] = parseString(value);
			}
			
			return result;
		}
		
		var objectString = extractPattern(string, "{", "}");
		
		if (objectString != null)
		{
			var result = {};
			var pairs = objectString.split(",");
			
			for (pair in pairs)
			{
				var parts = pair.split(":");
				Reflect.setField(result, parts[0], parseString(parts[1]));
			}
			
			return result;
		}
		
		return string;
	}
	
	function parseArray(node:Xml):Dynamic
	{
		var array = [];
		
		for (element in node.elements())
		{
			array.push(parseNode(element));
		}
		
		return array;
	}
	
	function parseHash(node:Xml):Dynamic
	{
		var hash:StringMap<Dynamic> = new StringMap();
		for (element in node.elements()) 
		{
			var id = getIdFromNode(element);
			hash.set(id, parseNode(element));
		}
		return hash;
	}

	function parseIntHash(node:Xml):Dynamic
	{
		var hash:IntMap<Dynamic> = new IntMap();
		for (element in node.elements()) 
		{
			var id = Std.parseInt(getIdFromNode(element));
			if(Math.isNaN(id) || id == null) id = -1;
			hash.set(id, parseNode(element));
		}
		return hash;
	}

	/**
	* @return value of id attribute or child element for hash/intHash
	* e.g. <node id="foo" />
	* e.g. <node><id>foo</id></node>
	**/
	function getIdFromNode(node:Xml):String
	{
		if (node.exists("id")) return Std.string(node.get("id"));

		for (element in node.elementsNamed("id"))
		{
			return Std.string(element.firstChild());
		}

		return null;
	}
	
	function setStringProperty(object:Dynamic, property:String, value:String)
	{
		setProperty(object, property, parseString(value));
	}
	
	function setProperty(object:Dynamic, property:String, value:Dynamic)
	{
		Reflect.setProperty(object, property, value);
	}
	
	function extractPattern(string:String, startToken:String, endToken:String):String
	{
		if (string.charAt(0) == startToken)
		{
			if (string.charAt(string.length - 1) == endToken)
			{
				return string.substr(1, string.length - 2);
			}
		}
		
		return null;
	}
}
