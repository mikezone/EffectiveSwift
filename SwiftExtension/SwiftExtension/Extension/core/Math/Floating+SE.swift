//
//  Floating+SE.swift
//  SwiftExtension
//
//  Created by Mike on 17/2/2.
//  Copyright © 2017年 Mike. All rights reserved.
//

import Foundation

public extension Float {
    
}

public extension Double {
    // exponent is base on radix is 10
    public static func random(range: Range<Double>, precision exponent: Int) -> Double {
        let lower = range.lowerBound
        let upper = range.upperBound
        let gap = upper - lower
        
        return random(gap: gap, lower: lower, index: Double(exponent))
    }
    
    public static func random(closedRange: ClosedRange<Double>, precision exponent: Int) -> Double {
        let lower = closedRange.lowerBound
        let upper = closedRange.upperBound
        let gap = upper - lower
        
        return random(gap: gap, lower: lower, index: Double(exponent), isClosed: true)
    }
    
    private static func random(gap: Double, lower: Double, index: Double, isClosed: Bool = false) -> Double {
        func result(gap: Double, lower: Double, index: Double) -> Double {
            let uniform = UInt32(pow(10.0, fabs(index))) + (isClosed ? 1 : 0)
            let value = Double(arc4random_uniform(uniform)) * pow(10.0, -fabs(index)) * gap + lower
            let formatString = String(format: "%%.0%df", Int(fabs(index)))
            let string = String(format: formatString, value)
            return Double(string)!
        }
        
        if index >= 0 {
            return result(gap: gap, lower: lower, index: -4.0)
        } else {
            return result(gap: gap, lower: lower, index: index)
        }
    }
}
