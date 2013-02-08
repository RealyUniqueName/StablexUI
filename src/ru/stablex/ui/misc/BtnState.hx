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
    public var ico (_getIco,_setIco): Bmp;
    public var _ico : Bmp;
    //skin name for this state (skin must be registered with <type>UIBuilder</type>.regSkins() )
    public var skinName (default,_setSkinName) : String;
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
    private function _getIco () : Bmp {
        //if ico is still not created, create it
        if( this._ico == null ){
            this._ico = UIBuilder.create(Bmp);
        }

        return this._ico;
    }//function _getIco()


    /**
    * Setter for ico
    *
    */
    private function _setIco (ico:Bmp) : Bmp {
        //destroy old ico
        if( this._ico != null ){
            this._ico.free();
        }
        return this._ico = ico;
    }//function _setIco()


    /**
    * Setter for skinName
    *
    */
    private function _setSkinName (s:String) : String {
        this.skin = UIBuilder.skin(s)();
        return this.skinName = s;
    }//function _setSkinName()

}//class BtnState