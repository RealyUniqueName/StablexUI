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

#if js
/**
Loads an image at a defined url.
*/
#if haxe3
class ImageLoader extends LoaderBase<js.html.ImageElement>
#else
class ImageLoader extends LoaderBase<js.Dom.Image>
#end
{
	public function new(?url:String)
	{
		super(url);
	}
	
	override function loaderLoad()
	{
		#if haxe3
		content = cast js.Browser.document.createElement("img");
		#else
		content = cast js.Lib.document.createElement("img");
		#end
		content.onload = imageLoad;
		content.onerror = imageError;
		content.src = url;
	}

	override function loaderCancel():Void
	{
		content.src = "";
	}

	function imageLoad(event)
	{
		content.onload = null;
		content.onerror = null;
		loaderComplete();
	}

	function imageError(event)
	{
		content.onload = null;
		content.onerror = null;
		loaderFail(IO(Std.string(event)));
	}
}

#elseif (flash || nme )

import nme.display.BitmapData;

/**
Loads BitmapData from a defined url.
*/

class ImageLoader extends LoaderBase<BitmapData>
{
	var loader:nme.display.Loader;

	public function new(?url:String)
	{
		super(url);

		loader = new nme.display.Loader();

		var loaderInfo = loader.contentLoaderInfo;
		loaderInfo.addEventListener(nme.events.ProgressEvent.PROGRESS, loaderProgressed);
		loaderInfo.addEventListener(nme.events.Event.COMPLETE, loaderCompleted);
		loaderInfo.addEventListener(nme.events.IOErrorEvent.IO_ERROR, loaderErrored);
	}

	override function loaderLoad()
	{
		#if nme
		if (url.indexOf("http://") == 0 || url.indexOf("https://") == 0)
		{
			loader.load(new nme.net.URLRequest(url));
		}
		else
		{
			content = nme.installer.Assets.getBitmapData(url);
			loaderComplete();
		}
		#else
			loader.load(new nme.net.URLRequest(url));
		#end
	}

	override function loaderCancel()
	{
		#if !nme loader.close(); #end
	}
	
	function loaderProgressed(event)
	{
		progress = 0.0;

		if (event.bytesTotal > 0)
		{
			progress = event.bytesLoaded / event.bytesTotal;
		}

		loaded.dispatchType(Progress);
	}

	function loaderCompleted(event)
	{
		content = untyped loader.content.bitmapData;
		loaderComplete();
	}

	function loaderErrored(event)
	{
		loaderFail(IO(Std.string(event)));
	}
}

#else

/**
ImageLoading is not supported in neko.
*/
class ImageLoader extends LoaderBase<Dynamic>
{
	public function new(?url:String)
	{
		super(url);
		
		throw "mloader.ImageLoader is not implemented on this platform";
	}
}
#end
