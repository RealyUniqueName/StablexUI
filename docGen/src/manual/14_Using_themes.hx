/**
@manual Using themes

Using themes is easy. Choose any theme you want (only one is available atm: ru.stablex.ui.themes.android4)
and add it to your initialization code before <type>ru.stablex.ui.UIBuilder</type>.init()

<haxe>
 ru.stablex.ui.UIBuilder.setTheme('ru.stablex.ui.themes.android4');
 ru.stablex.ui.UIBuilder.init();
</haxe>

That's it. Now by default your widgets will have properties defined by selected theme.
You can see some widgets with `android4` theme <a href="/demo/androidTheme.swf" target="_blank">here</a> (<a href="https://github.com/RealyUniqueName/StablexUI/tree/master/samples/themes" target="_blank">source</a>).

Themes in StablexUI are self-contained. It means you don't need to copy any assets to your project
or perform any additional actions except <type>ru.stablex.ui.UIBuilder</type>.setTheme()
All the job will be done by macros. And theme resources will be embed in your compiled binary, so your
own assets directory will stay clean.

*/
