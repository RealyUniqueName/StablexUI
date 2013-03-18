package ru.stablex.ui.widgets;



/**
* Simple <type>StateButton</type> with two states expected: "up" and "down"
*
*/
class Toggle extends StateButton{
    //should we `.highlight()` the text when button is toggled?
    public var highlightOnSelect : Bool = false;
    //whether button is in down/selected state
    public var selected (get,set) : Bool;


    /**
    * Constructor. Set `.order` = ['up', 'down'] by default.
    *
    */
    public function new () : Void {
        super();
        this.order = ["up", "down"];
        this.selected = false;
    }//function new()


    /**
    * Getter for `.selected`
    *
    */
    private function get_selected () : Bool {
        return this.state == 'down';
    }//function get_selected()


    /**
    * Setter for `.selected`
    *
    */
    private function set_selected (s:Bool) : Bool {
        if( s ){
            this.down();
        }else{
            this.up();
        }

        return s;
    }//function set_selected()


    /**
    * Set "up" state
    *
    */
    public function up () : Void {
        this.set('up');
    }//function up()


    /**
    * Set "down" state
    *
    */
    public function down () : Void {
        this.set('down');
    }//function down()


    /**
    * Alias for <type>StateButton</type>.nextState()
    *
    */
    public function toggle () : Void {
        this.nextState();
    }//function toggle()


    /**
    * Handle `.highlightOnSelect` on refresh
    *
    */
    override public function refresh() : Void {
        if( this.highlightOnSelect && this.state == 'down' ){
            this.highlight();
        }else if( this.highlightOnSelect ){
            this.unhighlight();
        }
        super.refresh();
    }//function refresh()


}//class Toggle