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
        
        let string = "ℹ↔↕↖↗↘↙↩↪我是🚾🚿🛀🛁🛂🛃🛄🛅"
        
        for ch in string.characters.enumerated() {
            print(ch)
        }
        
        for scalar in string.unicodeScalars.enumerated() {
            print(scalar)
            print(scalar.element.value)
        }
        
        self.view.backgroundColor = UIColor(hex: 0x567834)
//        print(self.view.backgroundColor?.alphaHexValue)
//        print(self.view.backgroundColor?.alphaHexString)
//        Timer(timeInterval: <#T##TimeInterval#>, repeats: <#T##Bool#>, block: <#T##(Timer) -> Void#>)
//        Timer(fire: <#T##Date#>, interval: <#T##TimeInterval#>, repeats: <#T##Bool#>, block: <#T##(Timer) -> Void#>)
//        Slic
        
//        print(UIApplication.shared.documentsPath)
        
//        let a: UInt32 = 0x41424345
//        print(a.isEqualTo(chars: "ABCE"))
//        print(a.uInt8Components)
//        
//        let b: UInt8 = 0x47
//        print(b.isEqualTo(char: "G"))
        
//        let image = #imageLiteral(resourceName: "c").blurDark
//        self.imageView.image = image
//        print(UInt8.max)
        
//        let a = ClassIvarInfo()
//        print(a)
        print(UInt8(65).charString)
        
        // bug
//        print(ClassInfo(ViewController.self as! AnyClass).propertyInfos)
//        print(ClassInfo(Date.self as! AnyClass).ivarInfos)
//        print(ClassInfo(Date.self as! AnyClass).methodInfos)
//        
//        let timer = Timer.timer(timeInterval: 1, repeats: true, closure: { timer in
//            print("hello")
//        })
//        timer.fire()
//        RunLoop.current.add(timer, forMode: .commonModes)
//        
//        
//        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, closure: { timer in
//            print("world")
//        })
    }
}

