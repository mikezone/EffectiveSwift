//
//  String+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/17.
//  Copyright © 2017年 Mike. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Hash

extension String {
    
    public var bytes: [CChar]? {
        return self.cString(using: .utf8)
    }
    
    public var md2String: String {
        let cString = self.cString(using: .utf8)
        let selfLength = UInt32(self.lengthOfBytes(using: .utf8))
        let messageDigestLength = Int(CC_MD2_DIGEST_LENGTH)
        let messageDigestResult = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: messageDigestLength)
        
        CC_MD2(UnsafePointer<CChar>(cString), selfLength, messageDigestResult)
        var result = ""
        for i in 0 ..< messageDigestLength {
            result.append(String(format: "%02x", messageDigestResult[i]))
        }
        messageDigestResult.deinitialize()
        return result
    }
    
    public var md4String: String {
        let cString = self.cString(using: .utf8)
        let selfLength = UInt32(self.lengthOfBytes(using: .utf8))
        let messageDigestLength = Int(CC_MD4_DIGEST_LENGTH)
        let messageDigestResult = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: messageDigestLength)
        
        CC_MD4(UnsafePointer<CChar>(cString), selfLength, messageDigestResult)
        var result = ""
        for i in 0 ..< messageDigestLength {
            result.append(String(format: "%02x", messageDigestResult[i]))
        }
        messageDigestResult.deinitialize()
        return result
    }
    
    public var md5String: String {
        let cString = self.cString(using: .utf8)
        let selfLength = UInt32(self.lengthOfBytes(using: .utf8))
        let messageDigestLength = Int(CC_MD5_DIGEST_LENGTH)
        let messageDigestResult = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: messageDigestLength)
        
        CC_MD5(UnsafePointer<CChar>(cString), selfLength, messageDigestResult)
        var result = ""
        for i in 0 ..< messageDigestLength {
            result.append(String(format: "%02x", messageDigestResult[i]))
        }
        messageDigestResult.deinitialize()
        return result
    }
    
    public var sha1String: String {
        let cString = self.cString(using: .utf8)
        let selfLength = UInt32(self.lengthOfBytes(using: .utf8))
        let messageDigestLength = Int(CC_SHA1_DIGEST_LENGTH)
        let messageDigestResult = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: messageDigestLength)
        
        CC_SHA1(UnsafePointer<CChar>(cString), selfLength, messageDigestResult)
        var result = ""
        for i in 0 ..< messageDigestLength {
            result.append(String(format: "%02x", messageDigestResult[i]))
        }
        messageDigestResult.deinitialize()
        return result
    }
    
    public var sha224String: String {
        let cString = self.cString(using: .utf8)
        let selfLength = UInt32(self.lengthOfBytes(using: .utf8))
        let messageDigestLength = Int(CC_SHA224_DIGEST_LENGTH)
        let messageDigestResult = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: messageDigestLength)
        
        CC_SHA224(UnsafePointer<CChar>(cString), selfLength, messageDigestResult)
        var result = ""
        for i in 0 ..< messageDigestLength {
            result.append(String(format: "%02x", messageDigestResult[i]))
        }
        messageDigestResult.deinitialize()
        return result
    }
    
    public var sha256String: String {
        let cString = self.cString(using: .utf8)
        let selfLength = UInt32(self.lengthOfBytes(using: .utf8))
        let messageDigestLength = Int(CC_SHA256_DIGEST_LENGTH)
        let messageDigestResult = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: messageDigestLength)
        
        CC_SHA256(UnsafePointer<CChar>(cString), selfLength, messageDigestResult)
        var result = ""
        for i in 0 ..< messageDigestLength {
            result.append(String(format: "%02x", messageDigestResult[i]))
        }
        messageDigestResult.deinitialize()
        return result
    }
    
    public var sha384String: String {
        let cString = self.cString(using: .utf8)
        let selfLength = UInt32(self.lengthOfBytes(using: .utf8))
        let messageDigestLength = Int(CC_SHA384_DIGEST_LENGTH)
        let messageDigestResult = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: messageDigestLength)
        
        CC_SHA384(UnsafePointer<CChar>(cString), selfLength, messageDigestResult)
        var result = ""
        for i in 0 ..< messageDigestLength {
            result.append(String(format: "%02x", messageDigestResult[i]))
        }
        messageDigestResult.deinitialize()
        return result
    }
    
    public var sha512String: String {
        let cString = self.cString(using: .utf8)
        let selfLength = UInt32(self.lengthOfBytes(using: .utf8))
        let messageDigestLength = Int(CC_SHA512_DIGEST_LENGTH)
        let messageDigestResult = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: messageDigestLength)
        
        CC_SHA512(UnsafePointer<CChar>(cString), selfLength, messageDigestResult)
        var result = ""
        for i in 0 ..< messageDigestLength {
            result.append(String(format: "%02x", messageDigestResult[i]))
        }
        messageDigestResult.deinitialize()
        return result
    }
    
    public func hmacString(_ algorithm: CCHmacAlgorithm, _ key: String) -> String {
        var messageDigestLength: Int32 = 0
        switch Int(algorithm) {
        case kCCHmacAlgMD5:
            messageDigestLength = CC_MD5_DIGEST_LENGTH
        case kCCHmacAlgSHA1:
            messageDigestLength = CC_SHA1_DIGEST_LENGTH
        case kCCHmacAlgSHA224:
            messageDigestLength = CC_SHA224_DIGEST_LENGTH
        case kCCHmacAlgSHA256:
            messageDigestLength = CC_SHA256_DIGEST_LENGTH
        case kCCHmacAlgSHA384:
            messageDigestLength = CC_SHA384_DIGEST_LENGTH
        case kCCHmacAlgSHA512:
            messageDigestLength = CC_SHA512_DIGEST_LENGTH
        default:
            break
        }
        
        let messageDigestResult = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: Int(messageDigestLength))
        let cString = self.cString(using: .utf8)
        let keyCString = key.cString(using: .utf8)
        CCHmac(algorithm, keyCString, key.lengthOfBytes(using: .utf8), cString, self.lengthOfBytes(using: .utf8), messageDigestResult)
        var result = ""
        for i in 0 ..< Int(messageDigestLength) {
            result.append(String(format: "%02x", messageDigestResult[i]))
        }
        messageDigestResult.deinitialize()
        return result
    }
    
    public func hmacMD5String(_ key: String) -> String {
        return hmacString(CCHmacAlgorithm(kCCHmacAlgMD5), key)
    }
    
    public func hmacSHA1String(_ key: String) -> String {
        return hmacString(CCHmacAlgorithm(kCCHmacAlgSHA1), key)
    }
    
    public func hmacSHA224String(_ key: String) -> String {
        return hmacString(CCHmacAlgorithm(kCCHmacAlgSHA224), key)
    }
    
    public func hmacSHA256String(_ key: String) -> String {
        return hmacString(CCHmacAlgorithm(kCCHmacAlgSHA256), key)
    }
    
    public func hmacSHA384String(_ key: String) -> String {
        return hmacString(CCHmacAlgorithm(kCCHmacAlgSHA384), key)
    }
    
    public func hmacSHA512String(_ key: String) -> String {
        return hmacString(CCHmacAlgorithm(kCCHmacAlgSHA512), key)
    }
    
    
//    public var crc32String: String {
////        let cString = self.cString(using: .utf8)
////        var data: [UInt8] = []
////        for char in cString?.enumerated() {
////            data.append(<#T##newElement: Element##Element#>)
////        }
////        let data = UnsafePointer<CChar>(cString)
////        let result = crc32(0, UnsafePointer<UInt8>(data), uInt(self.lengthOfBytes(using: .utf8)))
////        return String.init(format: "%08x", result)
//    }
    
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
        return entiretyMatchesRegex("^http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?$")
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
