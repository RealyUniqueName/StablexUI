package ru.stablex.ui.widgets;



/**
* Simple <type>StateButton</type> with two states expected: "up" and "down"
*
* @dispatch <type>ru.stablex.ui.events.WidgetEvent</type>.CHANGE - on state change
*/
class Toggle extends StateButton{
    //should we `.highlight()` the text when button is toggled?
    public var highlightOnSelect : Bool = false;
    //whether button is in down/selected state
    public var selected (get_selected,set_selected) : Bool;


    /**
    * Constructor. Set `.order` = ['up', 'down'] by default.
    *
    */
    public function new () : Void {
        super();
        this.order = ["up", "down"];
    }//function new()


    /**
    * Getter for `.selected`
    *
    */
    @:noCompletion private function get_selected () : Bool {
        return this.state == 'down';
    }//function get_selected()


    /**
    * Setter for `.selected`
    *
    */
    @:noCompletion private function set_selected (s:Bool) : Bool {
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
            this.highlighted = true;
        }else if( this.highlightOnSelect ){
            this.highlighted = false;
        }

        super.refresh();
    }//function refresh()


}//class Toggle