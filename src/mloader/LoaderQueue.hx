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

typedef LoaderQueueEvent = Event<Loader<Array<Loader<Dynamic>>>, LoaderEventType>

/**
A FIFO queue of Loaders with optional priority ordering.

By default loaders are added to the back of the queue and will only begin 
processing once LoaderQueue.load() is called.

You can choose to provide a priority when adding a loader to the queue. Higher 
priorities get processed first. Priority 0 is the default.

If you wish loading to trigger as soon as a Loader is added, set 
LoaderQueue.autoLoad to true.

By default a maximum of eight loaders can be actively loading at one time 
within the queue. You can adjust this by setting the LoaderQueue.maxLoading
value.

By default failures will not be reported directly from the queue and all 
loaders will be processed until LoaderQueue.completed is dispatched.

If you wish for the queue to not proceed after a failure then set 
LoaderQueue.ignoreFailures to false. This will cause the LoaderQueue.failed 
signal to be dispatched when the first failure is detected. No more loaders 
after this failure will be processed and the queue will be cleared.
*/
class LoaderQueue implements Loader<Array<Loader<Dynamic>>>
{
	public var content(default, null):Array<Loader<Dynamic>>;

	/**
	The default value for maxLoading.
	*/
	public static inline var DEFAULT_MAX_LOADING:Int = 8;

	/**
	Indicates whether the queue is currently active.
	*/
	public var loading(default, null):Bool;

	/**
	Dispatched when the loading state of the queue changes.
	*/
	public var loaded(default, null):EventSignal<Loader<Array<Loader<Dynamic>>>, LoaderEventType>;

	/**
	Defines the maximum amount of concurrent Loaders. Must be greater than 0. 
	Default is 8.
	*/
	public var maxLoading:Int;

	/**
	An option to allow the queue to stop on first error or continue on 
	regardless. Default is true.
	*/
	public var ignoreFailures:Bool;

	/**
	Set to true if you want loading to initiate as soon as there are loaders 
	added to the queue.
	Default is false.
	*/
	public var autoLoad:Bool;

	/**
	The current size of the queue. Includes both active and pending Loaders.
	*/
	public var size(get_size, null):Int;
	function get_size() { return pendingQueue.length + activeLoaders.length; }

	/**
	The number of Loaders sitting in the queue waiting to start their loading.
	*/
	public var numPending(get_numPending, null):Int;
	function get_numPending() { return pendingQueue.length; }

	/**
	The number of loaders currently loading.
	*/
	public var numLoading(get_numLoading, null):Int;
	function get_numLoading() { return activeLoaders.length; }

	/**
	The number of loaders which have finished being processed.

	If ignoreFailures is true this count will also include any loaders which 
	failed to load.
	*/
	public var numLoaded(default, null):Int;

	/**
	The number of Loaders which have failed to load.
	*/
	public var numFailed(default, null):Int;

	/**
	The percentage of loaders completed. Between 0 and 1.
	*/
	public var progress(default, null):Float;

	/**
	This value is not used by the LoaderQueue. Added to adhere to the Loader 
	interface.
	*/
	public var url(default, set_url):String;
	function set_url(value:String):String { return value; }

	var pendingQueue:Array<PendingLoader>;
	var activeLoaders:Array<Loader<Dynamic>>;

	public function new()
	{
		maxLoading = DEFAULT_MAX_LOADING;
		loaded = new EventSignal<Loader<Array<Loader<Dynamic>>>, LoaderEventType>(this);

		loading = false;
		ignoreFailures = true;
		autoLoad = false;
		numLoaded = 0;
		numFailed = 0;
		pendingQueue = [];
		activeLoaders = [];
	}

	/**
	Add a loader to the back of the queue.
	*/
	public function add(loader:Loader<Dynamic>)
	{
		addWithPriority(loader, 0);
	}

	/**
	Add a loader to the queue with a priority to determine its placement.

	The standard priority is 0. Higher priorities are loaded first.
	*/
	public function addWithPriority(loader:Loader<Dynamic>, priority:Int)
	{
		pendingQueue.push({loader:loader, priority:priority});
		pendingQueue.sort(function(a, b) { return b.priority - a.priority; });
		
		if (autoLoad) load();
	}

	/**
	Remove a specific loader from the queue. If the loader is found in the 
	queue, and is active, then it will be cancelled.
	*/
	public function remove(loader:Loader<Dynamic>):Void
	{
		if (containsActiveLoader(loader))
		{
			removeActiveLoader(loader);
			loader.cancel();
			continueLoading();
		}
		else if (containsPendingLoader(loader))
		{
			removePendingLoader(loader);
		}
	}

	/**
	Starts loading the queue.
	*/
	public function load()
	{
		// if currently loading, return
		if (loading) return;

		// update state
		loading = true;
		numLoaded = numFailed = 0;

		// dispatch started
		loaded.dispatchType(Start);
		
		// start queue if there are pending, else complete
		if (pendingQueue.length > 0) continueLoading();
		else queueCompleted();
	}

	function loaderCompleted(loader:Loader<Dynamic>)
	{
		loader.loaded.remove(loaderLoaded);
		activeLoaders.remove(loader);
		numLoaded++;

		progress = numLoaded == 0 ? 0 : (numLoaded / (numLoaded + size));
		loaded.dispatchType(Progress);

		if (loading)
		{
			if (pendingQueue.length > 0) continueLoading();
			else if (activeLoaders.length == 0) queueCompleted();
		}
		else throw "should not be!";
	}

	function loaderFail(loader:Loader<Dynamic>, error:LoaderErrorType)
	{
		numFailed += 1;
		
		if (ignoreFailures)
		{
			loaderCompleted(loader);
		}
		else
		{
			loader.loaded.remove(loaderLoaded);
			activeLoaders.remove(loader);

			loaded.dispatchType(Fail(error));
			loading = false;
		}
	}

	/**
	Load next while there are pending loaders and we are not at maxLoading.
	*/
	function continueLoading()
	{
		while (pendingQueue.length > 0 && activeLoaders.length < maxLoading)
		{
			var info = pendingQueue.shift();
			var loader = info.loader;

			loader.loaded.add(loaderLoaded);
			activeLoaders.push(loader);

			loader.load();
		}
	}

	/**
	Called when the queue completes loading.
	*/
	function queueCompleted()
	{
		loaded.dispatchType(Complete);
		loading = false;
	}

	/**
	Cancels all active loaders in the queue. Any loaders which are not active 
	are discarded.
	*/
	public function cancel():Void
	{
		while (activeLoaders.length > 0)
		{
			var loader = activeLoaders.pop();
			loader.loaded.remove(loaderLoaded);
			loader.cancel();
		}

		loading = false;
		pendingQueue = [];
		loaded.dispatchType(Cancel);
	}

	/**
	Called when an active loader dispatches a LoaderEventType.
	*/
	function loaderLoaded(event:LoaderEvent<Dynamic>)
	{
		var loader = event.target;
		switch (event.type)
		{
			case Complete, Cancel: loaderCompleted(loader);
			case Fail(e): loaderFail(loader, e);
			default:
		}
	}

	function containsActiveLoader(loader:Loader<Dynamic>)
	{
		for (active in activeLoaders)
			if (active == loader)
				return true;
		return false;
	}

	function containsPendingLoader(loader:Loader<Dynamic>)
	{
		for (pending in pendingQueue)
			if (pending.loader == loader)
				return true;
		return false;
	}

	function removeActiveLoader(loader:Loader<Dynamic>)
	{
		var i = activeLoaders.length;
		while (i-- > 0)
		{
			if (activeLoaders[i] == loader)
			{
				loader.loaded.remove(loaderLoaded);
				activeLoaders.splice(i, 1);

				// no break as could be added more than once
			}
		}
	}

	function removePendingLoader(loader:Loader<Dynamic>)
	{
		var i = pendingQueue.length;
		while (i-- > 0)
			if (pendingQueue[i].loader == loader)
				pendingQueue.splice(i, 1);
	}
}

private typedef PendingLoader =
{
	var loader:Loader<Dynamic>;
	var priority:Int;
}
