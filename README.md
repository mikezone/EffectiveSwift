# EffectiveSwift

[![License GPL-3.0](https://img.shields.io/badge/license-GPLv3-brightgreen.svg?style=flat)](https://raw.githubusercontent.com/mikezone/EffectiveSwift/master/LICENSE)&nbsp;
[![CocoaPods](https://img.shields.io/cocoapods/v/EffectiveSwift.svg?style=flat)](http://cocoapods.org/?q=EffectiveSwift)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
![Platform](https://img.shields.io/badge/platform-iOS-ff69b4.svg)&nbsp;
[![Build Status](https://travis-ci.org/mikezone/EffectiveSwift.svg?branch=master)](https://travis-ci.org/mikezone/EffectiveSwift)

`EffectiveSwift` is a framework that makes you work more efficiently with Swift. It contains some extensions for Classes in iOS framework and some classes derived them or wrapped for them.

## Installation

### From CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C/Swift, which automates and simplifies the process of using 3rd-party libraries like `EffectiveSwift` in your projects. First, add the following line to your [Podfile](http://guides.cocoapods.org/using/using-cocoapods.html):

```ruby
pod 'EffectiveSwift'
```

If you want to use the latest features of `EffectiveSwift` use normal external source dependencies.

```ruby
pod 'EffectiveSwift', :git => 'https://github.com/mikezone/EffectiveSwift.git'
```

This pulls from the `master` branch directly.

Take care that Swift project must add:

```ruby
use_frameworks!
```

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

**Get a substring of String type**

```swift
"abcde".substring(0..<3) // "abc"
```
**Some other samples**

```swift
// some samples of Extension for `String`
"hello".md5String // 5d41402abc4b2a76b9719d911017c592
"abcde".substring(0..<3) // "abc"
"url?serch=汉字".URLEncodedString // "url%3Fserch%3D%E6%B1%89%E5%AD%97"
"<a>超链接</a>".escapedHTMLString // "&quot;a&quot;超链接&quot;/a&quot;"

"http://wwww.baidu.com".isHTTPURL() // true
"http://wwww.baidu.com".entiretyMatchesRegex("^http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?$") // true
"😀😂".containsEmoji() // true
"  content  ".trimming() // "content"

String(cString: "hello".cCharPointer) // "hello"
let h = Int8(cCharString: "h")!
let e = Int8(cCharString: "e")!
let l = Int8(cCharString: "l")!
let o = Int8(cCharString: "o")!
let cCharArray = [h, e, l, l, o]
String(cCharArray: cCharArray) // "hello"

// some samples of Extension for `Int`
UInt8(97).isEqualTo(char: "a") // true
UInt32(0xff10b2c3).uInt8Components // [0xff, 0x10, 0xb2, 0xc3]
Int8(cCharString: "A") // 65
let a: UInt32 = 0x41424345
a.isEqualTo(chars: "ABCE") // true

// some samples of Extension for `Double`
Double.random(range: 1.0..<1.9, precision: -4)

// some samples of Extension for `DispatchQueue`
DispatchQueue(label: "com.github.mike").isMainQueue // true
DispatchQueue.asyncOnMainQueue {
    // async execute code... in main queue
}

// some samples of Extension for `Date`
Date().subtractingDays(1).isYesterday // true
Date.date("20170212", format: "yyyyMMdd")!.isSameWeekInChina(Date.date("20170213", format: "yyyyMMdd")!) // false

// some samples of Extension for `Timer`
_ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, closure: {_ in
    print("hello")
})

// some samples of Extension for `NSMutableAttributedString`
let attributedString = NSMutableAttributedString()
attributedString.setFont(UIFont())
attributedString.setStrokeColor(UIColor.red)

// some samples of Extension for `UIApplication`
UIApplication.shared.documentsPath
UIApplication.shared.appBundleID // com.github.mikezone
UIApplication.shared.appVersion // 1.0

// some samples of Extension for `UIColor`
UIColor.lightText.alphaHexString // 99ffffff
UIColor(hexString: "333333")

// some samples of Extension for `UIControl`
UIButton().addBlock({ (sender) in
    print((sender as! UIButton).currentTitle ?? "")
}, for: .touchUpInside)

// some samples of Extension for `UIDevice`
UIDevice.current.isJailbroken // false
UIDevice.current.machineModelName // Simulator x64

// some samples of Extension for `UIFont`
let normalFont = UIFont.systemFont(ofSize: 12.0).normaling
normalFont?.isBold // false

// some samples of Extension for `UIGestureRecognizer`
_ = UIPinchGestureRecognizer({ pinch in
    if pinch.state == .began {

    }
})

// some samples of Extension for `UIImage`
let image = UIImage(named: "xxx")
_ = image?.resizing(size: CGSize(width: 100, height: 150))
_ = image?.tinting(color: UIColor.red)
_ = image?.rotatingLeft90
```

### Attention
Use this framework like other Swift Module, you must add this line at top of your files:

```swift
import EffectiveSwift
```

## License
`EffectiveSwift` is distributed under the terms and conditions of the [License GPL-3.0](https://github.com/mikezone/EffectiveSwift/blob/master/LICENSE).
