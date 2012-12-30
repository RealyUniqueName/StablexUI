package ru.stablex.ui.widgets;

import nme.display.DisplayObject;


/**
* There can be only one child element visible in ViewStack
*/
class ViewStack extends Widget{

    private var _history : Array<Int>;

    //getter for .name of currently visible child
    public var current (_getCurrent,never)       : String;
    //child index of currently visible child
    public var currentIdx (_getCurrentIdx,never) : Int;


    /**
    * Constructor
    *
    */
    public function new() : Void {
        super();
        this._history = [0];
    }//function new()



    /**
    * Refresh widget.
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