package ru.stablex.ui.events;

import flash.events.Event;
/**
 * ...
 * @author Darcy.G
 */

class URLLoaderEvent extends Event {
    static public inline var LOADER_READY    = 'loaderReady';
    static public inline var WEBGET_START    = 'webGetStart';
    static public inline var WEBGET_CANCEL   = 'webGetCancel';
    static public inline var WEBGET_PROGRESS = 'webGetProgress';
    static public inline var WEBGET_COMPLETE = 'webGetComplete';
    static public inline var WEBGET_FAIL     = 'webGetFail';
}
