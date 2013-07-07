package ru.stablex.ui.widgets;


import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.geom.Rectangle;
import ru.stablex.TweenSprite;
import ru.stablex.ui.events.WidgetEvent;
import ru.stablex.ui.layouts.Layout;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.skins.Skin;


/**
* Basic widget
*/

class Widget extends TweenSprite{
    @:noCompletion static private inline var _X_USE_LEFT          = 1;
    @:noCompletion static private inline var _X_USE_LEFT_PERCENT  = 2;
    @:noCompletion static private inline var _X_USE_RIGHT         = 3;
    @:noCompletion static private inline var _X_USE_RIGHT_PERCENT = 4;

    @:noCompletion static private inline var _Y_USE_TOP            = 5;
    @:noCompletion static private inline var _Y_USE_TOP_PERCENT    = 6;
    @:noCompletion static private inline var _Y_USE_BOTTOM         = 7;
    @:noCompletion static private inline var _Y_USE_BOTTOM_PERCENT = 8;


    //Name of section in default settings for this type of widgets
    public var defaults : String = 'Default';

    //Wether properties were applied to widget on creation by <type>UIBuilder</type> (`.onInitialize()` was called)
    public var initialized : Bool = false;
    //Wether this widget creation by <type>UIBuilder</type> is finished (`.onCreate()` was called)
    public var created : Bool = false;
    //If this is true, than `.free` was called
    public var destroyed : Bool = false;

    //Widget width in pixels
    public var w (get_w,set_w)   : Float;
    //Widget width in % of parent's width
    public var widthPt (get_widthPt,set_widthPt) : Float;
    @:noCompletion private var _width                   : Float = 0;
    @:noCompletion private var _widthPercent            : Float = 0;
    @:noCompletion private var _widthUsePercent         : Bool = false;

    //Widget height height in pixels
    public var h (get_h,set_h)  : Float;
    //Widget height in % of parent's height
    public var heightPt (get_heightPt,set_heightPt) : Float;
    @:noCompletion private var _height                   : Float = 0;
    @:noCompletion private var _heightPercent            : Float = 0;
    @:noCompletion private var _heightUsePercent         : Bool = false;

    //do not adjust widget position and do not fire event on setting widget size
    @:noCompletion private var _silentResize : Bool = false;
    //whether resizing is in progress
    @:noCompletion private var _resizing : Bool = false;

    //Widget id (unique)
    public var id (default, set_id) : String;

    //position this widget by left border in pixels
    public var left (get_left,set_left) : Float;
    //position this widget by left border in % of parent's width
    public var leftPt (get_leftPt,set_leftPt) : Float;
    @:noCompletion private var _left                   : Float = 0;
    @:noCompletion private var _leftPercent            : Float = 0;

    //position this widget by right border in pixels
    public var right (get_right,set_right) : Float;
    //position this widget by right border in % of parent's width
    public var rightPt (get_rightPt,set_rightPt)   : Float;
    @:noCompletion private var _right                     : Float = 0;
    @:noCompletion private var _rightPercent              : Float = 0;

    //Wich one to use: left, right, leftPercent or rightPercent
    @:noCompletion private var _xUse : Int = _X_USE_LEFT;
    @:noCompletion private var _yUse : Int = _Y_USE_TOP;

    //Get parent if it is widget, returns null otherwise
    public var wparent (get_wparent,never) : Widget;

    //position this widget by top border in pixels
    public var top (get_top,set_top)   : Float;
    //position this widget by top border in % of parent's height
    public var topPt (get_topPt,set_topPt) : Float;
    @:noCompletion private var _top                   : Float = 0;
    @:noCompletion private var _topPercent            : Float = 0;

    //position this widget by bottom border in pixels
    public var bottom (get_bottom,set_bottom) : Float;
    //position this widget by bottom border in % of parent's height
    public var bottomPt (get_bottomPt,set_bottomPt)     : Float;
    @:noCompletion private var _bottom                       : Float = 0;
    @:noCompletion private var _bottomPercent                : Float = 0;

    //Skin processor (see ru.stablex.ui.skins package)
    public var skin : Skin;
    /**
    * Flag for <type>UIBuilder</type>. Do not modify this.
    * @private
    */
    @:noCompletion public var _skinQueued : Bool = false;
    //skin name to use. One of registered with <type>ru.stablex.ui.UIBuilder</type>.regSkins()
    public var skinName (default,set_skinName) : String;
    //whether widget content out of widgt bounds is visible
    public var overflow (default,set_overflow) : Bool = true;

    //Tooltip for this widget. See <type>Tip</type> to know how to use it.
    public var tip (default,set_tip) : Tip;

    //layout manager
    public var layout : Layout;


/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/



/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/

    /**
    * Constructor
    *
    */
    public function new() : Void {
        super();

        this.id = UIBuilder.createId();
    }//function new()


    /**
    * This method is called automatically by <type>UIBuilder</type> after properties
    * were applied to widget and before creating children.
    * @private
    */
    @:noCompletion public function _onInitialize() : Void {
        this.onInitialize();
        this.initialized = true;
    }//function _onInitialize()


    /**
    * Override this method to handle initialiazation.
    * This method is called automatically by <type>UIBuilder</type> after properties
    * were applied to widget and before creating children.
    */
    public function onInitialize() : Void {
    }//function onInitialize()


    /**
    * This method is called automatically after widget was created
    * by <type>UIBuilder</type>.buildFn() or <type>UIBuilder</type>.create()
    * @private
    * @dispatch <type>ru.stablex.ui.events.WidgetEvent</type>.CREATE
    */
    @:final @:noCompletion public function _onCreate () : Void{
        //remove event listeners used for creation
        this.clearEvent(WidgetEvent.INITIAL_RESIZE);

        this.onCreate();

        //refresh widget
        this.refresh();

        this.created = true;

        this.dispatchEvent(new WidgetEvent(WidgetEvent.CREATE));
    }//function _onCreate()


    /**
    * Override this method to handle widget creation.
    * This method is called automatically after widget was created
    * by <type>UIBuilder</type>.buildFn() or <type>UIBuilder</type>.create()
    */
    public function onCreate() : Void {
    }//function onCreate()


    /**
    * Free (destroy) widget
    *
    * @dispatch <type>ru.stablex.ui.events.WidgetEvent</type>.FREE
    */
    override public function free (recursive:Bool = true) : Void{
        this.destroyed = true;
        this.dispatchEvent(new WidgetEvent(WidgetEvent.FREE));

        super.free(recursive);

        //remove reference from UIBuilder
        UIBuilder.forget(this.id);
    }//function free()


    /**
    * Apply skin defined by `.skin` property
    *
    */
    public function applySkin () : Void {
        if( this.initialized && this.skin != null ){
            this.skin.apply(this);
        }
    }//function applySkin()


    /**
    * Apply layout settings defined by `.layout` property
    *
    */
    public function applyLayout () : Void {
        if( this.layout != null ){
            this.layout.arrangeChildren(this);
        }
    }//function applyLayout()


    /**
    * Refresh widget. This method is called at least once for every widget (on creation)
    * It's also called everytime widget is resized.
    */
    public function refresh() : Void {
        UIBuilder.queueSkin(this);
        this.applyLayout();
    }//function refresh()


    /**
    * Before adding to another widget display list
    *
    */
    @:noCompletion private function _newParent(newParent:Widget) : Void {
        if( newParent != this.parent) this.onNewParent(newParent);
    }//function _newParent()


    /**
    * Called before adding to new widget display list
    *
    */
    public function onNewParent(newParent:Widget) : Void {
        //Resize if our size is defined in percents
        if( this._widthUsePercent || this._heightUsePercent ){
            this.resize(
                (this._widthUsePercent ? newParent._width * this._widthPercent / 100 : this._width),
                (this._heightUsePercent ? newParent._height * this._heightPercent / 100 : this._height),
                true
            );
        }

        //positioning {
            switch ( this._xUse ) {
                //by right border
                case _X_USE_RIGHT: this.x = newParent._width - this._right - this._width;
                //by right percent
                case _X_USE_RIGHT_PERCENT: this.x = newParent._width - newParent._width * this._rightPercent / 100 - this._width;
                //by left percent
                case _X_USE_LEFT_PERCENT: this.x = newParent._width * this._leftPercent / 100;
            }//switch()

            switch ( this._yUse ) {
                //by bottom border
                case _Y_USE_BOTTOM: this.y = newParent._height - this._bottom - this._height;
                //by bottom percent
                case _Y_USE_BOTTOM_PERCENT: this.y = newParent._height - newParent._height * this._bottomPercent / 100 - this._height;
                //by top percent
                case _Y_USE_TOP_PERCENT: this.y = newParent._height * this._topPercent / 100;
            }//switch()
        //}
    }//function onNewParent()


    /**
    * Process parent widget resizing
    *
    */
    @:noCompletion private function _onParentResize(e:WidgetEvent) : Void {
        var parent : Widget = cast(e.currentTarget, Widget);

        //Resize if our size is defined in percents
        if( this._widthUsePercent || this._heightUsePercent ){
            this.resize(
                (this._widthUsePercent ? parent._width * this._widthPercent / 100 : this._width),
                (this._heightUsePercent ? parent._height * this._heightPercent / 100 : this._height),
                true
            );
        }

        //positioning {
            switch ( this._xUse ) {
                //by right border
                case _X_USE_RIGHT: this.x = parent._width - this._right - this._width;
                //by right percent
                case _X_USE_RIGHT_PERCENT: this.x = parent._width - parent._width * this._rightPercent / 100 - this.w;
                //by left percent
                case _X_USE_LEFT_PERCENT: this.x = parent._width * this._leftPercent / 100;
            }//switch()

            switch ( this._yUse ) {
                //by bottom border
                case _Y_USE_BOTTOM: this.y = parent._height - this._bottom - this._height;
                //by bottom percent
                case _Y_USE_BOTTOM_PERCENT: this.y = parent._height - parent._height * this._bottomPercent / 100 - this._height;
                //by top percent
                case _Y_USE_TOP_PERCENT: this.y = parent._height * this._topPercent / 100;
            }//switch()
        //}
    }//function _onParentResize()


    /**
    * Resize width and height simultaneously. Only one <type>ru.stablex.ui.events.WidgetEvent</type>.RESIZE will be dispatched
    *
    */
    public function resize(width:Float, height:Float, keepPercentage:Bool = false) : Void {
        if( !keepPercentage ){
            this._silentResize = true;
            this.w = width;
            this.h = height;
            this._silentResize = false;
        }else{
            this._width  = width;
            this._height = height;
        }

        this._onResize();
    }//function resize()


    /**
    * Called every time this object is resized. This methods calls `.refresh()` and `.onResize()` wich
    * can be overriden by user.
    *
    * @dispatch <type>ru.stablex.ui.events.WidgetEvent</type>.RESIZE
    * @dispatch <type>ru.stablex.ui.events.WidgetEvent</type>.INITIAL_RESIZE
    */
    @:final @:noCompletion private function _onResize() : Void {
        //positioning
        if( this.wparent != null ){
            switch( this._xUse ){
                //by right border
                case _X_USE_RIGHT: this.x = this.wparent._width - this._right - this._width;
                //by right percent
                case _X_USE_RIGHT_PERCENT: this.x = this.wparent._width - this.wparent._width * this._rightPercent / 100 - this._width;
            }//switch()

            switch ( this._yUse ) {
                //by bottom border
                case _Y_USE_BOTTOM: this.y = this.wparent._height - this._bottom - this._height;
                //by bottom percent
                case _Y_USE_BOTTOM_PERCENT: this.y = this.wparent._height - this.wparent._height * this._bottomPercent / 100 - this._height;
            }//switch()
        }//if()

        //handle overflow visibility
        if( !this.overflow ){
            this.scrollRect = new Rectangle(0, 0, this._width, this._height);
        }

        //to prevent infinite loops
        if( !this._resizing ){
            this._resizing = true;

            //run user's code
            if( this.created ){
                this.onResize();
            }

            //refresh widget
            if( this.initialized ){
                this.refresh();
            }

            this._resizing = false;
        }

        this.dispatchEvent(new WidgetEvent( this.created ? WidgetEvent.RESIZE : WidgetEvent.INITIAL_RESIZE ));
    }//function _onResize()


    /**
    * Override this method to handle resizing in your widgets
    *
    */
    public function onResize() : Void {
    }//function onResize()


    /**
    * Add child to display list. If child is Widget child.onNewParent() is called
    *
    */
    override public function addChild(child:DisplayObject) : DisplayObject {
        if( child.parent != null ){
            child.parent.removeChild(child);
        }

        if( Std.is(child, Widget) ){
            cast(child, Widget)._newParent(this);
            this.addUniqueListener(WidgetEvent.RESIZE, cast(child, Widget)._onParentResize);
            this.addUniqueListener(WidgetEvent.INITIAL_RESIZE, cast(child, Widget)._onParentResize);
        }

        return super.addChild(child);
    }//function addChild()


    /**
    * Add child to display list at specified index. If child is Widget child.onNewParent() is called
    *
    */
    override public function addChildAt(child:DisplayObject, idx:Int) : DisplayObject {
        if( child.parent != null ){
            child.parent.removeChild(child);
        }

        if( Std.is(child, Widget) ){
            cast(child, Widget)._newParent(this);
            this.addUniqueListener(WidgetEvent.RESIZE, cast(child, Widget)._onParentResize);
            this.addUniqueListener(WidgetEvent.INITIAL_RESIZE, cast(child, Widget)._onParentResize);
        }

        return super.addChildAt(child, idx);
    }//function addChildAt()


    /**
    * Remove child from display list
    *
    */
    override public function removeChild(child:DisplayObject) : DisplayObject {
        if( Std.is(child, Widget) ){
            this.removeEventListener(WidgetEvent.RESIZE, cast(child, Widget)._onParentResize);
            this.removeEventListener(WidgetEvent.INITIAL_RESIZE, cast(child, Widget)._onParentResize);
        }
        return super.removeChild(child);
    }//function removeChild()


    /**
    * Remove child at specified index from display list
    *
    */
    override public function removeChildAt(idx:Int) : DisplayObject {
        var child : DisplayObject = this.getChildAt(idx);
        if( Std.is(child, Widget) ){
            this.removeEventListener(WidgetEvent.RESIZE, cast(child, Widget)._onParentResize);
            this.removeEventListener(WidgetEvent.INITIAL_RESIZE, cast(child, Widget)._onParentResize);
        }
        return super.removeChildAt(idx);
    }//function removeChild()


    /**
    * Find child widget by `name` (recursively) and return it as instance of specified class
    *
    */
    public inline function getChildAs<T>(name:String, cls:Class<T>) : Null<T> {
        var w : Widget = this._findChildWidget(name);
        return ( Std.is(w, cls) ? cast w : null );
    }//function getChildAs()


    /**
    * Find child widget by `name` (recursively) and return it
    *
    */
    public inline function getChild(name:String) : Widget {
        return this._findChildWidget(name);
    }//function getChild()


    /**
    * Look through children for widget with specified `name`
    *
    */
    @:noCompletion private function _findChildWidget(name:String) : Widget {
        var child : DisplayObject = null;

        //check each child
        for(i in 0...this.numChildren){
            child = this.getChildAt(i);

            if( child.name == name ) break;

            //look through this child children
            if( Std.is(child, Widget) ){
                child = cast(child, Widget)._findChildWidget(name);
                if( child != null ) break;
            }

            child = null;
        }

        return ( Std.is(child, Widget) ? cast(child, Widget) : null );
    }//function _findChildWidget()


    /**
    * Find parent widget by `name` (recursively up on display list)
    *
    */
    public inline function getParent(name:String) : Widget {
        var p : Widget = this.wparent;

        while( p != null && p.name != name ){
            p = p.wparent;
        }

        return p;
    }//function getParent()


    /**
    * Find parent widget by `name` (recursively up on display list) and return it as instance of specified class
    *
    */
    public inline function getParentAs<T>(name:String, cls:Class<T>) : Null<T> {
        var p : Widget = this.wparent;

        while( p != null && p.name != name  ){
            p = p.wparent;
        }

        return ( Std.is(p, cls) ? cast p : null );
    }//function getParentAs()


    /**
    * Cast this instance to specified class
    *
    */
    public inline function as<T> (cls:Class<T>) : Null<T> {
        return (Std.is(this, cls) ? cast this : null);
    }//function as()

/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

    /**
    * Setter for `overflow`
    *
    */
    @:noCompletion private function set_overflow (o:Bool) : Bool {
        if( !o ){
            this.scrollRect = new Rectangle(0, 0, this._width, this._height);
        }else{
            this.scrollRect = null;
        }

        return this.overflow = o;
    }//function set_overflow()


    /**
    * Setter for `skinName`
    *
    */
    @:noCompletion private function set_skinName(sn:String) : String {
        this.skin = UIBuilder.skin(sn)();
        if( this.created ) UIBuilder.queueSkin(this);
        return this.skinName = sn;
    }//function set_skinName()


    /**
    * returns parent widget
    *
    */
    private inline function get_wparent() : Widget {
        return (
            Std.is(this.parent, Widget)
                ? cast(this.parent, Widget)
                : null
        );
    }//function get_wparent()


    /**
    * Left setter
    *
    */
    @:noCompletion private function set_left(l:Float) : Float {
        this._xUse = _X_USE_LEFT;
        this.x     = l;
        return this._left = l;
    }//function set_left()


    /**
    * Left getter
    *
    */
    @:noCompletion private function get_left() : Float {
        return this.x;
    }//function get_left()


    /**
    * Right setter
    *
    */
    @:noCompletion private function set_right(r:Float) : Float {
        this._xUse = _X_USE_RIGHT;
        if( this.wparent != null ){
            this.x = this.wparent._width - r - this.w;
        }
        return this._right = r;
    }//function set_right()


    /**
    * Right getter
    *
    */
    @:noCompletion private function get_right() : Float {
        if( this._xUse == _X_USE_RIGHT ){
            return this._right;
        }

        if( this.wparent != null ){
            return this.wparent._width - this.x - this.w;
        }

        return 0;
    }//function get_right()


    /**
    * Left percent setter
    *
    */
    @:noCompletion private function set_leftPt(lp:Float) : Float {
        this._xUse = _X_USE_LEFT_PERCENT;

        if( this.wparent != null ){
            this.x = this.wparent._width * lp / 100;
        }

        return this._leftPercent = lp;
    }//function set_leftPt()


    /**
    * Left percent getter
    *
    */
    @:noCompletion private function get_leftPt() : Float {
        if( this._xUse == _X_USE_LEFT_PERCENT ){
            return this._leftPercent;
        }

        if( this.wparent != null &&  this.wparent._width != 0 ){
            return this.x / this.wparent._width * 100;
        }

        return 0;
    }//function get_leftPt()


    /**
    * Right percent setter
    *
    */
    @:noCompletion private function set_rightPt(rp:Float) : Float {
        this._xUse = _X_USE_RIGHT_PERCENT;

        if( this.wparent != null ){
            this.x = this.wparent._width - this.wparent._width * rp / 100 - this.w;
        }

        return this._rightPercent = rp;
    }//function set_rightPt()


    /**
    * Right percent getter
    *
    */
    @:noCompletion private function get_rightPt() : Float {
        if( this._xUse == _X_USE_RIGHT_PERCENT ){
            return this._rightPercent;
        }

        if( this.wparent != null && this.wparent._width != 0 ) {
            return (this.wparent._width - this.x - this._width) / this.wparent._width * 100;
        }

        return 0;
    }//function get_rightPt()


    /**
    * Top setter
    *
    */
    @:noCompletion private function set_top(t:Float) : Float {
        this._yUse = _Y_USE_TOP;
        this.y     = t;
        return this._top = t;
    }//function set_top()


    /**
    * Top getter
    *
    */
    @:noCompletion private function get_top() : Float {
        return this.y;
    }//function get_top()


    /**
    * Bottom setter
    *
    */
    @:noCompletion private function set_bottom(b:Float) : Float {
        this._yUse = _Y_USE_BOTTOM;
        if( this.wparent != null ){
            this.y = this.wparent._height - b - this.h;
        }
        return this._bottom = b;
    }//function set_bottom()


    /**
    * Bottom getter
    *
    */
    @:noCompletion private function get_bottom() : Float {
        if( this._yUse == _Y_USE_BOTTOM ) {
            return this._bottom;
        }

        if( this.wparent != null ){
            return this.wparent._height - this.y - this.h;
        }

        return 0;
    }//function get_bottom()


    /**
    * Top percent setter
    *
    */
    @:noCompletion private function set_topPt(tp:Float) : Float {
        this._yUse = _Y_USE_TOP_PERCENT;

        if( this.wparent != null ){
            this.y = this.wparent._height * tp / 100;
        }

        return this._topPercent = tp;
    }//function set_topPt()


    /**
    * Top percent getter
    *
    */
    @:noCompletion private function get_topPt() : Float {
        if( this._yUse == _Y_USE_TOP_PERCENT ){
            return this._topPercent;
        }

        if( this.wparent != null &&  this.wparent._height != 0 ){
            return this.y / this.wparent._height * 100;
        }

        return 0;
    }//function get_leftPt()


    /**
    * Bottom percent setter
    *
    */
    @:noCompletion private function set_bottomPt(bp:Float) : Float {
        this._yUse = _Y_USE_BOTTOM_PERCENT;

        if( this.wparent != null ){
            this.y = this.wparent._height - this.wparent._height * bp / 100 - this.h;
        }

        return this._bottomPercent = bp;
    }//function set_bottomPt()


    /**
    * Bottom percent getter
    *
    */
    @:noCompletion private function get_bottomPt() : Float {
        if( this._yUse == _Y_USE_BOTTOM_PERCENT ){
            return this._bottomPercent;
        }

        if( this.wparent != null && this.wparent._height != 0 ) {
            return (this.wparent._height - this.y - this._height) / this.wparent._height * 100;
        }

        return 0;
    }//function get_rightPt()


    /**
    * Width setter
    *
    */
    @:noCompletion private function set_w(w:Float) : Float {
        this._width           = w;
        this._widthUsePercent = false;
        if( !this._silentResize ){
            this._onResize();
        }
        return w;
    }//function set_w()


    /**
    * Width getter
    *
    */
    @:noCompletion private function get_w() : Float {
        return this._width;
    }//function get_w()


    /**
    * Height setter
    *
    */
    @:noCompletion private function set_h(h:Float) : Float {
        this._height           = h;
        this._heightUsePercent = false;
        if( !this._silentResize ){
            this._onResize();
        }
        return h;
    }//function set_h()


    /**
    * Height getter
    *
    */
    @:noCompletion private function get_h() : Float {
        return this._height;
    }//function get_h()


    /**
    * Width percent setter
    *
    */
    @:noCompletion private function set_widthPt(wp:Float) : Float {
        this._widthPercent    = wp;
        this._widthUsePercent = true;

        if( this.wparent != null ){
            this._width = this.wparent._width * wp / 100;
            if( !this._silentResize ){
                this._onResize();
            }
        }

        return wp;
    }//function set_widthPt()


    /**
    * Width percent getter
    *
    */
    @:noCompletion private function get_widthPt() : Float {
        if( this._widthUsePercent ){
            return this._widthPercent;

        }else if( this.wparent != null && this.wparent._width != 0 ){
            return this.w / this.wparent._width * 100;

        }else{
            return 0;
        }
    }//function get_widthPt()


    /**
    * Height percent setter
    *
    */
    @:noCompletion private function set_heightPt(hp:Float) : Float {
        this._heightPercent    = hp;
        this._heightUsePercent = true;

        if( this.wparent != null ){
            this._height = this.wparent._height * hp / 100;
            if( !this._silentResize ){
                this._onResize();
            }
        }

        return hp;
    }//function set_heightPt()


    /**
    * Height percent getter
    *
    */
    @:noCompletion private function get_heightPt() : Float {
        if( this._heightUsePercent ){
            return this._heightPercent;

        }else if( this.wparent != null && this.wparent._height != 0 ){
            return this._height / this.wparent._height * 100;

        }else{
            return 0;
        }
    }//function get_heightPt()


    /**
    * Id setter
    *
    */
    @:final @:noCompletion private function set_id (id:String) : String{
        if( id == null ){
            Err.trigger('Widget id cannot be null');
        }

        //remove reference with old id
        if( this.id != null ){
            UIBuilder.forget(this.id);
        }

        this.id = id;

        //save reference with new id
        UIBuilder.save(this);

        return id;
    }//function set_id()


    /**
    * Setter for `.tip`
    *
    */
    @:noCompletion private function set_tip(tip:Tip) : Tip {
        if( this.tip != null ){
            this.tip.free();
        }
        tip.bindTo(this);
        return this.tip = tip;
    }//function set_tip()

}//class Widget