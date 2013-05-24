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

import msignal.Signal;
import msignal.EventSignal;
import mloader.Loader;

/**
The LoaderBase class is an abstract implementation of the Loader class.  
*/
class LoaderBase<T> implements Loader<T>
{
	/**
	The current url of the loader.
	*/
	public var url(default, set_url):String;

	/**
	If the url changes while loading, cancel the request.
	*/
	function set_url(value:String):String
	{
		if (value == url) return url;
		if (loading) cancel();
		return url = value;
	}

	/**
	The loaded content, only available after completed is dispatched.
	*/
	public var content(default, null):Null<T>;

	/**
	The current state of the loader: true if content is currently being loaded, 
	false if the loader has completed, failed, or not yet started.
	*/
	public var loading(default, null):Bool;

	/**
	The percentage of loading complete. Between 0 and 1.
	*/
	public var progress(default, null):Float;

	/**
	A signal dispatched when loading status changes. See LoaderEventType.
	*/
	public var loaded(default, null):EventSignal<Loader<T>, LoaderEventType>;

	/**
	@param url  the url to load the resource from
	*/
	public function new(?url:String)
	{
		this.loaded = new EventSignal<Loader<T>, LoaderEventType>(this);
		this.url = url;

		// set initial state
		progress = 0;
		loading = false;
	}

	/**
	Starts a load operation from the loaders url.
	
	If the loader is loading, the previous operation is cancelled before the new 
	operation starts. If no url has been set, and exception is thrown.
	*/
	public function load():Void
	{
		// if currently loading, return
		if (loading) return;

		// if no url, throw exception
		if (url == null) throw "No url defined for Loader";

		// update state
		loading = true;

		// dispatch started
		loaded.dispatchType(Start);
		
		// call implementation
		loaderLoad();
	}

	/**
	Cancels a load operation currently in progress for this loader instance.

	If the loader is not loading, this method has no effect. Progress is reset 
	to zero and a `cancelled` event is dispatched.
	*/
	public function cancel():Void
	{
		// if not loading, return
		if (!loading) return;
		loading = false;

		// call implementation
		loaderCancel();

		// reset state
		progress = 0;
		content = null;
		
		// dispatch event
		loaded.dispatchType(Cancel);
	}

	//-------------------------------------------------------------------------- private

	/**
	The abstract load implementation.
	*/
	function loaderLoad()
	{
		throw "missing implementation";
	}

	/**
	The abstract cancel implementation.
	*/
	function loaderCancel():Void
	{
		throw "missing implementation";
	}
	
	function loaderComplete()
	{
		if (!loading) return;

		// update progress
		progress = 1;

		// update state
		loading = false;
		
		// dispatch event
		loaded.dispatchType(Complete);
	}

	function loaderFail(error:LoaderErrorType)
	{
		if (!loading) return;
		loading = false;
		loaded.dispatchType(Fail(error));
	}
}
