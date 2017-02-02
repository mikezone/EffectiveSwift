//
//  Int+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/23.
//  Copyright © 2017年 Mike. All rights reserved.
//

import Foundation

extension Int {
    
    public var isEven: Bool {
        return self % 2 == 0
    }
    
    public var isOdd: Bool {
        return self % 2 == 1
    }
    
}

extension UInt8 {
    public func isEqualTo(char: String) -> Bool {
        guard let scalar = char.unicodeScalars.first else { return false}
        return isEqualTo(ascii: scalar)
    }
    
    public func isEqualTo(ascii: UnicodeScalar) -> Bool {
        return (self & 0xFF) == UInt8(ascii: ascii)
    }
}

extension UInt32 {
    public var uInt8Components: [UInt8] {
        var array = [UInt8](repeating: 0, count: 4)
        array[0] = UInt8((self >> 24) & 0xFF)
        array[1] = UInt8((self >> 16) & 0xFF)
        array[2] = UInt8((self >> 8) & 0xFF)
        array[3] = UInt8(self & 0xFF)
        return array
    }
    
    public func isEqualTo(chars: String) -> Bool {
        guard chars.unicodeScalars.count == 4 else { return false }
        var scalarsIterator = chars.unicodeScalars.makeIterator()
        for uInt8Element in self.uInt8Components {
            if !uInt8Element.isEqualTo(ascii: scalarsIterator.next()!) {
                return false
            }
            continue
        }
        return true
    }
}

extension UInt64 {
    
}
