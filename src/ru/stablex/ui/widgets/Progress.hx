package ru.stablex.ui.widgets;



/**
* Progress bar
*
*/
class Progress extends Widget{
    //Maximum value.
    public var max (default,_setMax) : Float = 100;
    //current value
    public var value (_getValue,_setValue) : Float = 0;
    private var _value : Float = 0;
    //bar
    public var bar : Widget;


    /**
    * Constructor
    *
    */
    public function new () : Void {
        super();
        this.bar = cast this.addChild(UIBuilder.create(Widget));
        this.bar.heightPt = 100;
    }//function new()


    /**
    * Set initial bar size on creation is complete.
    *
    */
    override public function onCreate () : Void {
        super.onCreate();
        this._setBarWidth(this.value, this.max);
    }//function onCreate()


    /**
    * Setter for `.max`
    *
    */
    private function _setMax (m:Float) : Float {
        if( this.created ){
            this._setBarWidth(this.value, m);
        }
        return this.max = m;
    }//function _setMax()


    /**
    * Setter for `.value`
    *
    */
    private function _setValue (v:Float) : Float {
        this._setBarWidth(v, this.max);
        return this._value = v;
    }//function _setValue()


    /**
    * Getter for `.value`
    *
    */
    private function _getValue () : Float {
        return this._value;
    }//function _setValue()


    /**
    * Set bar width based on provided values
    *
    */
    private inline function _setBarWidth (value:Float, max:Float) : Void {
        this.bar.widthPt = 100 * (max <= 0 || value <= 0 ? 0 : value / max);
    }//function _setBarWidth()

}//class Progress