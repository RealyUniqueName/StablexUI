package ru.stablex.ui.widgets;

import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.Lib;
import ru.stablex.ui.events.WidgetEvent;


/**
* Basic tooltip. To create tooltip for widget, use following xml snippet:
* &lt;Widget tip:Tip-text="'My cool tool-tip'" /&gt;
*/

class Tip extends Floating{

    //widget to show tooltip for
    public var target : Widget;
    //tooltip content
    public var label : Text;
    //Setter and getter for `.label.text`
    public var text(get_text,set_text) : String;


    /**
    * Constructor. Create label object.
    *
    */
    public function new() : Void {
        super();

        //create text field for tooltip
        this.label = UIBuilder.create(Text);
        this.addChild(this.label);

        //do not affect mouse input
        this.mouseEnabled  = false;
        this.mouseChildren = false;
    }//function new()


    /**
    * Getter for `.text`
    *
    */
    @:noCompletion private function get_text() : String {
        return this.label.text;
    }//function get_text()


    /**
    * Setter for `.text`
    *
    */
    @:noCompletion private function set_text(s:String) : String {
        return this.label.text = s;
    }//function set_text()


    /**
    * Bind to specified widget
    *
    */
    public function bindTo(w:Widget) : Void {
        //release old target
        this._removeTargetListeners();

        this.target = w;

        this.target.addUniqueListener(MouseEvent.MOUSE_OVER, this.showTooltip);
        this.target.addUniqueListener(WidgetEvent.FREE, this.freeTooltip);
    }//function bindTo()


    /**
    * Called on rolling mouse over target widget
    *
    */
    public function showTooltip(e:MouseEvent) : Void {
        this.target.addUniqueListener(MouseEvent.MOUSE_OUT, this.hideTooltip);
        Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.moveTooltip);
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.moveTooltip);

        //always render on top of stage
        this.renderTo = null;

        this.refresh();
        this._adjustPosition();

        this.show();
    }//function showTooltip()


    /**
    * Follow mouse pointer
    *
    */
    public function moveTooltip(e:MouseEvent) : Void {
        this._adjustPosition();
    }//function moveTooltip()


    /**
    * Hide tooltip. Called on rolling mouse out of target widget
    *
    */
    public function hideTooltip(e:MouseEvent) : Void {
        this.target.removeEventListener(MouseEvent.MOUSE_OUT, this.hideTooltip);
        Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.moveTooltip);
        this.hide();
    }//function hideTooltip()


    /**
    * Adjust tooltip coordinates to follow mouse pointer
    *
    */
    private inline function _adjustPosition() : Void {
        this.left = (
            Lib.current.mouseX + 10 + this.w <= Lib.current.stage.stageWidth
                ? Lib.current.mouseX + 10
                : Lib.current.stage.stageWidth - this.w
        );
        this.top = (
            Lib.current.mouseY + 10 + this.h <= Lib.current.stage.stageHeight
                ? Lib.current.mouseY + 10
                : Lib.current.mouseY - 10 - this.h
        );
    }//function _adjustPosition()


    /**
    * destroy tooltip on `.target` destroy
    *
    */
    public function freeTooltip(e:WidgetEvent) : Void {
        this.free(true);
    }//function freeTooltip()


    /**
    * Remove event listeners added to `.target` widget
    *
    */
    private function _removeTargetListeners() : Void {
        if( this.target != null ){
            this.target.removeEventListener(MouseEvent.MOUSE_OUT, this.hideTooltip);
            this.target.removeEventListener(MouseEvent.MOUSE_OVER, this.showTooltip);
            this.target.removeEventListener(WidgetEvent.FREE, this.freeTooltip);
        }
    }//function _removeTargetListeners()


    /**
    * On destroy, remove event listeners added to `.target` and stage
    *
    */
    override public function free(recursive:Bool = true) : Void {
        this._removeTargetListeners();
        Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.moveTooltip);

        super.free(recursive);
    }//function free()


    /**
    * Refresh `.label` on refresh too
    *
    */
    override public function refresh() : Void {
        this.label.refresh();
        super.refresh();
    }//function refresh()


}//class Tip