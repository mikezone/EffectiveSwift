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
        
//        do {
////            let json = "{\"name\":\"zhangsan\", \"age\":12}"
////            let json = "{\"name\":\"zhangsan\", \"age\":12.0}"
////            let json = "{\"name\":\"zhangsan\", \"age\":{\"name\":\"zhangsan\", \"age\":12.0}}"
//            let json = "{\"name\":\"zhangsan\", \"age\":[10, 8, 7]}"
////            let json = "{\"name\":\"zhangsan\", \"age\":\"hah\"}"
//            let obj = try JSONSerialization.jsonObject(with: json.data(using: .utf8)!, options: .mutableContainers)
//            print(obj)
//            let dict = obj as! [String:Any]
//            print(dict)
//            print(dict["name"] as! String) // zhangsan
////            print(dict["age"] as! String) //Could not cast value of type '__NSCFNumber' (0x109f1e3c0) to 'NSString' (0x109522ad8)
//            print(dict["age"] as? String) // nil
////            print(dict["age"] as! Int) // 12
//            print(String.fromAnyJSONObject(dict["age"]))
//        } catch {
//            
//        }
        print(Double.random(range: 1.0..<1.9, precision: -4))
        
        print(String(cString: "hello".cCharPointer))
        let h = Int8(cCharString: "h")!
        let e = Int8(cCharString: "e")!
        let l = Int8(cCharString: "l")!
        let o = Int8(cCharString: "o")!
        let cCharArray = [h, e, l, l, o]
        print(String(cCharArray: cCharArray))
    }
}
