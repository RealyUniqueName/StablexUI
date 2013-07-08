package ru.stablex.ui.misc;

import ru.stablex.ui.widgets.Bmp;
import ru.stablex.ui.skins.Skin;


/**
* Defines state for <type>ru.stablex.ui.widgets.StateButton</type>: skin, icon and text
*
*/
class BtnState {
    //button label for this state
    public var text : String;
    //icon for this state
    public var ico (get_ico,set_ico): Bmp;
    public var _ico : Bmp;
    //skin name for this state (skin must be registered with <type>UIBuilder</type>.regSkins() )
    public var skinName (default,set_skinName) : String;
    //skin for this state
    public var skin : Skin;


    /**
    * Constructor
    *
    */
    public function new () : Void {
    }//function new()


    /**
    * Getter for ico
    *
    */
    @:noCompletion private function get_ico () : Bmp {
        //if ico is still not created, create it
        if( this._ico == null ){
            this._ico = UIBuilder.create(Bmp);
        }

        return this._ico;
    }//function get_ico()


    /**
    * Setter for ico
    *
    */
    @:noCompletion private function set_ico (ico:Bmp) : Bmp {
        //destroy old ico
        if( this._ico != null ){
            this._ico.free();
        }
        return this._ico = ico;
    }//function set_ico()


    /**
    * Setter for skinName
    *
    */
    @:noCompletion private function set_skinName (s:String) : String {
        this.skin = UIBuilder.skin(s)();
        return this.skinName = s;
    }//function set_skinName()

}//class BtnState