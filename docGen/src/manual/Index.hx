/**
@manual Getting started

Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh
euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad
minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut
aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in
vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla
facilisis at vero eros et accumsan <type>ru.stablex.ui.UIBuilder</type> et iusto odio dignissim qui blandit praesent
luptatum zzril delenit augue duis dolore te feugait nulla facilisi

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
*/
