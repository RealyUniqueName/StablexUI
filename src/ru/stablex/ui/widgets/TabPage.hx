package ru.stablex.ui.widgets;


/**
* Basic TabPage control.
* This should be used in conjunction with the <type>TabStack</type>, see the sample for how to use it.
* Specifying tab's size is absolute, because <type>TabStack</type> resizes tab to fit <type>TabStack</type>'s size
*/
class TabPage extends Widget{

    //title for tab
    public var title : Radio;


    /**
    * Constructor
    *
    */
    public function new() : Void {
        super();
        this.title = UIBuilder.create(Radio);
        this.title.buttonMode = this.title.useHandCursor = true;
        this.title.mouseChildren = false;
    }//function new()


    /**
    * On destroy, free `.title` as well
    *
    */
    override public function free (recursive:Bool = true) : Void {
        this.title.free();
        super.free(recursive);
    }//function free()

}//class TabPage