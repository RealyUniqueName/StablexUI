package ru.stablex.ui.widgets;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import ru.stablex.ui.events.WidgetEvent;


/**
* Switch (on/off)
*/
class Switch extends Widget{

    //label to the left from slider
    public var labelOn : Text;
    //label to ther right from slider
    public var labelOff : Text;
    //Slider element
    public var slider : Widget;
    //Indicates switch state. `true` for `on`-state, `false` for `off`-state. `true` by default
    public var selected (get_selected,set_selected) : Bool;
    private var _selected : Bool = true;
    //if user is pushing `.slider`
    private var _sliding : Bool = false;


    /**
    * Constructor
    *
    */
    public function new() : Void {
        super();
        this.overflow = false;

        this.slider = UIBuilder.create(Widget, {right:0, heightPt:100});
        this.addChild(this.slider);

        this.labelOn  = UIBuilder.create(Text, {
            text          : 'ON',
            mouseEnabled  : false,
            mouseChildren : false,
            heightPt      : 100,
            rightPt       : 100,
            align         : 'right,middle'
        });
        this.labelOff = UIBuilder.create(Text, {
            text          : 'OFF',
            mouseEnabled  : false,
            mouseChildren : false,
            heightPt      : 100,
            leftPt        : 100,
            align         : 'right,middle'
        });

        this.slider.addEventListener(MouseEvent.MOUSE_DOWN, this._slide);
        this.addEventListener(MouseEvent.MOUSE_UP, this._onRelease);
    }//function new()


    /**
    * Setter for `.selected`. Change switch state
    *
    */
    @:noCompletion private function set_selected(s:Bool) : Bool {
        this._selected = s;
        if( s ){
            this.slider.right = 0;
        }else{
            this.slider.left = 0;
        }

        if( this.created ){
            this.dispatchEvent(new WidgetEvent(WidgetEvent.CHANGE));
        }
        return s;
    }//function set_selected()


    /**
    * Getter for `.selected`
    *
    */
    @:noCompletion private function get_selected() : Bool {
        return this._selected;
    }//function get_selected()


    /**
    * Add labels to display list
    *
    */
    override public function onInitialize() : Void {
        super.onInitialize();
        this.slider.addChild(this.labelOn);
        this.slider.addChild(this.labelOff);
    }//function onInitialize()


    /**
    * Refresh
    *
    */
    override public function refresh () : Void {
        super.refresh();
        this.slider.refresh();
        this.labelOn.refresh();
        this.labelOff.refresh();
    }//function refresh()


    /**
    * Change switch state on slider release
    *
    */
    private function _onRelease(e:MouseEvent) : Void {
        if( e.target != this.slider && !(this.mouseX < 0 || this.mouseX > this.w || this.mouseY < 0 || this.mouseY > h) ){
            this._selected = !this._selected;
        }

        if( this.selected ){
            this.slider.tween(0.25, {right:0}, 'Quad.easeOut');
        }else{
            this.slider.tween(0.25, {left:0}, 'Quad.easeOut');
        }

        this.dispatchEvent(new WidgetEvent(WidgetEvent.CHANGE));
    }//function _onRelease()


    /**
    * Handle sliding.
    *
    */
    private inline function _slide (e:MouseEvent) : Void {
        var dx     : Float = this.mouseX - this.slider.left;
        var startX : Float = this.mouseX;
        //indicate user is actually moving slider
        var slided : Bool = false;

        //make `.slider` follow mouse pointer
        var fn : Event->Void = function(e:Event) : Void {
            if( Math.abs(startX - this.mouseX) >= 5){
                slided = true;
            }

            this.slider.left = (
                this.mouseX - dx < 0
                    ? 0
                    : (
                        this.mouseX - dx + this.slider._width > this._width
                            ? this._width - this.slider._width
                            : this.mouseX - dx
                    )
            );
        };
        this.addEventListener(Event.ENTER_FRAME, fn);

        //release `.slider` on MOUSE_UP
        var fnRelease : MouseEvent->Void = null;
        fnRelease = function(e:MouseEvent) : Void {
            //if user did not move slider, toggle state
            if( !slided ){
                this._selected = !this._selected;

            //if user moved slider, set state according to position of the slider
            }else{
                this._selected = (this.slider.left > this.slider.right);
            }

            this._onRelease(e);

            //remove listeners
            this.removeEventListener(Event.ENTER_FRAME, fn);
            Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, fnRelease);
        };

        //listen for MOUSE_UP
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, fnRelease);
    }//function _slide()
}//class Switch