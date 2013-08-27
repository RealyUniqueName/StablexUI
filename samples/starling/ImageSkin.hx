package;

import ru.stablex.Assets;
import ru.stablex.ui.skins.Skin;
import ru.stablex.ui.widgets.Widget;
import starling.textures.Texture;


/**
* Simple skin using starling.display.Image.
* Once set bitmap cannot be changed
*
*/
class ImageSkin extends Skin{

    /** description */
    public var src (default,set) : String = null;
    /** description */
    private var _texture : Texture;

/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/



/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/

    /**
    * Draw skin
    *
    */
    override public function draw (w:Widget) : Void {
        w.setGraphics(this._texture);
        w.resize(this._texture.width, this._texture.height);
    }//function draw()

/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

    /**
    * Setter `src`.
    *
    */
    private function set_src (src:String) : String {
        this._texture = Texture.fromBitmapData(Assets.getBitmapData(src));
        return this.src = src;
    }//function set_src

}//class ImgSkin