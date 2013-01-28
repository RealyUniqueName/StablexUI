package ru.stablex.ui;

/**
* Structure to describe skins
*/
typedef TSkin = {
    //Asset ID of bitmapData. Will be used with Assets.getBitmapData(here)
    bmp    : String,
    /**
    * Describes skinning method. This array should contain zero, one, two or four integers.
    * Zero - 3 slice scaling (horizontal). Bitmap is divided into two equal sized bitmaps. Middle part is filled with central column of pixels.
    * One - 3 slice scaling (horizontal). Bitmap is divided into two bitmaps. Middle part is filled with column of pixels with x = specified integer.
    * Two - 3 slice scaling (horizontal). Integers - left and right guidelines for slicing
    * Four - 9 slice scalign. Integers - vertical left, vertical right, horizontal top, horizontal bottom
    */
    slices : Array<Int>
}