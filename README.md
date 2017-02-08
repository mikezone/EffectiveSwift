# EffectiveSwift

[![License GPL-3.0](http://img.shields.io/badge/license-GPLv3-brightgreen.svg?style=flat)](https://raw.githubusercontent.com/mikezone/EffectiveSwift/master/LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/EffectiveSwift.svg?style=flat)](http://cocoapods.org/?q=EffectiveSwift)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Build Status](https://travis-ci.org/mikezone/EffectiveSwift.svg?branch=master)](https://travis-ci.org/mikezone/EffectiveSwift)

`EffectiveSwift` is .

## Installation

### From CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C/Swift, which automates and simplifies the process of using 3rd-party libraries like `SVProgressHUD` in your projects. First, add the following line to your [Podfile](http://guides.cocoapods.org/using/using-cocoapods.html):

```ruby
pod 'EffectiveSwift'
```

If you want to use the latest features of `EffectiveSwift` use normal external source dependencies.

```ruby
pod 'EffectiveSwift', :git => 'https://github.com/mikezone/EffectiveSwift.git'
```
Take care that Swift project must add:

```ruby
use_frameworks!
```

This pulls from the `master` branch directly.

Second, install `EffectiveSwift` into your project:

```ruby
pod install
```

### Manually

* Drag the `EffectiveSwift/Extension` and `EffectiveSwift/Classes` folders into your project.
* Take care that `modulemapFiles` folder is added into your project folder. And set its path in `Build Settings` parameter `Import Paths`.
* Add the **libz** dynamic library to your project.

## Usage

(run this Xcode project. There are some sample in `AppGenerate/ViewController`)

**Get a substring of String type

```swift
"abcde".substring(0..<3) // "abc"
```
### Attension
use this framework like other Swift Module, you must add this line at top of your files:

```swift
import EffectiveSwift
```

## License
`EffectiveSwift` is distributed under the terms and conditions of the [License GPL-3.0](https://github.com/mikezone/EffectiveSwift/blob/master/LICENSE).
