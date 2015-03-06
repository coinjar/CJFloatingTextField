<p align="center" >
<img src="https://d80b0eibbxq90.cloudfront.net/images/header_logo-db160648.svg" width=200 alt="CoinJarLogo" title="CoinJar Logo">
</p>

<br />
CJFloatingLabel is a UI component designed as part of CoinJar Touch. Inspired by the Google's polymer project, CJFloatingLabel provides a versatile, highly configurable text field that comes with a floating display label and icon image view.

## Features
- Supports active & inactive states.
- Configurable UI (support for UIApperance)
- Standard and secure text entry
- Support for icon image or plain text.

## Installation with cocoapods
[CocoaPods](http://cocoapods.org) is the easiest way to manage your iOS/OSX dependencies. Check out their getting started guide to see how to set it up.
If you have cocoapods setup on your machine, simply set the spec like this:

#### Podfile
```ruby
platform :ios, '8.0'
pod "CJFloatingLabel", "~> 1.0.0"
```

## Dependencies
- Masonry

We use constraints based layout at CoinJar, and since we create all of our views in code, we've gotten pretty used to using Masonry. It makes constraints based layout code about 400% easier to write and manage, and so it's part of this (and all of our) projects.


## Customising the appearance
The module is entirely customisable through UIAppearance. All colours and fonts used within the module can be set using the UIAppearance proxy. The example project shows how to do this, but for a more in depth look at UIAppearance check out the docs [check out the docs](https://developer.apple.com/library/ios/documentation/uikit/reference/UIAppearance_Protocol/Reference/Reference.html) or check out [Matt Thompson’s article on NSHipster](http://nshipster.com/uiappearance/)

## License
CJFloatingTextField is available under the MIT license. See the LICENSE file for more info.
