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
        
    }
}

