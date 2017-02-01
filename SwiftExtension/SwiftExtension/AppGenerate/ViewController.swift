//
//  ViewController.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/16.
//  Copyright © 2017年 Mike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    }
}

