package ru.stablex.ui.widgets;

import nme.display.DisplayObject;
import nme.events.Event;
import nme.events.MouseEvent;

import ru.stablex.Err;
import ru.stablex.ui.events.WidgetEvent;
import ru.stablex.ui.widgets.StateButton;
import ru.stablex.ui.widgets.ViewStack;

/**
* The TabStack is comprised of a set of Tabs and a ViewStack.
* Only one tab can be selected at a time. The corresponding item
* in the ViewStack will be shown.
*
*/

class TabStack extends Box{

    //widget, wich will contain tabs headers
    public var tabBar : Box;
    // The tab buttons
    private var _tabButtons : Array<Tab>;
    // The viewstack
    private var _viewStack : ViewStack;
    // The selected index
    private var _selectedIdx : Int = 0;
    // The selected index
    public var selectedIdx(_getSelectedIdx, never) : Int;
    // wrap the stack list or not (for `.next()` calls)
    public var wrap : Bool = false;


    /**
    * Constructor
    *
    */
    public function new() : Void {
        super();
        // this._tabButtons = new Array<Tab>();

        this.tabBar = UIBuilder.create(Box, {
            widthPt    : 100,
            autoHeight : true,
            vertical   : true,
            align      : 'left,bottom'
        });
        this.addChild(this.tabBar);

    }//function new()


    /**
    * Add child. Only instances of <type>Tab</type> allowed
    * @throw <type>String</type> if child is not instance of <type>Tab</type>
    */
    override public function addChild (child:DisplayObject) : DisplayObject {
        if( this.initialized ){
            if( !Std.is(child, Tab) ){
                Err.trigger('Only instances of ru.stablex.ui.widgets.Tab can be children of ru.stablex.ui.widgets.TabStack');
            }
            //add tab's title to `.tabBar`
            var tab : Tab = cast(child, Tab);
            if( tab.title.parent != this.tabBar ){
                this.tabBar.addChild(tab.title);
            }
            //listen for tab selection
            tab.title.addUniqueListener(WidgetEvent.CHANGE, this._onChange);
        }
        return super.addChild(child);
    }//function addChild()


    /**
    * Add child at specified index. Adding to index 0 is not allowed (reserved for `.tabBar`).
    * Only instances of <type>Tab</type> allowed
    * @throw <type>String</type> if child is not instance of <type>Tab</type>
    * @throw <type>String</type> if trying to add to 0 index
    */
    override public function addChildAt (child:DisplayObject, idx:Int) : DisplayObject {
        if( this.initialized ){
            if( !Std.is(child, Tab) ){
                Err.trigger('Only instances of ru.stablex.ui.widgets.Tab can be children of ru.stablex.ui.widgets.TabStack');
            }
            //add tab's title to `.tabBar`
            var tab : Tab = cast(child, Tab);
            if( tab.title.parent != this.tabBar ){
                this.tabBar.addChildAt(tab.title);
            }
            //listen for tab selection
            tab.title.addUniqueListener(WidgetEvent.CHANGE, this._onChange);
        }
        return super.addChildAt(child, idx);
    }//function addChildAt()



    // /**
    // * This method is called automatically after widget was created
    // * by <type>UIBuilder</type>.buildFn() or <type>UIBuilder</type>.create()
    // * It populates the list of tabs and tab contents, and then selects
    // * the first tab
    // *
    // */
    // public override function onCreate () : Void{
    //     super.onCreate();

    //     if( this.numChildren < 2 ){
    //         Err.trigger('Not enough children');
    //     }
    //     for (i in 0...this.numChildren - 1) {
    //         var button = cast(this.getChildAt(i), Tab);
    //         this._tabButtons.push(button);
    //         button.addEventListener(MouseEvent.CLICK, _selectTab);
    //     }
    //     this._viewStack = cast this.getChildAt(this.numChildren - 1);
    //     this.selectTabIdx(0);
    // }//function onCreate()


    // /**
    // * Select the tab and show the content in the ViewStack
    // *
    // */
    // private function _selectTab (ev:Event) {
    //     var selected = 0;
    //     for (i in 0...this._tabButtons.length) {
    //         if (this._tabButtons[i] != cast ev.currentTarget) {
    //             this._tabButtons[i].selected = false;
    //         }
    //         else {
    //             selected = i;
    //         }
    //     }
    //     this.selectTabIdx(selected);
    // }//function _selectTab()


    // /**
    // * Shows the tab and content with given child index
    // *
    // */
    // public function selectTabIdx (idx:Int) {
    //     if (idx >= this._tabButtons.length) {
    //         Err.trigger('Index is greater than Tabs length');
    //     }
    //     if (idx >= this._viewStack.numChildren) {
    //         Err.trigger('Index is greater than the ViewStack length');
    //     }

    //     for (i in 0...this._tabButtons.length) {
    //         if (this._tabButtons[i] != this._tabButtons[idx]) {
    //             this._tabButtons[i].selected = false;
    //         }
    //     }
    //     this._selectedIdx = idx;
    //     this._viewStack.showIdx(idx);
    //     var tab = this._tabButtons[idx];
    //     tab.selected = true;
    //     // tab.highlight();
    // }//function selectTabIdx()


    // /**
    // * Show next tab.
    // * If wrap is true and we are at the end of the stack then
    // * show the first one
    // */
    // public function nextTab () {
    //     var next = this._selectedIdx + 1;
    //     if (next < this._tabButtons.length) {
    //         this.selectTabIdx(next);
    //     }
    //     else if (wrap) {
    //         this.selectTabIdx(0);
    //     }
    // }//function nextTab()


    // /**
    // * Show previous tab.
    // * If wrap is true and we are at the beginning of the stack then
    // * show the last one.
    // */
    // public function previousTab () {
    //     var previous = this._selectedIdx - 1;
    //     if (previous >= 0) {
    //         this.selectTabIdx(previous);
    //     }
    //     else if (wrap) {
    //         this.selectTabIdx(_tabButtons.length - 1);
    //     }
    // }//function previousTab()


    // /**
    // * getter for this._selectedIdx
    // *
    // */
    // private function _getSelectedIdx () : Int {
    //     return this._selectedIdx;
    // }//function _getSelectedIdx()

}