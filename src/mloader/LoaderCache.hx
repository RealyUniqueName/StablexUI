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

#if haxe3
import haxe.ds.StringMap;
#else
private typedef StringMap<T> = Hash<T>;
#end

/**
The LoadCache class caches any request which has it's base type of Loader. It
also stores reference to items which are currently still being loaded. 
*/
class LoaderCache
{
	/**
	Loaders currently being loaded by the cache, indexed by url.
	*/
	var loadingLoaders:StringMap<Loader<Dynamic>>;

	/**
	Loaders that are waiting for a loading loader to complete, indexed by url.
	*/
	var waitingLoaders:StringMap<Array<Loader<Dynamic>>>;

	/**
	A cache of succefully loaded Loader.content, index by url.
	*/
	var cache:StringMap<Dynamic>;

	public function new()
	{
		loadingLoaders = new StringMap();
		waitingLoaders = new StringMap();
		cache = new StringMap();
	}

	/**
	Request the LoaderCache to load a loader. If a loader with the same url has 
	previously been loaded using the cache, we check if it completed. If it did, 
	we complete the new loader with the cached content. If it is still loading, 
	the loader is placed in a queue, and completed when the loading loader 
	completes.
	*/
	public function load(loader:Loader<Dynamic>)
	{
		if (cache.exists(loader.url))
		{
			// if the url has been cached, complete with the cached content
			untyped loader.content = cache.get(loader.url);
			untyped loader.progress = 1;
			loader.loaded.dispatchType(Complete);
		}
		else if (loadingLoaders.exists(loader.url) && loadingLoaders.get(loader.url) != loader)
		{
			// if the url is currently loading, add the loader to the waiting hash
			addWaiting(loader);
		}
		else
		{
			// otherwise add the loader to the loading hash, and start loading
			loadingLoaders.set(loader.url, loader);
			loader.loaded.add(loaderLoaded);
			loader.load();
		}
	}

	/**
	Clears the cache. Currently loading loaders will still be cached when they 
	complete. To cancel all current loaders, call cancel();
	*/
	public function clear()
	{
		cache = new StringMap();
	}

	/**
	Cancels any active or waiting loaders being managed by the cache.
	*/
	public function cancel()
	{
		// cancel waiting loaders
		for (waiting in waitingLoaders)
		{
			for (loader in waiting) loader.cancel();
		}

		// cancel loading loaders
		for (loader in loadingLoaders) loader.cancel();
	}

	//-------------------------------------------------------------------------- private

	/**
	If a Loader is requested to be loaded, and there is already an active Loader 
	with the same url, then we store this Loader in a cache until the active 
	one has completed. At that point we'll remove this Loader from cache and 
	dispatch its completed event too, setting it with a copy of the loaded 
	content before we do so.
	*/
	function addWaiting(loader:Loader<Dynamic>)
	{
		// prevents users from loading
		untyped loader.loading = true;

		var waiting:Array<Loader<Dynamic>>;

		if (waitingLoaders.exists(loader.url))
		{
			waiting = waitingLoaders.get(loader.url);
		}
		else
		{
			waiting = [];
			waitingLoaders.set(loader.url, waiting);
		}

		waiting.push(loader);
	}

	/**
	Called when an active loader or dispatches a LoaderEventType.
	*/
	function loaderLoaded(event:LoaderEvent<Dynamic>)
	{
		var loader = event.target;

		switch (event.type)
		{
			case Complete: loaderCompleted(loader);
			case Cancel: loaderCancelled(loader);
			case Fail(e): loaderFail(loader, e);
			default:
		}
	}

	function loaderCompleted(loader:Loader<Dynamic>)
	{
		loader.loaded.remove(loaderLoaded);
		loadingLoaders.remove(loader.url);
		cache.set(loader.url, loader.content);

		if (waitingLoaders.exists(loader.url))
		{
			for (waiting in waitingLoaders.get(loader.url))
			{
				// if user has cancelled loader, don't complete it
				if (!waiting.loading) continue;

				// update loader state
				untyped waiting.loading = false;
				untyped waiting.content = loader.content;
				untyped waiting.progress = 1;

				// dispatch completed
				waiting.loaded.dispatchType(Complete);
			}

			waitingLoaders.remove(loader.url);
		}
	}

	function loaderFail(loader:Loader<Dynamic>, error:LoaderErrorType)
	{
		// remove loading loader
		loader.loaded.remove(loaderLoaded);
		loadingLoaders.remove(loader.url);

		if (waitingLoaders.exists(loader.url))
		{
			for (waiting in waitingLoaders.get(loader.url))
			{
				// if user has cancelled loader, don't fail it
				if (!waiting.loading) continue;

				// update loader state
				untyped waiting.loading = false;

				// dispatch error
				waiting.loaded.dispatchType(Fail(error));
			}

			waitingLoaders.remove(loader.url);
		}
	}

	/**
	If a loading loader is cancelled, we stop listening to it and check if there 
	are any waiting loaders for that url. If there are, we load the first one.
	*/
	function loaderCancelled(loader:Loader<Dynamic>)
	{
		// remove loading loader
		loader.loaded.remove(loaderLoaded);
		loadingLoaders.remove(loader.url);

		if (waitingLoaders.exists(loader.url))
		{
			var loader = waitingLoaders.get(loader.url).shift();
			if (loader != null)
			{
				// need to reset loading state to it will load
				untyped loader.loading = false;
				load(loader);
			}
		}
	}
}
