package;


/**
* Simple custom widget. Background color of this widget is defined by .color property.
*
*/
class ColorWidget extends ru.stablex.ui.widgets.Widget{

    //property to define background color. By default it's black
    public var color : Int = 0x000000;


    /**
    * If you need to do something in constructor, here is how it's done.
    *
    */
    public function new () : Void {
        super();

        //any code, you need

    }//function new()


    /**
    * This function is called at least once - on widget creation is complete.
    * For this widget we want to update background color on refresh.
    */
    override public function refresh () : Void {
        super.refresh();
        this._paintBackground();
    }//function refresh()


    /**
    * This function fills background with defined by `color` property color
    *
    */
    private function _paintBackground () : Void {
        this.graphics.clear();
        this.graphics.beginFill(this.color);
        this.graphics.drawRect(0, 0, this.w, this.h);
        this.graphics.endFill();
    }//function _paintBackground()
}//class ColorWidget