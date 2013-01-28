package ru.stablex.ui.widgets;

import nme.events.Event;
import nme.events.MouseEvent;

import ru.stablex.Err;
import ru.stablex.ui.widgets.StateButton;
import ru.stablex.ui.widgets.ViewStack;

/**
* The TabStack is comprised of a set of Tab and a ViewStack.
* Only one tab can be selected at a time. The corresponding item
* in the ViewStack will be shown.
* 
*/

class TabStack extends Widget{
    
    // the tab buttons
    private var _tabButtons : Array<Tab>;
    // the viewstack
    private var _viewStack : ViewStack;
    
    private var _selectedIdx : Int = 0;
    public var wrap : Bool = false;
    
    /**
    * Constructor
    *
    */
    public function new() : Void {
        super();
        
        _tabButtons = new Array<Tab>();
    }//function new()
    
    public override function onCreate () : Void{
        super.onCreate();

        if( this.numChildren < 2 ){
            Err.trigger('Not enough children');
        }
        for (i in 0...this.numChildren - 1) {
            var button = cast(this.getChildAt(i), Tab);
            _tabButtons.push(button);
            button.addEventListener(MouseEvent.CLICK, _selectTab);
        }
        _viewStack = cast this.getChildAt(this.numChildren - 1);
    }//function onCreationComplete()
    
    // Select the tab and show the 
    private function _selectTab (ev:Event) {
        var selected = 0;
        for (i in 0...this._tabButtons.length) {
            if (this._tabButtons[i] != cast ev.currentTarget) {
                this._tabButtons[i].selected = false;
            }
            else {
                selected = i;
            }
        }
        selectTabIdx(selected);
    }
    
    public function selectTabIdx (idx:Int) {
        if (idx >= this._tabButtons.length) {
            Err.trigger('Index is greater than Tabs length');
        }
        if (idx >= this._viewStack.numChildren) {
            Err.trigger('Index is greater than the ViewStack length');
        }
        
        for (i in 0...this._tabButtons.length) {
            if (this._tabButtons[i] != this._tabButtons[idx]) {
                this._tabButtons[i].selected = false;
            }
        }
        _selectedIdx = idx;
        _viewStack.showIdx(idx);
        var tab = this._tabButtons[idx];
        tab.selected = true;
        tab.highlight();
    }
    
    public function previousTab () {        
        var previous = this._selectedIdx - 1;
        if (previous >= 0) {
            this.selectTabIdx(previous);
        }
        else if (wrap) {
            this.selectTabIdx(_tabButtons.length - 1);
        }
    }
    
    public function nextTab () {
        var next = this._selectedIdx + 1;
        if (next < this._tabButtons.length) {
            this.selectTabIdx(next);
        }
        else if (wrap) {
            this.selectTabIdx(0);
        }
    }
    
}