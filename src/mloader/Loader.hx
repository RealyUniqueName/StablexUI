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

/**
The type definition for a loader event.
*/
typedef LoaderEvent<T> = Event<Loader<T>, LoaderEventType>;

/**
The Loader class defines an API for loading url's. Loaders dispatch events 
when their loading state changes.
*/
interface Loader<T>
{
	/**
	The url to load the resource from.
	*/
	var url(default, set_url):String;

	/**
	The percentage of loading complete. Between 0 and 1.
	*/
	var progress(default, null):Float;

	/**
	The loaded content, only available after completed is dispatched.
	*/
	var content(default, null):Null<T>;

	/**
	The current state of the loader: true if it is loading, false if it has 
	completed, failed, or not started.
	*/
	var loading(default, null):Bool;

	/**
	A signal dispatched when loading status changes. See LoaderEventType.
	*/
	var loaded(default, null):EventSignal<Loader<T>, LoaderEventType>;
	
	/**
	Starts a load operation from the loaders url.
	
	If the loader is loading, the previous operation is cancelled before the new 
	operation starts. If no url has been set, and exception is thrown.
	*/
	function load():Void;

	/**
	Cancels a load operation currently in progress for this loader instance.

	If the loader is not loading, this method has no effect. Progress is reset 
	to zero and a `cancelled` event is dispatched.
	*/
	function cancel():Void;
}

/**
Events indicating changes in the state of the loader.
*/
enum LoaderEventType
{
	/**
	Dispatched when the loading operation commences.
	*/
	Start;

	/**
	Dispatched when the loading operation is cancelled before completion.
	*/
	Cancel;

	/**
	Dispatched when the loading operation progresses.
	*/
	Progress;

	/**
	Dispatched when the loading operation completes.
	*/
	Complete;

	/**
	Dispatched when the loading operation fails due to an error.
	*/
	Fail(error:LoaderErrorType);
}

enum LoaderErrorType
{
	/**
	A fatal error terminates the download.
	*/
	IO(info:String);

	/**
	An error indicating the loader attempted to perform an insecure operation. 
	The definition of insecure differs between platforms, but generally 
	indicates an attempt to load a resource outside of the security sandbox.
	*/
	Security(info:String);

	/**
	An error indicating the loaded resource was in an unexpected format.
	*/
	Format(info:String);

	/**
	An error that indicates the load operation failed, but properly formatted 
	data was received. For example: a service might return a non 200 Http 
	status, but also data indicating the nature of the failiure.
	*/
	Data(info:String, data:Dynamic);
}
