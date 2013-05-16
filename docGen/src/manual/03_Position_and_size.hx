/**
@manual Size

Widget's size can be defined in pixels and in % of parent's size.
Here are properties to set widget area:
    .w        - set widget width in pixels (if you use .width property, you just scale widget along x-axis);
    .h        - set widget height in pixels;
    .widhtPt  - set widget width in % of parent's width (works only if parent is a widget too);
    .heightPt - set widget height in % of parent's height (works only if parent is a widget too).
Play with following demo in <a href="/demo/03_size.swf" target="_blank">flash</a> or in <a href="/demo/03_size" target="_blank">html5</a> to understand sizing.
You can find full source of this demo on <a href="https://github.com/RealyUniqueName/StablexUI" target="_blank">GitHub</a> in samples/03_size/
*/

/**
@manual Position

StablexUI supports absolute position (in pixels) and relative position (in % of parent's size) for widgets.
These are widget properties to specify position in pixels:
    .left   - set widget position by it's left border in pixels (analog of .x);
    .top    - set widget position by top border in pixels (analog of .y);
    .right  - set position by right border (distance from widget's right border to parent's right border);
    .bottom - set position by bottom border (distance from widget's bottom border to parent's bottom border).
Note that .right and .bottom properties work only if widget's .parent is a widget too.
If .parent is a widget, following properties will also work:
    .leftPt   - set position by left border in % of parent's width (the distance from parent's left
                border to widget left border is specified by .leftPt % of parent's width)
    .rightPt  - set position by right border in % of parent's width;
    .topPt    - set position by top border in % of parent's height;
    .bottomPt - set position by bottom border in % of parent's height.
Play with following demo in <a href="/demo/03_position.swf" target="_blank">flash</a> or in <a href="/demo/03_position" target="_blank">html5</a> to understand positioning.
You can find full source of this demo on <a href="https://github.com/RealyUniqueName/StablexUI" target="_blank">GitHub</a> in samples/03_position/
*/