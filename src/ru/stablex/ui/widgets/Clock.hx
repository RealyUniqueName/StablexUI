package ru.stablex.ui.widgets;

import haxe.Timer;
import ru.stablex.ui.events.WidgetEvent;



/**
* Clock / timer widget
*
*/
class Clock extends Text{

    //Count seconds forward or backward (to zero)
    public var forward : Bool = true;
    //current amount of seconds
    public var value (default,set_value) : Int = 0;
    //use leading zero for numbers less than 10
    public var leadingZero : Bool = true;
    //timer object
    private var _timer : Timer;
    /**
    * text format.
    * %h, %m, %s - hours, minutes, seconds respectively, without leading zeroes
    * %H, %M, %S - with leading zeroes
    */
    public var timeFormat (default,set_timeFormat) : String = "%H:%M:%S";
    private var _hrsIdx : Int = 0;
    private var _minIdx : Int = 3;
    private var _secIdx : Int = 6;

/*******************************************************************************
*   STATIC METHODS
*******************************************************************************/



/*******************************************************************************
*   INSTANCE METHODS
*******************************************************************************/

    /**
    * Display initial value on create
    *
    */
    override public function onCreate() : Void {
        super.onCreate();
        this.set_value(this.value);
    }//function onCreate()


    /**
    * Start counting
    *
    */
    public function run() : Void {
        if( this._timer == null ){
            this._timer = new Timer(1000);
        }

        this._timer.run = this._counter;
    }//function run()


    /**
    * Stop counting
    *
    */
    public function stop() : Void {
        if( this._timer != null ){
            this._timer.stop();
        }
    }//function stop()


    /**
    * Seconds counter for timer instance
    *
    */
    private function _counter() : Void {
        this.value += (this.forward ? 1 : -1);
    }//function _counter()


    /**
    * Stop timer on destrouction
    * @private
    */
    override public function free(recursive:Bool = true) : Void {
        this.stop();
        super.free(recursive);
    }//function free()


/*******************************************************************************
*   GETTERS / SETTERS
*******************************************************************************/

    /**
    * Setter format
    *
    */
    @:noCompletion private function set_timeFormat(timeFormat:String) : String {
        this._hrsIdx = (
            timeFormat.indexOf("%H") == -1
                ? timeFormat.indexOf("%h")
                : timeFormat.indexOf("%H")
        );

        this._minIdx = (
            timeFormat.indexOf("%M") == -1
                ? timeFormat.indexOf("%m")
                : timeFormat.indexOf("%M")
        );

        this._secIdx = (
            timeFormat.indexOf("%S") == -1
                ? timeFormat.indexOf("%s")
                : timeFormat.indexOf("%S")
        );

        return this.timeFormat = timeFormat;
    }//function set_format()


    /**
    * Setter value
    *
    */
    @:noCompletion private function set_value(value:Int) : Int {
        if( value < 0 ) value = 0;

        var str : String = this.timeFormat;
        var val : Int = value;

        //hours
        if( this._hrsIdx >= 0 ){
            var hrs : Int = Math.floor(value / 3600);
            val -= hrs * 3600;
            if( str.charAt(this._hrsIdx + 1) == "H" ){
                str = StringTools.replace(str, "%H", StringTools.lpad(Std.string(hrs), "0", 2));
            }else{
                str = StringTools.replace(str, "%h", Std.string(hrs));
            }
        }

        //minutes
        if( this._minIdx >= 0 ){
            var min : Int = Math.floor(val / 60);
            val -= min * 60;
            if( str.charAt(this._minIdx + 1) == "M" ){
                str = StringTools.replace(str, "%M", StringTools.lpad(Std.string(min), "0", 2));
            }else{
                str = StringTools.replace(str, "%m", Std.string(min));
            }
        }

        //seconds
        if( this._secIdx >= 0 ){
            if( str.charAt(this._secIdx + 1) == "S" ){
                str = StringTools.replace(str, "%S", StringTools.lpad(Std.string(val), "0", 2));
            }else{
                str = StringTools.replace(str, "%s", Std.string(val));
            }
        }

        //dispatch event
        if( this.created && this.value != value && this.hasEventListener(WidgetEvent.CHANGE) ){
            this.value = value;
            this.dispatchEvent(new WidgetEvent(WidgetEvent.CHANGE));
        }else{
            this.value = value;
        }

        this.text = str;
        return value;
    }//function set_value()


}//class Clock