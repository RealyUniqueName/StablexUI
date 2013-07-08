package ru.stablex.ui.widgets;

import flash.events.Event;
import flash.Lib;


/**
* `Floating` widget. Call `.show()` to render on top of display list of specified display object.
* By default it is rendered on top of the stage.
* If it is rendered on top of stage, size and position in % of parent size is still works properly.
* E.g. with `.renderTo` == null and `.widthPt` == 100. This widget's width will always be the same
* as stage width (even on stage resize)
*/
class Floating extends Box{

    //whether widget is shown
    public var shown (default,null) : Bool = false;
    //Id of widget to render to. By default it's rendered on top of stage.
    public var renderTo : String = null;


    /**
    * Constructor
    * set `.visible` = false by default
    */
    public function new () : Void {
        super();
        this.visible = false;
    }//function new()


    /**
    * Render this widget to place, wich is defined by `.renderTo`
    *
    */
    public function show () : Void {
        //render on top of the stage?
        if( this.renderTo == null ){
            this.visible = this.shown = true;

            //if sized or positioned in %, listen for stage resize
            if( this._usingParentSize() ){
                Lib.current.stage.removeEventListener(Event.RESIZE, this._onStageResize);
                Lib.current.stage.addEventListener(Event.RESIZE, this._onStageResize);
            }

            if( this.parent == Lib.current ){
                Lib.current.stage.setChildIndex(this, Lib.current.stage.numChildren - 1);
            }else{
                Lib.current.stage.addChild(this);
            }

            this._onStageResize();

        //render to another widget
        }else{
            var to : Widget = UIBuilder.get(this.renderTo);
            if( to != null ){
                this.visible = this.shown = true;
                if( this.parent == to ){
                    to.setChildIndex(this, to.numChildren - 1);
                }else{
                    to.addChild(this);
                }
            }
        }
    }//function show()


    /**
    * Hide this widget without destroying it
    *
    */
    public function hide () : Void {
        Lib.current.stage.removeEventListener(Event.RESIZE, this._onStageResize);

        if( this.parent != null ){
            this.parent.removeChild(this);
        }

        this.visible = this.shown = false;
    }//function hide()


    /**
    * Check whether this widget is sized or positioned in % of parent's size
    *
    */
    private inline function _usingParentSize () : Bool {
        return (
            this._widthUsePercent || this._heightUsePercent
            || this._xUse == Widget._X_USE_LEFT_PERCENT || this._xUse == Widget._X_USE_RIGHT_PERCENT || this._xUse == Widget._X_USE_RIGHT
            || this._yUse == Widget._Y_USE_TOP_PERCENT || this._yUse == Widget._Y_USE_BOTTOM_PERCENT || this._yUse == Widget._Y_USE_BOTTOM
        );
    }//function _usingParentSize()


    /**
    * Listen for stage resizing
    *
    */
    private function _onStageResize (e:Event = null) : Void{
        if( this.parent != Lib.current.stage ) return;

        var width  : Float = Lib.current.stage.stageWidth;
        var height : Float = Lib.current.stage.stageHeight;

        //size {
            //if width and height in %
            if( this._widthUsePercent && this._heightUsePercent ){
                this.resize(width * this._widthPercent / 100, height * this._heightPercent / 100, true);

            //if width in %
            }else if( this._widthUsePercent ){
                this.resize(width * this._widthPercent / 100, this._height, true);

            //if height in %
            }else if( this._heightUsePercent ){
                this.resize(this._width, height * this._heightPercent / 100, true);
            }
        //}

        //position {
            switch ( this._xUse ) {
                //by right border
                case Widget._X_USE_RIGHT: this.x = width - this._right - this._width;
                //by right percent
                case Widget._X_USE_RIGHT_PERCENT: this.x = width - width * this._rightPercent / 100 - this.w;
                //by left percent
                case Widget._X_USE_LEFT_PERCENT: this.x = width * this._leftPercent / 100;
            }//switch()

            switch ( this._yUse ) {
                //by bottom border
                case Widget._Y_USE_BOTTOM: this.y = height - this._bottom - this._height;
                //by bottom percent
                case Widget._Y_USE_BOTTOM_PERCENT: this.y = height - height * this._bottomPercent / 100 - this._height;
                //by top percent
                case Widget._Y_USE_TOP_PERCENT: this.y = height * this._topPercent / 100;
            }//switch()
        //}
    }//function _onStageResize()


    /**
    * On destroy, remove listener from stage resizing
    *
    */
    override public function free (recursive:Bool = true) : Void {
        Lib.current.stage.removeEventListener(Event.RESIZE, this._onStageResize);
        super.free(recursive);
    }//function free()

}//class Floating