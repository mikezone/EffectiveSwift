//
//  UIFont+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/26.
//  Copyright © 2017年 Mike. All rights reserved.
//

import UIKit

extension UIFont {
    public var isBold: Bool {
        return self.fontDescriptor.symbolicTraits.contains(.traitBold)
    }
    
    public var isItalic: Bool {
        return self.fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
    
    public var isMonoSpace: Bool {
        return self.fontDescriptor.symbolicTraits.contains(.traitMonoSpace)
    }
    
    public var isColorGlyphs: Bool {
        return CTFontGetSymbolicTraits(self as CTFont).contains(.traitColorGlyphs)
    }
    
    public var fontWeight: CGFloat? {
        guard let traits = self.fontDescriptor.object(forKey: UIFontDescriptorTraitsAttribute) as? [String : Any]
            else { return nil}
        return traits[UIFontWeightTrait] as? CGFloat
    }
    
    public var bolding: UIFont? {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(.traitBold) else {
            return nil
        }
        return UIFont(descriptor: descriptor, size: self.pointSize)
    }
    
    public var italicing: UIFont? {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(.traitItalic) else {
            return nil
        }
        return UIFont(descriptor: descriptor, size: self.pointSize)
    }

    public var boldItalicing: UIFont? {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits([.traitBold, .traitItalic]) else {
            return nil
        }
        return UIFont(descriptor: descriptor, size: self.pointSize)
    }
    
    public var normaling: UIFont? {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(.init(rawValue: 0)) else {
            return nil
        }
        return UIFont(descriptor: descriptor, size: self.pointSize)
    }
}
