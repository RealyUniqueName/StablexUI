package com.visusway.components;

import Date;
import haxe.Timer;
import ru.stablex.ui.events.WidgetEvent;
import flash.events.Event;

/**
* Widget class, which extends xml-based class
*
*/
class ClockDial extends ClockDialBase {
	
	//current amount of day
    public var dateValue (default,set_dateValue) : String = "";	
    //current amount of seconds
    public var timeValue (default,set_timeValue) : Int = 0;

    //timer object
    private var _timer : Timer;
	//date object
	private var _date : Date; 
	
	public var year(default, set_year) : Int = 1970;
	public var month(default, set_month) : Int = 1;
	public var day(default, set_day) : Int = 1;
	
	public var hours(default, set_hours) : Int = 0;
	public var minutes(default, set_minutes) : Int = 0;
	public var seconds(default, set_seconds) : Int = 0;
	
	public var useGrid(default, set_useGrid) : Bool = false;
	public var useHourGrid: Bool = false;
	public var useMinuteGrid: Bool = false;
	public var useSecondGrid: Bool = true;
	public var useSecondTween: Bool = true;
	public var setSecondHandStyle: String = "Bounce.easeOut";
	private var _useSecondGridOrTween: Bool = false;

/*******************************************************************************
*   STATIC METHODS
*******************************************************************************/



/*******************************************************************************
*   INSTANCE METHODS
*******************************************************************************/

    /**
    * Constructor
    *
    */
    public function new() : Void {
        super();
    }//function new()
	

    /**
    * Display initial value on create
    *
    */
    override public function onCreate() : Void {
        super.onCreate();
        //this.set_value(this.value);

		this.DateNow();
		if (this.useSecondTween) {
			this._useSecondGridOrTween = this.useSecondGrid;
			this.useSecondGrid = false;
			var displayfn : Event->Void = function(e:Event) : Void {
				this.useSecondGrid = this._useSecondGridOrTween;
			};
			this.addEventListener(nme.events.Event.ADDED_TO_STAGE, displayfn);			
		}
		this._getDatetime();
		this.run();
    }//function onCreate()

	
    /**
    * Start counting
    *
    */
    public function run() : Void {
        if( this._timer == null ){
            this._timer = new Timer(1000);
        }
		this._timer.run = this._getDatetime;
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

	public function DateNow() : Void {
		this._date = Date.now();
		this.year = this._date.getFullYear();
		this.month = this._date.getMonth();
		this.day = this._date.getDay();
		this.hours = this._date.getHours();
		this.minutes = this._date.getMinutes();
		this.seconds = this._date.getSeconds();
		
	}
	
	private function _setClockHand() : Void {
		
		if (this.useHourGrid)
			this.hur.rotationByPoint = ((this.hours % 12) * (360 / 12));
		else 
			this.hur.rotationByPoint = (((this.hours % 12) + (this.minutes / 60)) * (360 / 12));
		
		if (this.useMinuteGrid)
			this.min.rotationByPoint = (this.minutes * (360 / 60));
		else 
			this.min.rotationByPoint = ((this.minutes + (this.seconds / 60)) * (360 / 60));
		
		if (!this.useSecondGrid)
			this.sec.rotationByPoint = (this.seconds * (360 / 60));
		else {
			var secRot:Float = 0;
			this.sec.tweenStop("rotationByPoint", true, true);
			var finish : Void->Void = function() : Void {
				if (this.seconds == 0) 
					this.sec.rotationByPoint = 0;
			};			
			if (this.seconds == 0) {	
				secRot = ( 60 * (360 / 60));
			}else {
				secRot = (this.seconds * (360 / 60));
			}
			this.sec.tween(0.8, { rotationByPoint:secRot }, this.setSecondHandStyle ).onComplete(finish);
		}
	}
	
	private function _getDatetime() : Void {
		this.DateNow();
		this.dateValue = this.year + "-" + this.month + "-" + this.day;
		this.timeValue = this.hours * 3600 + this.minutes * 60 + this.seconds;
	}
	
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

	private function set_dateValue(dateValue:String) : String {
		this.dateValue = dateValue;
		return dateValue;
	}

    /**
    * Setter timevalue
    *
    */
    private function set_timeValue(timeValue:Int) : Int {
        if( timeValue < 0 ) timeValue = 0;

		if (this.timeValue != timeValue)
		{
			this._setClockHand();
		}
		
        //dispatch event
        if( this.created && this.timeValue != timeValue && this.hasEventListener(WidgetEvent.CHANGE) ){
            this.timeValue = timeValue;
            this.dispatchEvent(new WidgetEvent(WidgetEvent.CHANGE));
        }else{
            this.timeValue = timeValue;
        }

        return timeValue;
    }//function set_value()

    private function set_year(val:Int) : Int {
		if (val < 1 || val > 9999) val = this.year;
		else this.year = val;
		return val;
	}

    private function set_month(val:Int) : Int {
		if (val < 1 || val > 12) val = this.month;
		else this.month = val;
		return val;
	}
	
    private function set_day(val:Int) : Int {
		if (val < 1 || val > 31) val = this.day;
		else this.day = val;
		return val;
	}
	
	private function set_hours(val:Int) : Int {
		if (val < 0 || val >= 24) val = this.hours;
		else this.hours = val;
		return val;
	}
	
	private function set_minutes(val:Int) : Int {
		if (val < 0 || val >= 60) val = this.minutes;
		else this.minutes = val;
		return val;
	}	
	
	private function set_seconds(val:Int) : Int {
		if (val < 0 || val >= 60) val = this.seconds;
		else this.seconds = val;
		return val;
	}	
	
	private function set_useGrid(useGrid:Bool) : Bool {
		this.useGrid = useGrid;
		
		if (this.useGrid) {
			this.useHourGrid = this.useGrid;
			this.useMinuteGrid = this.useGrid;
			//this.useSecondGrid = this.useGrid;
		} else {
			this.useHourGrid = this.useGrid;
			this.useMinuteGrid = this.useGrid;
			//this.useSecondGrid = this.useGrid;
		}
		return useGrid;
	}

}//class CustomExt