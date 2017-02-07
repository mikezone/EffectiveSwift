//
//  UINib+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/23.
//  Copyright © 2017年 Mike. All rights reserved.
//

import UIKit

public extension UINib {
    class func loadNibFirstView(name: String, owner: Any?) -> UIView? {
        // let nib = UINib(nibName: name, bundle: Bundle.main)
        // let array = nib.instantiate(withOwner: owner, options: nil)
        let array = Bundle.main.loadNibNamed(name, owner: owner, options: nil)
        if let array = array as? [UIView] {
            return array.first
        }
        return nil
    }
    
    class func loadNibLastView(name: String, owner: Any?) -> UIView? {
        let array = Bundle.main.loadNibNamed(name, owner: owner, options: nil)
        if let array = array as? [UIView] {
            return array.last
        }
        return nil
    }
}
