package ru.stablex.ui.widgets;

import flash.display.DisplayObject;
import ru.stablex.ui.skins.Skin;
import ru.stablex.ui.UIBuilder;
import flash.events.MouseEvent;
import flash.events.MouseEvent;


/**
* Simple button
*/
class Button extends Text{

    //whether button is currently pressed
    public var pressed (default,null) : Bool = false;
    //Wether mouse pointer is currently over this button
    public var hovered (default,null) : Bool = false;
    //default icon for button
    public var ico (get_ico,set_ico): Bmp;
    private var _ico : Bmp;
    //icon for hovered state
    public var icoHovered (get_icoHovered,set_icoHovered) : Bmp;
    private var _icoHovered : Bmp;
    //icon for pressed state
    public var icoPressed (get_icoPressed,set_icoPressed) : Bmp;
    private var _icoPressed : Bmp;
    //whether icon should appear before text (on left or on top of text), set to false to move icon to the right (or below) text
    public var icoBeforeLabel (default,set_icoBeforeLabel) : Bool = true;
    //skin name for hovered state (skin must be registered with <type>UIBuilder</type>.regSkins() )
    public var skinHoveredName (default,set_skinHoveredName) : String;
    //skin for hovered state
    public var skinHovered : Skin;
    //skin name for pressed state (skin must be registered with <type>UIBuilder</type>.regSkins() )
    public var skinPressedName (default,set_skinPressedName) : String;
    //skin for pressed state
    public var skinPressed : Skin;
    //to test whether we trying to apply already applied skin
    private var _appliedSkin : Skin;
    //stick ico and text to opposite borders
    public var apart : Bool = false;


    /**
    * We use wrappers so if we assign another functions to instance methods like .onPress, we don't need to reaply eventListeners
    * {
    */
        /**
        * wrapper for hover
        *
        */
        static private function _onHover (e:MouseEvent) : Void {
            var btn : Button = cast(e.currentTarget, Button);

            //if button is already hovered, do nothing
            if( btn.hovered ) return;

            //switch icon
            btn._switchIco(btn._icoHovered);

            //switch skin
            btn._switchSkin(btn.skinHovered);

            btn.hovered = true;
            btn.onHover(e);
        }//function _onHover()


        /**
        * wrapper for hout
        *
        */
        static private function _onHout (e:MouseEvent) : Void {
            var btn : Button = cast(e.currentTarget, Button);

            //if button is not hovered, do nothing
            if( !btn.hovered ) return;

            //switch icon
            btn._switchIco(btn._ico);

            //switch skin
            btn._switchSkin(btn.skin);

            btn.hovered = false;
            btn.onHout(e);
        }//function _onHout()


        /**
        * wrapper for press
        *
        */
        static private function _onPress (e:MouseEvent) : Void {
            var btn : Button = cast(e.currentTarget, Button);

            //if button is already pressed, do nothing
            if( btn.pressed ) return;

            //switch icon
            btn._switchIco(btn._icoPressed);

            //switch skin
            btn._switchSkin(btn.skinPressed);

            btn.pressed = true;
            btn.onPress(e);
        }//function _onPress()


        /**
        * wrapper for release
        *
        */
        static private function _onRelease (e:MouseEvent) : Void {
            var btn : Button = cast(e.currentTarget, Button);

            //if button is not pressed, do nothing
            if( !btn.pressed ) return;

            //switch icon
            if( btn.hovered ){
                btn._switchIco(btn._icoHovered);
            }else{
                btn._switchIco(btn._ico);
            }

            //switch skin
            if( btn.hovered ){
                btn._switchSkin(btn.skinHovered);
            }else{
                btn._switchSkin(btn.skin);
            }

            btn.pressed = false;
            btn.onRelease(e);
        }//function _onRelease()
    /*
    * } wrappers
    **/


    /**
    * Constructor
    * By default `.padding` = 2, `.childPadding` = 5 and `.mouseChildren` = false
    */
    public function new () : Void{
        super();

        this.vertical = false;

        this.padding          = 2;
        this.childPadding     = 5;
        this.label.selectable = false;

        this.buttonMode    = this.useHandCursor = true;
        this.mouseChildren = false;

        //process interactions with mouse pointer
        this.addEventListener(MouseEvent.MOUSE_OVER, Button._onHover);
        this.addEventListener(MouseEvent.MOUSE_OUT, Button._onHout);
        this.addEventListener(MouseEvent.MOUSE_DOWN, Button._onPress);
        this.addEventListener(MouseEvent.MOUSE_OUT, Button._onRelease);
        this.addEventListener(MouseEvent.MOUSE_UP, Button._onRelease);
        #if mobile
            this.addEventListener(flash.events.TouchEvent.TOUCH_OUT, Button._onHout);
            this.addEventListener(flash.events.TouchEvent.TOUCH_OUT, Button._onRelease);
        #end

        this.pressed = false;
        this.hovered = false;

        this.align = "center,middle";
    }//function new()


    /**
    * Process pressing. By defualt moves widget by 1px down
    *
    */
    public dynamic function onPress (e:MouseEvent) : Void {
        // var btn : Button = cast(e.currentTarget, Button);

        // btn.y ++;
    }//function onPress()


    /**
    * Process releasing. By defualt moves widget by 1px up
    *
    */
    public dynamic function onRelease (e:MouseEvent) : Void {
        // var btn : Button = cast(e.currentTarget, Button);

        // btn.y --;
    }//function onRelease()


    /**
    * Process hover. By default does nothing
    *
    */
    public dynamic function onHover (e:MouseEvent) : Void {

    }//function ononHover()


    /**
    * Process hout. By default does nothing
    *
    */
    public dynamic function onHout (e:MouseEvent) : Void {

    }//function onHout()


    /**
    * Setter for `.icoBeforeLabel`
    *
    */
    @:noCompletion private function set_icoBeforeLabel(ibl:Bool) : Bool {
        if( ibl ){
            this.setChildIndex(this.label, this.numChildren - 1);
        }else{
            this.setChildIndex(this.label, 0);
        }
        return this.icoBeforeLabel = ibl;
    }//function set_icoBeforeLabel()


    /**
    * Getter for ico
    *
    */
    @:noCompletion private function get_ico () : Bmp {
        //if ico is still not created, create it
        if( this._ico == null ){
            this._ico = UIBuilder.create(Bmp);
            this._addIco(this._ico);
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
        //add new ico
        if( ico != null ){
            this._addIco(ico);
        }
        return this._ico = ico;
    }//function set_ico()


    /**
    * Getter for icoHovered
    *
    */
    @:noCompletion private function get_icoHovered () : Bmp {
        //if ico is still not created, create it
        if( this._icoHovered == null ){
            this._icoHovered = UIBuilder.create(Bmp);
            this._icoHovered.visible = false;
            this._addIco(this._icoHovered);
        }

        return this._icoHovered;
    }//function get_icoHovered()


    /**
    * Setter for icoHovered
    *
    */
    @:noCompletion private function set_icoHovered (ico:Bmp) : Bmp {
        //destroy old ico
        if( this._icoHovered != null ){
            this._icoHovered.free();
        }
        //add new ico
        if( ico != null ){
            this._addIco(ico);
        }
        return this._icoHovered = ico;
    }//function set_icoHovered()


    /**
    * Getter for icoPressed
    *
    */
    @:noCompletion private function get_icoPressed () : Bmp {
        //if ico is still not created, create it
        if( this._icoPressed == null ){
            this._icoPressed = UIBuilder.create(Bmp);
            this._icoPressed.visible = false;
            this._addIco(this._icoPressed);
        }

        return this._icoPressed;
    }//function get_icoPressed()


    /**
    * Setter for icoPressed
    *
    */
    @:noCompletion private function set_icoPressed (ico:Bmp) : Bmp {
        //destroy old ico
        if( this._icoPressed != null ){
            this._icoPressed.free();
        }
        //add new ico
        if( ico != null ){
            this._addIco(ico);
        }
        return this._icoPressed = ico;
    }//function set_icoPressed()


    /**
    * Setter for skinHoveredName
    *
    */
    @:noCompletion private function set_skinHoveredName (s:String) : String {
        this.skinHovered = UIBuilder.skin(s)();
        return this.skinHoveredName = s;
    }//function set_skinHoveredName()


    /**
    * Setter for skinPressedName
    *
    */
    @:noCompletion private function set_skinPressedName (s:String) : String {
        this.skinPressed = UIBuilder.skin(s)();
        return this.skinPressedName = s;
    }//function set_skinPressedName()


    /**
    * Adds icon object to the button's display list according to `icoBeforeLabel` property
    *
    */
    private inline function _addIco (ico:Bmp) : Void {
        if( this.icoBeforeLabel ){
            this.addChildAt(ico, 0);
        }else{
            this.addChild(ico);
        }
    }//function _addIco()


    /**
    * Switches visibility of icons
    *
    */
    private inline function _switchIco (ico:Bmp) : Void {
        if( this._ico        != null ) this._ico.visible = false;
        if( this._icoHovered != null ) this._icoHovered.visible = false;
        if( this._icoPressed != null ) this._icoPressed.visible = false;

        if( ico != null ){
            ico.visible = true;
        }else if( this._ico != null ){
            this._ico.visible = true;
        }

        this.alignElements();
    }//function _switchIco()


    /**
    * Apply provided skin to this button
    *
    */
    private inline function _switchSkin (skin:Skin) : Void {
        if( this._appliedSkin != skin && skin != null ){
            skin.apply(this);
            this._appliedSkin = skin;
        }else if( skin == null && this.skin != null ){
            this.skin.apply(this);
            this._appliedSkin = skin;
        }
    }//function _switchSkin()


    /**
    * Refresh widget. Also refreshes icons
    *
    */
    override public function refresh () : Void {
        this._appliedSkin = this.skin;

        if( this._ico        != null ) this._ico.refresh();
        if( this._icoHovered != null ) this._icoHovered.refresh();
        if( this._icoPressed != null ) this._icoPressed.refresh();

        super.refresh();
    }//function refresh()


    /**
    * Align elements according to this.align
    *
    */
    override public function alignElements () : Void {
        super.alignElements();

        if( this.apart ){
            this._moveApart();
        }
    }//function alignElements()


    /**
    * Move ico and label to opposite borders
    *
    */
    private inline function _moveApart () : Void {
        var child : DisplayObject;

        //ico to the left border, label to the right border
        if( this.icoBeforeLabel ){
            //there can be several icons for different states
            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                //if this is Bmp, consider it icon
                if( Std.is(child, Bmp) ){
                    cast(child, Bmp).left = this.paddingLeft;
                }
            }

            Box._setObjX(this.label, this._width -  this.paddingRight - Box._objWidth(this.label));

        //ico to the right border, label to the left border
        }else{
            //there can be several icons for different states
            for(i in 0...this.numChildren){
                child = this.getChildAt(i);
                //if this is Bmp, consider it icon
                if( Std.is(child, Bmp) ){
                    cast(child, Bmp).right = this.paddingRight;
                }
            }

            Box._setObjX(this.label, this.paddingLeft);
        }
    }//function _moveApart()

}//class Button