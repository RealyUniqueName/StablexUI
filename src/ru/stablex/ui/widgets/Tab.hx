package ru.stablex.ui.widgets;

import nme.events.MouseEvent;
import ru.stablex.ui.misc.RadioGroup;


/**
* Basic Tab control
* This should be used in conjunction with the TabStack, see the sample for how to use it
*/
class Tab extends Widget{

    //title for tab
    public var title : Checkbox;


    /**
    * On destroy, free `.title` as well
    *
    */
    override public function free (recursive:Bool = true) : Void {
        this.title.free();
        super.free(recursive);
    }//function free()


    // /**
    // * Set specified state. On select we should unselect other options in group
    // *
    // */
    // override public function set (state:String) : Void {
    //     super.set(state);
    // }//function set()


    // /**
    // * Set next state
    // *
    // */
    // override public function nextState (e:MouseEvent = null) : Void {
    //     if( this.selected ) return;

    //     //order must be defined
    //     if( this.order == null || this.order.length == 0 ) return;

    //     super.nextState(e);

    // }//function nextState()


    // /**
    // * On radio desrtoy, remove it from group
    // *
    // */
    // override public function free (recursive:Bool = true) : Void {
    //     super.free(recursive);
    // }//function free()


    // /**
    // * Setter for `.selected`
    // *
    // */
    // override private function _setSelected (s:Bool) : Bool {
    //     super._setSelected(s);

    //     if( s == true ){
    //         this.highlight();
    //     }else{
    //         this.unhighlight();
    //     }

    //     return s;
    // }//function _setSelected()
}//class Radio