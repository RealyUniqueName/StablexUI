package ru.stablex.ui.widgets;

import nme.display.DisplayObject;
import ru.stablex.ui.transitions.Transition;

/**
* There can be only one child element visible in ViewStack
* By default visible child is one with childIndex = 0
*/
class ViewStack extends Widget{

    private var _history : Array<Int>;

    //getter for .name of currently visible child
    public var current (get_current,never)       : String;
    //child index of currently visible child
    public var currentIdx (get_currentIdx,never) : Int;
    // wrap the stack list or not (for `.next()` calls)
    public var wrap : Bool = false;
    //transition for changing children
    public var trans : Transition = null;


    /**
    * Constructor
    *
    */
    public function new() : Void {
        super();
        this._history = [0];
    }//function new()


    /**
    * Refresh widget. On refresh show currently active child
    *
    */
    override public function refresh () : Void{
        super.refresh();

        //hide everything except current
        var idx : Int = this.currentIdx;
        for(i in 0...this.numChildren){
            if( idx != i ){
                this.getChildAt(i).visible = false;
            }else{
                this.getChildAt(i).visible = true;
            }
        }
    }//function refresh()


    /**
    * Shows element with given child index
    *
    * @param ignoreHistory - do not write this visit to history log
    * @param cb - callback to call after visible object was hidden
    */
    public function showIdx (idx:Int, cb:Void->Void = null, ignoreHistory:Bool = false) : Void{
        if( idx < this.numChildren ){
            var toHide : DisplayObject = this.getChildAt(this.currentIdx);
            var toShow : DisplayObject = this.getChildAt(idx);

            //should we use transition?
            if( toHide != toShow && this.trans != null ){
                this.trans.change(this, toHide, toShow, cb);
            }else{
                toHide.visible = false;
                toShow.visible = true;
                if( cb != null ) cb();
            }

            if( !ignoreHistory ){
                this._history.push(idx);
            }
        }
    }//function showIdx()


    /**
    * Show element with given .name
    *
    * @param cb - callback to call after visible object was hidden
    */
    public function show (name:String, cb:Void->Void = null, ignoreHistory:Bool = false) : Void {
        var toHide : DisplayObject = this.getChildAt(this.currentIdx);
        var toShow : DisplayObject = this.getChildByName(name);

        if( toShow != null ){
            if( !ignoreHistory ){
                this._history.push( this.getChildIndex(toShow) );
            }

            if( toHide != toShow && this.trans != null ){
                this.trans.change(this, toHide, toShow, cb);
            }else{
                toHide.visible = false;
                toShow.visible = true;
                if( cb != null ) cb();
            }
        }
    }//function show()


    /**
    * Show element wich was visible previously.
    * Goes back through history log and removes the last entry from log.
    *
    * @param cb - callback to call after visible object was hidden
    */
    public inline function back(cb:Void->Void = null) : Void {
        if( this._history.length >= 2 ){
            this.showIdx(this._history[ this._history.length - 2 ], cb, true);
            this._history.pop();
        }
    }//function back()


    /**
    * Show next element in display list of viewstack.
    * If wrap is true and we are at the end of the stack then
    * show the first one
    *
    * @param cb - callback to call after visible object was hidden
    */
    public inline function next(cb:Void->Void = null) : Void {
        var next = this.get_currentIdx() + 1;
        if (next < this.numChildren) {
            this.showIdx(next, cb);
        }else if (this.wrap) {
            this.showIdx(0, cb);
        }
    }//function next()


    /**
    * Show previous element in display list of viewstack.
    * If wrap is true and we are at the beginning of the stack then
    * show the last one.
    *
    * @param cb - callback to call after visible object was hidden
    */
    public inline function previous(cb:Void->Void = null) : Void {
        var previous = this.currentIdx - 1;
        if (previous >= 0) {
            this.showIdx(previous, cb);
        }else if (this.wrap) {
            this.showIdx(this.numChildren - 1, cb);
        }
    }//function previous()


    /**
    * Getter for this.current
    *
    */
    private function get_current() : String {
        if( this._history.length == 0 || this._history[ this._history.length - 1 ] >= this.numChildren ){
            return null;
        }else{
            var child : DisplayObject = this.getChildAt( this._history[ this._history.length - 1 ] );
            if( child == null ){
                return null;
            }else{
                return child.name;
            }
        }
    }//function get_current()


    /**
    * getter for this.currentIdx
    *
    */
    private function get_currentIdx() : Int {
        var idx : Int = this._history[ this._history.length - 1 ];
        //if idx is out of bounds, get currently visible child index
        if( idx >= this.numChildren ){
            for(i in 0...this.numChildren){
                if( this.getChildAt(i).visible == true ){
                    this._history[ this._history.length - 1 ] = idx = i;
                    break;
                }
            }
        }
        return idx;
    }//function get_currentIdx()


    /**
    * Clear history log
    *
    */
    public function clearHistory() : Void {
        this._history = [this.currentIdx];
    }//function clearHistory()


}//class ViewStack