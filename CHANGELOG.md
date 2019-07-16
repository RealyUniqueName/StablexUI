1.2.4
---
* Fix RTXml when the root node has `defaults` attribute ([#283]https://github.com/RealyUniqueName/StablexUI/issues/283)

1.2.3
---
* Fixed access to registered classes in xml attributes for RTXml ([#47]https://github.com/RealyUniqueName/StablexUI/issues/47)

1.2.2
---
* Haxe 4 compatibility

1.2.1
---
* Changing `Text.text` now fires `WidgetEvent.TEXT_CHANGE` event.
* Allow spaces between words in `Widget.defaults` property.
* Compatibility with latest Haxe and OpenFL.

1.2.0
---
* Changed UIBuilder.create() to accept widget constructor arguments as third parameter (PR [#228](https://github.com/RealyUniqueName/StablexUI/pull/228))
* ru.stablex.ui.skins.Slice3.vertical property (PR [#229](https://github.com/RealyUniqueName/StablexUI/pull/229))
* ru.stablex.ui.widgets.Slider.step property (PR [#219](https://github.com/RealyUniqueName/StablexUI/pull/219))
* Fix [#222](https://github.com/RealyUniqueName/StablexUI/issues/222): properly resize Box on refresh to maintain `right` and `bottom` settings
* Fix [#223](https://github.com/RealyUniqueName/StablexUI/issues/223): skip private methods in themes Skins class.
