//
//  NSAttributedString+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/23.
//  Copyright © 2017年 Mike. All rights reserved.
//

import UIKit

public extension NSAttributedString {
    
}

/// MARK: - Set character attribute as property
public extension NSMutableAttributedString {
    public var rangeOfAll: NSRange {
        return NSRange(location: 0, length: self.length)
    }
    
    func setAttribute(_ attributeName: String, value: Any?, range: NSRange? = nil) {
        if let value = value {
            self.addAttribute(attributeName, value: value, range: range ?? self.rangeOfAll)
        } else {
            self.removeAttribute(attributeName, range: range ?? self.rangeOfAll)
        }
    }
    
    func setFont(_ font: UIFont, _ range: NSRange? = nil) {
        self.setAttribute(NSFontAttributeName, value: font, range: range)
    }
    
    func setKern(_ kern: CGFloat, _ range: NSRange? = nil) {
        self.setAttribute(NSKernAttributeName, value: kern, range: range)
    }
    
    func setForegroundColor(_ foregroundColor: UIColor, _ range: NSRange? = nil) {
        self.setAttribute(NSForegroundColorAttributeName, value: foregroundColor, range: range)
    }
    
    func setBackgroundColor(_ backgroundColor: UIColor, _ range: NSRange? = nil) {
        self.setAttribute(NSBackgroundColorAttributeName, value: backgroundColor, range: range)
    }
    
    func setStrokeWidth(_ strokeWidth: CGFloat, _ range: NSRange? = nil) {
        self.setAttribute(NSStrokeWidthAttributeName, value: strokeWidth, range: range)
    }
    
    func setStrokeColor(_ strokeColor: UIColor, _ range: NSRange? = nil) {
        self.setAttribute(NSStrokeColorAttributeName, value: strokeColor, range: range)
    }
    
    func setShadow(_ shadow: NSShadow, _ range: NSRange? = nil) {
        self.setAttribute(NSShadowAttributeName, value: shadow, range: range)
    }
    
    /// NSStrikethroughStyleAttributeName 设置删除线，取值为 NSNumber 对象（整数），枚举常量 NSUnderlineStyle中的值：
    ///    NSUnderlineStyleNone 不设置删除线
    ///    NSUnderlineStyleSingle 设置删除线为细单实线
    ///    NSUnderlineStyleThick 设置删除线为粗单实线
    ///    NSUnderlineStyleDouble 设置删除线为细双实线
    ///    默认值是NSUnderlineStyleNone
    func setStrikethroughStyle(_ underlineStyle: NSUnderlineStyle, _ range: NSRange? = nil) {
        self.setAttribute(NSStrikethroughStyleAttributeName, value: underlineStyle.rawValue, range: range)
    }
    
    /// NSUnderlineStyleAttributeName(下划线)
    /// 该属性所对应的值是一个 NSNumber 对象(整数)。该值指定是否在文字上加上下划线，该值参考“Underline Style Attributes”。默认值是NSUnderlineStyleNone
    func setUnderlineStyle(_ underlineStyle: Int, _ range: NSRange? = nil) {
        self.setAttribute(NSUnderlineStyleAttributeName, value: underlineStyle, range: range)
    }
    
    //    strikethroughColor
    //    func setStrokeColorAttributeName(_ strokeColor: Int, _ range: NSRange? = nil) {
    //        self.setAttribute(NSStrokeColorAttributeName, value: strikethroughStyle, range: range)
    //        return self
    //    }
    
    func setUnderlineColor(_ underlineColor: UIColor, _ range: NSRange? = nil) {
        self.setAttribute(NSUnderlineColorAttributeName, value: underlineColor, range: range)
    }
    
    /// NSLigatureAttributeName(连字符). 该属性所对应的值是一个 NSNumber 对象(整数)。连体字符是指某些连在一起的字符，它们采用单个的图元符号。0 表示没有连体字符。1 表示使用默认的连体字符。2表示使用所有连体符号。默认值为 1（注意，iOS 不支持值为 2）
    func setLigature(_ ligature: Int, _ range: NSRange? = nil) {
        self.setAttribute(NSLigatureAttributeName, value: ligature, range: range)
    }
    
    func setTextEffect(_ textEffect: String, _ range: NSRange? = nil) {
        self.setAttribute(NSTextEffectAttributeName, value: textEffect, range: range)
    }
    
    /// 字体倾斜
    func setObliqueness(_ obliqueness: CGFloat, _ range: NSRange? = nil) {
        self.setAttribute(NSObliquenessAttributeName, value: obliqueness, range: range)
    }
    
    /// 文本扁平化
    func setExpansion(_ expansion: CGFloat, _ range: NSRange? = nil) {
        self.setAttribute(NSExpansionAttributeName, value: expansion, range: range)
    }
    
    func setBaselineOffset(_ baselineOffset: CGFloat, _ range: NSRange? = nil) {
        self.setAttribute(NSBaselineOffsetAttributeName, value: baselineOffset, range: range)
    }
    
    /// 0 means horizontal text.  1 indicates vertical text.
    func setVerticalGlyphForm(_ verticalGlyphForm: Bool, _ range: NSRange? = nil) {
        self.setAttribute(NSVerticalGlyphFormAttributeName, value: verticalGlyphForm ? 1 : 0, range: range)
    }
    
    func setLanguage(_ language: CGFloat, _ range: NSRange? = nil) {
        self.setAttribute(kCTLanguageAttributeName as String, value: language, range: range)
    }
    
    func setWritingDirection(_ writingDirection: Int, _ range: NSRange? = nil) {
        self.setAttribute(NSWritingDirectionAttributeName, value: writingDirection, range: range)
    }
    
    func setParagraphStyle(_ paragraphStyle: NSParagraphStyle, _ range: NSRange? = nil) {
        self.setAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
    }
    
    //    NSAttachmentAttributeName
    //    NSLinkAttributeName
    
    // Set paragraph attribute as property
    //    alignment
    //    lineBreakMode
    //    lineSpacing
    //    paragraphSpacing
    //    paragraphSpacingBefore
    //    firstLineHeadIndent
    //    headIndent
    //    tailIndent
    //    minimumLineHeight
    //    maximumLineHeight
    //    lineHeightMultiple
    //    baseWritingDirection
    //    hyphenationFactor
    //    defaultTabInterval
    //    tabStops
    
}
