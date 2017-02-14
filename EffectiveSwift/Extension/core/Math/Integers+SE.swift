//
//  Int+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/23.
//  Copyright © 2017年 Mike. All rights reserved.
//

import Foundation

public extension Int {
    
    public var isEven: Bool {
        return self % 2 == 0
    }
    
    public var isOdd: Bool {
        return self % 2 == 1
    }
    
    /// pass 1..<4 will retrun 1 or 2 or 3
    public func random(range: CountableRange<UInt32>) -> Int? {
        let lower = range.lowerBound
        let upper = range.upperBound
        if lower < UInt32.min || upper > UInt32.max { return nil }
        let gap = upper - lower
        return Int(arc4random_uniform(gap) + lower)
    }
}

public extension Int8 {
    public init?(cCharString: String) {
        guard let cString = cCharString.cString(using: .utf8),
            cString.count == 2 else { // end with "\0"
                return nil
        }
        self.init(cString[0])
    }
    
    public var charString: String? {
        if self < 0 {
            return nil
        }
        let pointer = UnsafeMutablePointer<Int8>.allocate(capacity: 1)
        let value = self
        pointer.pointee = value
        let string = String(cString: pointer)
        free(pointer)
        return string
    }
}

public extension UInt8 {
    public init?(cCharString: String) {
        guard let cString = cCharString.cString(using: .utf8),
        cString.count == 2 else {
            return nil
        }
        self.init(cString[0])
    }
    
    public func isEqualTo(char: String) -> Bool {
        guard let scalar = char.unicodeScalars.first else { return false}
        return isEqualTo(ascii: scalar)
    }
    
    public func isEqualTo(ascii: UnicodeScalar) -> Bool {
        return (self & 0xFF) == UInt8(ascii: ascii)
    }
    
    public var charString: String {
        let pointer = UnsafeMutablePointer<UInt8>.allocate(capacity: 1)
        let value = self
        pointer.pointee = value
        let string = String(cString: pointer)
        free(pointer)
        return string
    }
}

public extension UInt32 {
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

public extension UInt64 {
    
}
