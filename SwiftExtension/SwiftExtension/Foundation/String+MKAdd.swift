//
//  String+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/17.
//  Copyright © 2017年 Mike. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Project tools

extension String {
    
    /// 省份字符串处理
    func trimmingLocationString() -> String {
        if self.contains("省") {
            return self.replacingOccurrences(of: "省", with: "")
        } else if self.contains("市") {
            return self.replacingOccurrences(of: "市", with: "")
        } else if self.contains("澳门") {
            return "澳门"
        } else if self.contains("广西") {
            return "广西"
        } else if self.contains("内蒙古") {
            return "内蒙古"
        } else if self.contains("宁夏") {
            return "宁夏"
        } else if self.contains("香港") {
            return "香港"
        } else if self.contains("新疆") {
            return "新疆"
        } else if self.contains("西藏") {
            return "西藏"
        } else {
            return "其他"
        }
    }
}

// MARK: - type cast

extension String {
    
    func charValue() -> Character {
        return Character(self)
    }
    
    /// String 转换 intValue = int32Value
    /// - returns: Int
    func int32Value() -> Int32 {
        if let value = Int32(self) {
            return value
        }
        return Int32(0)
    }
    
    /// String 转换 intValue
    /// - returns: Int
    func intValue() -> Int {
        if let value = Int(self) {
            return value
        }
        return Int(0)
    }
    
    /// String 转换 floatValue
    /// - returns: float
    func floatValue() -> Float {
        if let value = Float(self) {
            return value
        }
        return Float(0)
    }
    
    /// String 转换 doubleValue
    /// - returns: double
    func doubleValue() -> Double {
        if let value = Double(self) {
            return value
        }
        return Double(0)
    }
}

// MARK: - Dividing Strings

extension String {
    func substring(_ range: CountableRange<Int>) -> String? {
        let startIndex = self.index(self.startIndex, offsetBy: range.startIndex)
        let endIndex = self.index(self.startIndex, offsetBy: range.endIndex)
        let range = Range(uncheckedBounds: (lower: startIndex, upper: endIndex))
        return self.substring(with: range)
    }
    
    func substring(to: Int) -> String? {
        if to >= self.characters.count || to < 0 { return nil }
        let index = self.index(self.startIndex, offsetBy: to)
        return self.substring(to: index)
    }
    
    func substring(from: Int) -> String? {
        if from >= self.characters.count || from < 0 { return nil }
        let index = self.index(self.startIndex, offsetBy: from)
        return self.substring(from: index)
    }
}

// MARK: - encode

extension String {
    
    public var bytes: [CChar]? {
        return self.cString(using: .utf8)
    }
    
    public var md5: String {
        let cString = self.cString(using: .utf8)
        let selfLength = UInt32(self.lengthOfBytes(using: .utf8))
        let messageDigestLength = Int(CC_MD5_DIGEST_LENGTH)
        let messageDigestResult = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: messageDigestLength)
        CC_MD5(cString, selfLength, messageDigestResult)
        var result = ""
        for i in 0 ..< messageDigestLength {
            result.append(String(format: "%02x", messageDigestResult[i]))
        }
        messageDigestResult.deinitialize()
        return result
        
        //        let data = self.data(using: .utf8)
        //        let selfLength = UInt32(self.lengthOfBytes(using: .utf8))
        //        let messageDigestLength = Int(CC_MD5_DIGEST_LENGTH)
        //        let messageDigestResult = UnsafeMutablePointer<UInt8>.allocate(capacity: messageDigestLength)
        //        data?.withUnsafeBytes { (pointer: UnsafePointer<UInt8>) -> Void in
        //            CC_MD5(pointer, selfLength, messageDigestResult)
        //        }
        //        messageDigestResult.deinitialize()
        //        return String(format: "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
        //                      messageDigestResult[0], messageDigestResult[1], messageDigestResult[2], messageDigestResult[3],
        //                      messageDigestResult[4], messageDigestResult[5], messageDigestResult[6], messageDigestResult[7],
        //                      messageDigestResult[8], messageDigestResult[9], messageDigestResult[10], messageDigestResult[11],
        //                      messageDigestResult[12], messageDigestResult[13], messageDigestResult[14], messageDigestResult[15])
    }
}

// MARK: - escape

extension String {
    
    /// URLEncode
    public var URLEncodedString: String? {
        let needEncodeCharacters = "!*'();:@&=+$,/?%#[]"
        var characterSet = CharacterSet.urlQueryAllowed
        characterSet.remove(charactersIn: needEncodeCharacters)
        return self.addingPercentEncoding(withAllowedCharacters: characterSet)
    }
}

// MARK: - pattern match

extension String {
    
    public func matchesRegex(_ pattern: String, _ options: NSRegularExpression.Options = .caseInsensitive) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: options)
            return regex.numberOfMatches(in: self, options: .reportProgress, range: NSRange(location: 0, length: self.characters.count)) > 0
        } catch {
        }
        return false
    }
    
    public func entiretyMatchesRegex(_ pattern: String, _ options: NSRegularExpression.Options = .caseInsensitive) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: options)
            var result: Bool = false
            regex.enumerateMatches(in: self, options: .reportProgress, range: NSRange(location: 0, length: self.characters.count), using: { (textCheckingResult, matchingFlags, stop) in
                if let range = textCheckingResult?.range,
                    NSEqualRanges(range, NSRange(location: 0, length: self.characters.count)) {
                    stop.pointee = true
                    result = true
                    return
                }
            })
            return result
        } catch {
        }
        return false
    }
    
    public func isMobileNumber() -> Bool {
        // "^((13[0-9])|(14[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$"
        // 有区号的正则 "^(\\+?0?86-?)?1[345789]\\d{9}$"
        // 不加区号的正则 "^1[345789]\\d{9}$"
        return entiretyMatchesRegex("^1[345789]\\d{9}$")
    }
    
    public func isUsername() -> Bool {
        // 必须由英文、数字组成，以英文字母开头并且为3至10字符
        return entiretyMatchesRegex("^[a-zA-Z][a-zA-Z0-9]{2,9}$")
    }
    
    public func isSubdomain() -> Bool {
        // 必须由英文、数字组成，以英文字母开头并且为3至30字符
        return entiretyMatchesRegex("^[a-zA-Z][a-zA-Z0-9]{2,29}$")
    }
    
    public func isPassword() -> Bool {
        // 由英文、数字组成，6至18字符
        return entiretyMatchesRegex("^[a-zA-Z0-9]{5,17}$")
    }
    
    public func isEmail() -> Bool {
        return entiretyMatchesRegex("^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$")
    }
    
    
    public func isHTTPURL() -> Bool {
        // "^\[a-zA-z\]+://(\\w+(-\\w+)*)(\\.(\\w+(-\\w+)*))*(\\?\\S*)?$"
        return entiretyMatchesRegex("http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?")
    }
}

// MARK: - UI calculate

extension String {
    
    /// NSString 计算字体size
    /// - parameter font:              字体大小
    /// - parameter constrainedToSize: constrainedToSize
    /// - returns: 计算好的size
    func size(font:UIFont, constrainedToSize:CGSize) -> CGSize {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect = self.boundingRect(with: constrainedToSize, options: option, attributes: attributes, context: nil)
        return rect.size
    }
}
