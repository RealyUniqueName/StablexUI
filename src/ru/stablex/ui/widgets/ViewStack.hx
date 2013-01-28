package ru.stablex.ui.widgets;

import nme.display.DisplayObject;


/**
* There can be only one child element visible in ViewStack
* By default visible child is one with childIndex = 0
*/
class ViewStack extends Widget{

    private var _history : Array<Int>;

    //getter for .name of currently visible child
    public var current (_getCurrent,never)       : String;
    //child index of currently visible child
    public var currentIdx (_getCurrentIdx,never) : Int;
    // wrap the stack list or not
    public var wrap : Bool = false;

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
        this.showIdx(this.currentIdx, true);
    }//function refresh()


    /**
    * Shows element with given child index
    *
    */
    public function showIdx (idx:Int, ignoreHistory:Bool = false) : Void{
        if( idx < this.numChildren ){

            for(i in 0...this.numChildren){
                this.getChildAt(i).visible = false;
            }

            this.getChildAt(idx).visible = true;

            if( !ignoreHistory ){
                this._history.push(idx);
            }
        }
    }//function showIdx()


    /**
    * Show element with given .name
    *
    */
    public function show (name:String, ignoreHistory:Bool = false) : Void {
        var child : DisplayObject;

        for(i in 0...this.numChildren){
            child = this.getChildAt(i);

            if( child.name == name ){
                child.visible = true;
                if( !ignoreHistory ){
                    this._history.push(i);
                }
            }else{
                child.visible = false;
            }
        }
    }//function show()


    /**
    * Show element wich was visible previously
    *
    */
    public inline function back() : Void {
        this._history.pop();
        this.showIdx(this._history.pop());
    }//function back()
    
    /**
    * Show next element
    * If wrap is true and we are at the end of the stack then
    * show the first one
    */
    public inline function next() : Void {
        var next = this._getCurrentIdx() + 1;
        if (next < this.numChildren) {
            this.showIdx(next);
        }
        else if (wrap) {
            this.showIdx(0);
        }
    }//function next()
    
    /**
    * Show previous element
    * If wrap is true and we are at the beginning of the stack then
    * show the last one
    */
    public inline function previous() : Void {
        var previous = this._getCurrentIdx() - 1;
        if (previous >= 0) {
            this.showIdx(previous);
        }
        else if (wrap) {
            this.showIdx(this.numChildren - 1);
        }
    }//function previous()


    /**
    * Getter for this.current
    *
    */
    private function _getCurrent() : String {
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
    }//function _getCurrent()


    /**
    * getter for this.currentIdx
    *
    */
    private function _getCurrentIdx() : Int {
        return this._history[ this._history.length - 1 ];
    }//function _getCurrentIdx()


}//class ViewStack