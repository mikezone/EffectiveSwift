//
//  UIColor+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/22.
//  Copyright © 2017年 Mike. All rights reserved.
//

import UIKit

public extension UIColor {
    public convenience init?(hexString: String) {
        var rgbString = hexString
        // String should be 6 or 7 characters if it includes '#'
        if hexString.characters.count < 6 { return nil }
        
        // strip `#` if it appears
        if rgbString.hasPrefix("#") {
            let index = rgbString.index(rgbString.startIndex, offsetBy: 0)
            rgbString.remove(at: index)
        }
        
        // strip `0x` if it appears
        if rgbString.hasPrefix("0x") {
            let index = rgbString.index(rgbString.startIndex, offsetBy: 2)
            rgbString.removeSubrange(rgbString.startIndex..<index)
        }
        
        // if the value isn't 6 characters at this point return
        // the color black
        if rgbString.characters.count != 6 { return nil}
        
        // Separate into r, g, b substrings
        let rString = rgbString.substring(0..<2)
        let gString = rgbString.substring(2..<4)
        let bString = rgbString.substring(4..<6)
        
        // Scan values
        var r: UInt32 = 0
        var g: UInt32 = 0
        var b: UInt32 = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
    }
    
    public convenience init(hex: UInt32) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
    
    public static var random6: UIColor {
        let hexArray: [UInt32] = [0xF8661F, 0xE9C21F, 0x4CBA6A, 0x2181CB, 0x2CA7EA, 0x87B52E]
        return UIColor(hex: hexArray[Int(arc4random_uniform(6))])
    }
    
    public static var random: UIColor {
        let r = CGFloat(arc4random_uniform(256)) / 255.0
        let g = CGFloat(arc4random_uniform(256)) / 255.0
        let b = CGFloat(arc4random_uniform(256)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
}

// MARK: - get property
public extension UIColor {
    public var alpha: CGFloat {
        return self.cgColor.alpha
    }
    
    private func hex(_ containsAlpha: Bool = false) -> UInt32 {
        let cgColor = self.cgColor
        let count = cgColor.numberOfComponents
        guard let components = cgColor.components,
            count == 4 else { return 0x00}
        let rHex = UInt32(components[0] * 255.0) << 16
        let gHex = UInt32(components[1] * 255.0) << 8
        let bHex = UInt32(components[2] * 255.0)
        if !containsAlpha {
            return rHex + gHex + bHex
        }
        let alphaHex = UInt32(self.alpha * 255.0) << 24
        return alphaHex + rHex + gHex + bHex
    }
    
    public var hexValue: UInt32 {
        return hex()
    }
    
    public var alphaHexValue: UInt32 {
        return hex(true)
    }
    
    public var hexString: String {
        return String(format: "%08x", hexValue)
    }
    
    public var alphaHexString: String {
        return String(format: "%08x", alphaHexValue)
    }
}
