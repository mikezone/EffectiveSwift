//
//  ViewController.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/16.
//  Copyright © 2017年 Mike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // some samples of Extension for `String`
        print("hello".md5String) // 5d41402abc4b2a76b9719d911017c592
        print("abcde".substring(0..<3)) // "abc"
        print("url?serch=汉字".URLEncodedString!) // "url%3Fserch%3D%E6%B1%89%E5%AD%97"
        print("<a>超链接</a>".escapedHTMLString!) // "&quot;a&quot;超链接&quot;/a&quot;"
        
        print("http://wwww.baidu.com".isHTTPURL()) // true
        print("http://wwww.baidu.com".entiretyMatchesRegex("^http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?$")) // true
        print("😀😂".containsEmoji()) // true
        print("  content  ".trimming()) // "content"
        
        print(String(cString: "hello".cCharPointer))
        let h = Int8(cCharString: "h")!
        let e = Int8(cCharString: "e")!
        let l = Int8(cCharString: "l")!
        let o = Int8(cCharString: "o")!
        let cCharArray = [h, e, l, l, o]
        print(String(cCharArray: cCharArray))
        
        // some samples of Extension for `Int`
        print(UInt8(97).isEqualTo(char: "a")) // true
        print(UInt32(0xff10b2c3).uInt8Components) // [0xff, 0x10, 0xb2, 0xc3]
        print(Int8(cCharString: "A")!) // 65
        let a: UInt32 = 0x41424345
        print(a.isEqualTo(chars: "ABCE")) // true
        
        // some samples of Extension for `Double`
        print(Double.random(range: 1.0..<1.9, precision: -4))
        
        // some samples of Extension for `DispatchQueue`
        print(DispatchQueue(label: "com.github.mike").isMainQueue) // true
        DispatchQueue.asyncOnMainQueue {
            // async execute code... in main queue
        }
        
        // some samples of Extension for `Date`
        print(Date().subtractingDays(1).isYesterday) // true
        print(Date.date("20170212", format: "yyyyMMdd")!.isSameWeekInChina(Date.date("20170213", format: "yyyyMMdd")!)) // false
        
        // some samples of Extension for `Timer`
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, closure: {_ in
            print("hello")
        })
        
        // some samples of Extension for `NSMutableAttributedString`
        let attributedString = NSMutableAttributedString()
        attributedString.setFont(UIFont())
        attributedString.setStrokeColor(UIColor.red)
        
        // some samples of Extension for `UIApplication`
        print(UIApplication.shared.documentsPath!)
        print(UIApplication.shared.appBundleID!) // com.github.mikezone
        print(UIApplication.shared.appVersion!) // 1.0
        
        // some samples of Extension for `UIColor`
        print(UIColor.lightText.alphaHexString) // 99ffffff
        // UIColor(hexString: "333333")
        
        // some samples of Extension for `UIControl`
        UIButton().addBlock({ (sender) in
            print((sender as! UIButton).currentTitle ?? "")
        }, for: .touchUpInside)
        
        // some samples of Extension for `UIDevice`
        print(UIDevice.current.isJailbroken) // false
        print(UIDevice.current.machineModelName!) // Simulator x64
        
        // some samples of Extension for `UIFont`
        let normalFont = UIFont.systemFont(ofSize: 12.0).normaling
        print((normalFont?.isBold)!) // false
        
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
        
        // existing bug
        // print(ClassInfo(ViewController.self as! AnyClass).propertyInfos)
        
//        print("hello".characters.count) // 5
//        print("hello".cString(using: .utf8)?.count) // 6
    }
}
