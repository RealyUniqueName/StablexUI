package ru.stablex.backend.text;

#if (flash || openfl)

/**
* Text field implementation for flash and openfl targets
*
*/
class TextFieldFlash extends flash.text.TextField{


/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/



/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/

    /**
    * Constructor
    *
    */
    public function new () : Void {
        super();
        this.autoSize  = flash.text.TextFieldAutoSize.LEFT;
        this.multiline = true;
    }//function new()

/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

}//class TextFieldFlash

#end