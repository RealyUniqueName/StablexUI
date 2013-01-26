package ru.stablex.ui.misc;

import ru.stablex.ui.widgets.Radio;


/**
* Groups for radio controls
*
*/
class RadioGroup extends List<Radio>{

    /**
    * Get currently selected option for this group
    *
    */
    public inline function getSelected () : Null<Radio> {
        var selected : Radio = null;

        for(option in this){
            if( option.selected ){
                selected = option;
                break;
            }
        }

        return selected;
    }//function getSelected()

}//class RadioGroup