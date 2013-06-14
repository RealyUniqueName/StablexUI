package ru.stablex.ui.widgets;

import flash.display.DisplayObject;
import flash.events.MouseEvent;
import ru.stablex.Err;
import ru.stablex.ui.widgets.StateButton;
import ru.stablex.ui.widgets.ViewStack;

/**
* The TabStack is comprised of a set of <type>TabPage</type>s.
* Only one tab can be selected at a time.
*
*/

class TabStack extends Box{

    //widget, wich will contain tabs headers
    public var tabBar : Box;
    // wrap the stack list or not (for `.next()` calls)
    public var wrap : Bool = false;
    //group name for tabs' titles
    private var _radioGroupName : String;


    /**
    * Constructor. AutoSize is disabled. Default size - 100x100
    *
    */
    public function new() : Void {
        super();

        this.w = this.h = 100;

        this.tabBar = UIBuilder.create(Box, {
            widthPt    : 100,
            autoHeight : true,
            vertical   : false,
            align      : 'left,bottom'
        });
        this.addChild(this.tabBar);
    }//function new()


    /**
    * On initialization is complete
    * @private
    */
    override public function onInitialize() : Void {
        this._radioGroupName = 'TABSTACK_TITLES_' + this.id;
        super.onInitialize();
    }//function onInitialize()



    /**
    * On creation is complete, make first tab active
    *
    */
    override public function onCreate() : Void {
        super.onCreate();

        var child : DisplayObject;
        for(i in 0...this.numChildren){
            child = this.getChildAt(i);
            if( Std.is(child, TabPage) ){
                cast(child, TabPage).title.selected = true;
                break;
            }
        }
    }//function onCreate()


    /**
    * Refresh widget. Also refresh `.tabBar`
    *
    */
    override public function refresh() : Void {
        this.tabBar.refresh();

        //update tabs {
            var tab   : TabPage;
            var child : DisplayObject;
            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                if( Std.is(child, TabPage) ){
                    tab = cast(child, TabPage);

                    //resize active tab to fit TabStack size
                    if( tab.title.selected == true ){
                        tab.visible = true;

                        //resize tab if needed
                        if(
                            tab.w != this.w - this.paddingLeft - this.paddingRight
                            || tab.h != this.h - this.tabBar.h - this.paddingTop - this.paddingBottom
                        ){
                            tab.resize(this.w - this.paddingLeft - this.paddingRight, this.h - this.tabBar.h - this.paddingTop - this.paddingBottom);
                        }

                    //hide inactive tabs
                    }else{
                        tab.visible = false;
                    }

                }//if()
            }//for( tabs )
        //}

        super.refresh();
    }//function refresh()


    /**
    * Returns currently active tab
    *
    */
    public function activeTab() : Null<TabPage> {
        var tab   : TabPage;
        var child : DisplayObject;

        for(i in 0...this.numChildren){
            child = this.getChildAt(i);
            if( !Std.is(child, TabPage) ) continue;

            tab = cast(child, TabPage) ;
            if( tab != null && tab.title.selected ){
                return tab;
            }
        }

        return null;
    }//function activeTab()



    /**
    * Handle tabs selection
    *
    */
    private function _onChange(e:MouseEvent) : Void {
        this.refresh();
    }//function _onChange()


    /**
    * Add child. Only instances of <type>TabPage</type> allowed.
    * @throw <type>String</type> if child is not instance of <type>TabPage</type>
    */
    override public function addChild (child:DisplayObject) : DisplayObject {
        if( this.initialized ){
            if( !Std.is(child, TabPage) ){
                Err.trigger('Only instances of ru.stablex.ui.widgets.TabPage can be children of ru.stablex.ui.widgets.TabStack');
            }

            //add tab's title to `.tabBar`
            var tab : TabPage = cast(child, TabPage);
            tab.visible = false;
            if( tab.title.parent != this.tabBar ){
                tab.title.group = this._radioGroupName;
                this.tabBar.addChild(tab.title);
            }

            //listen for tab selection
            tab.title.addUniqueListener(MouseEvent.CLICK, this._onChange);
        }
        return super.addChild(child);
    }//function addChild()


    /**
    * Add child at specified index.
    * Only instances of <type>TabPage</type> allowed.
    * @throw <type>String</type> if child is not instance of <type>TabPage</type>
    */
    override public function addChildAt (child:DisplayObject, idx:Int) : DisplayObject {
        if( this.initialized ){
            if( !Std.is(child, TabPage) ){
                Err.trigger('Only instances of ru.stablex.ui.widgets.Tab can be children of ru.stablex.ui.widgets.TabStack');
            }

            //add tab's title to `.tabBar`
            var tab : TabPage = cast(child, TabPage);
            tab.visible = false;
            if( tab.title.parent != this.tabBar ){
                tab.title.group = this._radioGroupName;
                this.tabBar.addChild(tab.title);
            }

            //listen for tab selection
            tab.title.addUniqueListener(MouseEvent.CLICK, this._onChange);
        }
        return super.addChildAt(child, idx);
    }//function addChildAt()


    /**
    * Remove child.
    *
    */
    override public function removeChild(child:DisplayObject) : DisplayObject {
        if( Std.is(child, TabPage) ){
            child.removeEventListener(MouseEvent.CLICK, this._onChange);
            this.tabBar.removeChild(cast(child, TabPage).title);
        }
        return super.removeChild(child);
    }//function removeChild()


    /**
    * Remove child at specified index.
    *
    */
    override public function removeChildAt(idx:Int) : DisplayObject {
        var child : DisplayObject = super.removeChildAt(idx);
        if( Std.is(child, TabPage) ){
            child.removeEventListener(MouseEvent.CLICK, this._onChange);
            this.tabBar.removeChild(cast(child, TabPage).title);
        }
        return child;
    }//function removeChildAt()


    /**
    * Show next tab.
    * If `.wrap` is true and we are at the end of the stack then
    * show the first one
    */
    public inline function nextTab () : Void {
        this._showByOrder(true);
    }//function nextTab()


    /**
    * Show previous tab.
    * If `.wrap` is true and we are at the beginning of the stack then
    * show the last one.
    */
    public inline function previousTab () : Void {
        this._showByOrder(false);
    }//function previousTab()


    /**
    * Show next or previous tab
    *
    */
    private function _showByOrder(next:Bool = true) : Void {
        //find current tab index
        var current : TabPage = this.activeTab();
        var idx : Int = (next ? -1 : this.numChildren);
        if( current != null ){
            idx = this.getChildIndex(current);
        }

        //show next tab
        if( this.numChildren > 1 ){ //at least one children exists - `.tabBar`. We need another one - TabPage - to iterate through tabs
            var child : DisplayObject;

            while( true ){
                idx += (next ? 1 : -1);
                if( idx >= this.numChildren ){
                    if( !this.wrap ) break;
                    idx = 0;
                }else if( idx < 0 ){
                    if( !this.wrap ) break;
                    idx = this.numChildren - 1;
                }

                child = this.getChildAt(idx);
                if( Std.is(child, TabPage) ){
                    cast(child, TabPage).title.selected = true;
                    this.refresh();
                    break;
                }
            }//while()
        }//if()
    }//function _showByOrder()


    /**
    * Show tab with specified name
    * @return false, if tab with such name was not found
    */
    public function showByName(name:String) : Bool {
        var tab   : TabPage = null;
        var child : DisplayObject;

        //look for tab with specified name
        for(i in 0...this.numChildren){
            child = this.getChildAt(i);
            if( child.name == name && Std.is(child, TabPage) ){
                tab = cast(child, TabPage);
                break;
            }
        }

        //if tab was found, show it
        if( tab == null ){
            return false;
        }else{
            tab.title.selected = true;
            this.refresh();
            return true;
        }
    }//function showByName()


}//class TabStack