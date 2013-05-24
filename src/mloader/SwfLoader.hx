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

#if flash

import mloader.Loader;
import msignal.EventSignal;

/**
The SWFLoader class loads an SWF file. It also raises an IO error if the
SWF file fails to load.
*/
class SwfLoader extends LoaderBase<flash.display.DisplayObject>
{
	var loader:flash.display.Loader;

	public function new(?url)
	{
		super(url);
		
		loader = new flash.display.Loader();

		var loaderInfo = loader.contentLoaderInfo;
		loaderInfo.addEventListener(flash.events.ProgressEvent.PROGRESS, loadProgress);
		loaderInfo.addEventListener(flash.events.Event.COMPLETE, loadComplete);
		loaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, loadError);
	}
	
	override function loaderLoad()
	{
		loader.load(new flash.net.URLRequest(url), 
			new flash.system.LoaderContext(true, flash.system.ApplicationDomain.currentDomain));
	}

	override public function loaderCancel()
	{
		loader.close();
	}
	
	function loadProgress(event)
	{
		progress = 0.0;

		if (event.bytesTotal > 0)
		{
			progress = event.bytesLoaded / event.bytesTotal;
		}

		loaded.dispatchType(Progress);
	}

	function loadComplete(event)
	{
		content = loader.content;
		loaderComplete();
	}

	function loadError(event)
	{
		loaderFail(IO(Std.string(event)));
	}
}

#else

class SwfLoader extends LoaderBase<Dynamic>
{
	public function new(?url:String)
	{
		super(url);

		throw "mloader.SWFLoader is not implemented on this platform";
	}
}

#end
