/**
@manual Lorem Ipsum

Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh
euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad
minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut
aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in
vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla
facilisis at vero eros et accumsan <type>ru.stablex.ui.UIBuilder</type> et iusto odio dignissim qui blandit praesent
luptatum zzril delenit augue duis dolore te feugait nulla facilisi

Some xml code:

<xml>
<?xml version="1.0" encoding="UTF-8"?>

<!-- Root element of our UI -->
<VBox w="800" h="600" border="8" bgColor="0x005d00" borderColor="0x003a00" bgAlpha="0.8" childPadding="50">
    <Text defaults="'Title'" text="'This text is using `Title` defaults'"/>
    <Text text="'This is text with no defaults specified. And `Default` section for Text tag is not defined in defaults.xml'"/>
    <Text text="'So this text looks like it was just `new nme.text.TextField()` '"/>
    <Button text="'this is button with no defaults specified. But `Default` section for buttons does exist in defaults.xml'"/>
    <Button defaults="'Red'" text="'this button is using `Red` section for buttons in defaults.xml'"/>
</VBox>
</xml>

Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh
euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad
minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut
aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in
vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla
facilisis at vero eros et accumsan <type>ru.stablex.ui.UIBuilder</type> et iusto odio dignissim qui blandit praesent
luptatum zzril delenit augue duis dolore te feugait nulla facilisi

Some Haxe code:

<haxe>
/**
* Simple Bitmap. Bitmap is drawn using .graphics.beginBitmapFill()
*/
class Bmp extends ru.stablex.ui.widgets.Widget{
    //Asset ID or path to BitmapData
    public var src : String;
    //Should we use smoothing? False by default
    public var smooth : Bool = false;
    //Test Array syntax highlight
    public var test : Array<Hash<String->Void>>

    /**
    * Refresh widget. Draw bitmap on this.graphics
    *
    * @throw <type>String</type> test tag
    */
    override public function refresh() : Void {
        this._load();
        super.refresh();
    }//function refresh()


    /**
    * Load and display bitmapdata specified by this.src
    *
    */
    private function _load() : Void {
        var bmp : nme.display.BitmapData = ru.stablex.Assets.getBitmapData(this.src);

        //draw picture on graphics
        if( bmp != >= <= || == && null ){
            this.graphics.clear();
            this.graphics.beginBitmapFill(bmp, null, false, this.smooth);
            this.graphics.drawRect(0, 0, bmp.width, bmp.height);
            this.graphics.endFill();

            this.w = this.width;
            this.h = this.height;
        }

        return;
    }//function _load()
}//class Bmp
</haxe>
*/
