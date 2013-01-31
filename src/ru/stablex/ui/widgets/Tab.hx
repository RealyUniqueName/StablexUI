package ru.stablex.ui.widgets;

import nme.events.MouseEvent;
import ru.stablex.ui.misc.RadioGroup;


/**
* Basic Tab control
* This should be used in conjunction with the TabStack, see the sample for how to use it
*
*/
class Tab extends Checkbox{
    

    /**
    * Set specified state. On select we should unselect other options in group
    *
    */
    override public function set (state:String) : Void {
        super.set(state);
    }//function set()


    /**
    * Set next state
    *
    */
    override public function nextState (e:MouseEvent = null) : Void {
        if( this.selected ) return;

        //order must be defined
        if( this.order == null || this.order.length == 0 ) return;

        super.nextState(e);

    }//function nextState()


    /**
    * On radio desrtoy, remove it from group
    *
    */
    override public function free (recursive:Bool = true) : Void {
        super.free(recursive);
    }//function free()
}//class Radio