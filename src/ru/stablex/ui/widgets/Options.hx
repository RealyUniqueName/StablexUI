package ru.stablex.ui.widgets;

import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.Lib;
import ru.stablex.ui.events.WidgetEvent;
import ru.stablex.ui.skins.Skin;



/**
* Simple options box.
* E.g. drop-down. Or list can appear fullscreen - `phone`-style. See samples/optionsList on github.
* <type>ru.stablex.ui.widgets.Button</type> widget is used to render options in list.
*/
class Options extends Button{
    /**
    * Array of title=>value pairs. Like [['red', 0xFF0000], ['green', 0x00FF00], ['blue', 0x0000FF]]
    * First element in these pairs must be of <type>String</type> type.
    * First option is selected by default
    */
    public var options (default,set_options) : Array<Array<Dynamic>>;
    //List wich appears when control is clicked
    public var list : Floating;
    //box is a child for `.list` and contains buttons for each option
    public var box : Box;
    //Currently selected value. If you try to set value wich is not in the `.options`, than `.value` won't be changed
    public var value (get_value,set_value) : Dynamic;
    //defaults for options in list (each option is a <type>Toggle</type> widget)
    public var optionDefaults : String = 'Default';
    //If this is true. List position will be overriden to make list appear under this control
    public var alignList : Bool = true;

    //if `rebuildList` is true, options list will be rebuilt before next show
    public var rebuildList : Bool = true;
    //currently selected option index in `.options`
    private var _selectedIdx (default,set__selectedIdx) : Int = 0;


    /**
    * Constructor
    *
    */
    public function new () : Void {
        super();

        this.list = UIBuilder.create(Floating);
        this.box = UIBuilder.create(Box);
        this.list.addChild(this.box);

        this.box.unifyChildren = true;

        this.addEventListener(MouseEvent.CLICK, this.toggleList);
        this.list.addEventListener(MouseEvent.CLICK, this.toggleList);
    }//function new()


    /**
    * Setter for `._selectedIdx`
    * @dispatch <type>ru.stablex.ui.events.WidgetEvent</type>.CHANGE
    */
    @:noCompletion private function set__selectedIdx (idx:Int) : Int {
        if( idx != this._selectedIdx ){
            this.rebuildList = true;
            this._selectedIdx = idx;
            this.text = this.options[idx][0];
            this.dispatchEvent(new WidgetEvent(WidgetEvent.CHANGE));
        }
        return idx;
    }//function set__selectedIdx()


    /**
    * Setter for `.options`
    *
    */
    @:noCompletion private function set_options (o:Array<Array<Dynamic>>) : Array<Array<Dynamic>> {
        if( o == null || o.length == 0 ){
            Err.trigger('Option list must not be null or empty');
        }

        //check options are correct
        for(i in 0...o.length){
            if( o[i].length != 2 || !Std.is(o[i][0], String) ){
                Err.trigger('Wrong options list format. Should be [[String,Dynamic], [String,Dynamic], ...] instead of ' + Std.string(o));
            }
        }

        this.rebuildList  = true;
        this._selectedIdx = 0;
        this.text         = o[ this._selectedIdx ][0];

        return this.options = o;
    }//function set_options()


    /**
    * Getter for `.value`
    *
    */
    @:noCompletion private function get_value () : Dynamic {
        if(
            this.options == null
            || this.options.length <= this._selectedIdx
        ){
            return null;
        }else{
            return this.options[ this._selectedIdx ][1];
        }
    }//function get_value()


    /**
    * Setter for `.value`
    *
    */
    @:noCompletion private function set_value (v:Dynamic) : Dynamic {
        if( this.options != null ){
            for(i in 0...this.options.length){
                if( this.options[i][1] == v ){
                    this._selectedIdx = i;
                    break;
                }
            }
        }

        return v;
    }//function set_value()


    /**
    * Show options list
    *
    */
    public function toggleList (e:MouseEvent = null) : Void {
        //if list is shown, hide it
        if( this.list.shown ){
            this.list.hide();

        //show list
        }else{
            if( this.rebuildList ){
                this._buildList();
                this.rebuildList = false;
            }

            if( this.alignList ){
                var rect : Rectangle = this.getRect(Lib.current);
                this.list.left = rect.x + (this.w - this.list.w) / 2;
                this.list.top  = rect.y + this.h;

                //keep the list inside stage bounds{
                    if( this.list.left + this.list.w > Lib.current.stage.stageWidth ){
                        this.list.left = Lib.current.stage.stageWidth - this.list.w;
                    }else if( this.list.left < 0 ){
                        this.list.left = 0;
                    }

                    if( this.list.top + this.list.h > Lib.current.stage.stageHeight ){
                        this.list.top = Lib.current.stage.stageHeight - this.list.h;
                    }else if( this.list.top < 0 ){
                        this.list.top = 0;
                    }
                //}
            }

            //always render list on top of the stage
            this.list.renderTo = null;
            this.list.show();
        }
    }//function toggleList()


    /**
    * Build list based on `.options`
    *
    */
    private function _buildList () : Void {
        if( this.options == null ) return;

        this.box.freeChildren();

        for(i in 0...this.options.length){
            this.box.addChild(UIBuilder.create(Toggle, {
                defaults : this.optionDefaults,
                selected : (this._selectedIdx == i),
                name     : Std.string(i),
                text     : this.options[i][0],
            })).addEventListener(MouseEvent.CLICK, this._onSelectOption);
        }

        this.box.refresh();
        this.list.refresh();
    }//function _buildList()


    /**
    * Process option selection
    *
    */
    private function _onSelectOption (e:MouseEvent) : Void {
        var obj : Button = cast e.currentTarget;

        if( obj != null ){
            var idx : Int = Std.parseInt(obj.name);
            if( this.options != null && this.options.length > idx ){
                this._selectedIdx = idx;
            }
        }
    }//function _onSelectOption()


    /**
    * Destroy widget and list
    *
    */
    override public function free (recursive:Bool = true) : Void {
        this.list.free();
        super.free(recursive);
    }//function free()
}//class Options