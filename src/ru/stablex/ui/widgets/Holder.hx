package ru.stablex.ui.widgets;

import ru.stablex.ui.layouts.Layout;


/**
* Temporary widget for layout tests.
* Provides layouts support
*
*/
class Holder extends Widget{

    //layout controller
    public var layout : Layout;

/*******************************************************************************
*   STATIC METHODS
*******************************************************************************/



/*******************************************************************************
*   INSTANCE METHODS
*******************************************************************************/

    /**
    * Apply layout settings on refresh
    *
    */
    override public function refresh() : Void {
        super.refresh();
        if( this.layout != null ){
            this.layout.arrangeChildren(this);
        }
    }//function refresh()



/*******************************************************************************
*   GETTERS / SETTERS
*******************************************************************************/



}//class Holder