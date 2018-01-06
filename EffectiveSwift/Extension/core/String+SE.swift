//
//  String+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/17.
//  Copyright © 2017年 Mike. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto
import zlib

// MARK: - Hash

public extension String {
    
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
    
    public var crc32String: String {
        return String(format: "%08x", crc32Value)
    }
    
    public var crc32Value: UInt {
        let cString = self.utf8CString
        let data: [UInt8] = cString.map { (char) -> UInt8 in
            return UInt8(char)
        }
        return crc32(0, UnsafePointer<UInt8>(data), uInt(self.lengthOfBytes(using: .utf8)))
    }
}

// MARK: - Encode and decode / escape

public extension String {
    
    public var base64EncodedString: String? {
        return self.data(using: .utf8)?.base64EncodedString()
    }
    
    public var base64DecodedString: String? {
        guard let data = Data(base64Encoded: self) else { return nil}
        return String(data: data, encoding: .utf8)
    }
    
    public var URLEncodedString: String? {
        let needEncodeCharacters = "!*'();:@&=+$,/?%#[]"
        var characterSet = CharacterSet.urlQueryAllowed
        characterSet.remove(charactersIn: needEncodeCharacters)
        return self.addingPercentEncoding(withAllowedCharacters: characterSet)
    }
    
    public var URLDecodedString: String? {
        return self.removingPercentEncoding
    }
    
    public var escapedHTMLString: String? {
        var result = ""
        self.unicodeScalars.forEach { (scalar) in
            var currentChar: String = String(scalar)
            switch scalar.value {
            case 34:
                currentChar = "&quot;"
            case 38:
                currentChar = "&amp;"
            case 39:
                currentChar = "&quot;"
            case 60:
                currentChar = "&quot;"
            case 62:
                currentChar = "&quot;"
            default:
                break
            }
            result.append(currentChar)
        }
        return result
    }
}

// MARK: - Drawing (UI calculate)

public extension String {
    
    /// NSString 计算字体size
    /// - parameter font:              字体大小
    /// - parameter constrainedToSize: constrainedToSize
    /// - returns: 计算好的size
    func size(font: UIFont, limitedSize: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), lineBreakMode: NSLineBreakMode = .byWordWrapping) -> CGSize {
        var attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.font: font]
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        attributes[NSAttributedStringKey.paragraphStyle] = paragraphStyle
        
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        return self.boundingRect(with: limitedSize, options: options, attributes: attributes, context: nil).size
    }
    
    func size(font: UIFont, limitedWidth: CGFloat) -> CGSize {
        return size(font: font, limitedSize: CGSize(width: limitedWidth, height: .greatestFiniteMagnitude))
    }
}

// MARK: - pattern match(Regular Expression)

public extension String {
    
    public func matchesRegex(_ pattern: String, _ options: NSRegularExpression.Options = .caseInsensitive, _ enumerateClosure:((_ matchString: String, _ matchRange: NSRange, _ stop: UnsafeMutablePointer<ObjCBool>) -> Swift.Void)? = nil) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: options)
            guard let enumerateClosure = enumerateClosure else {
                return regex.numberOfMatches(in: self, options: .reportProgress, range: NSRange(location: 0, length: self.characters.count)) > 0
            }
            regex.enumerateMatches(in: self, options: .reportProgress, range: NSRange(location: 0, length: self.characters.count), using: { (textCheckingResult, matchingFlags, stop) in
                let nsRange = textCheckingResult?.range ?? NSRange(location: 0, length: 0)
                let range = nsRange.location..<(nsRange.location + nsRange.length)
                enumerateClosure(self.substring(range), nsRange, stop)
            })
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
    
    public func replacingRegex(_ pattern: String, _ options: NSRegularExpression.Options = .caseInsensitive, _ replacement:String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: options)
            return regex.stringByReplacingMatches(in: self, options: .reportProgress, range: NSRange(location: 0, length: self.characters.count), withTemplate: replacement)
        } catch {
        }
        return self
    }
    
    // MARK: - common
    
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

// MARK: - Emoji 

public extension String {
    
    public func containsEmoji(_ systemVersion: String = UIDevice.current.systemVersion) -> Bool {
        let minSetOld = NSMutableCharacterSet()
        minSetOld.addCharacters(in: "\u{2139}\u{2194}\u{2195}\u{2196}\u{2197}\u{2198}\u{2199}\u{21a9}\u{21aa}\u{231a}\u{231b}\u{23e9}\u{23ea}\u{23eb}\u{23ec}\u{23f0}\u{23f3}\u{24c2}\u{25aa}\u{25ab}\u{25b6}\u{25c0}\u{25fb}\u{25fc}\u{25fd}\u{25fe}\u{2600}\u{2601}\u{260e}\u{2611}\u{2614}\u{2615}\u{261d}\u{261d}\u{263a}\u{2648}\u{2649}\u{264a}\u{264b}\u{264c}\u{264d}\u{264e}\u{264f}\u{2650}\u{2651}\u{2652}\u{2653}\u{2660}\u{2663}\u{2665}\u{2666}\u{2668}\u{267b}\u{267f}\u{2693}\u{26a0}\u{26a1}\u{26aa}\u{26ab}\u{26bd}\u{26be}\u{26c4}\u{26c5}\u{26ce}\u{26d4}\u{26ea}\u{26f2}\u{26f3}\u{26f5}\u{26fa}\u{26fd}\u{2702}\u{2705}\u{2708}\u{2709}\u{270a}\u{270b}\u{270c}\u{270c}\u{270f}\u{2712}\u{2714}\u{2716}\u{2728}\u{2733}\u{2734}\u{2744}\u{2747}\u{274c}\u{274e}\u{2753}\u{2754}\u{2755}\u{2757}\u{2764}\u{2795}\u{2796}\u{2797}\u{27a1}\u{27b0}\u{27bf}\u{2934}\u{2935}\u{2b05}\u{2b06}\u{2b07}\u{2b1b}\u{2b1c}\u{2b50}\u{2b55}\u{3030}\u{303d}\u{3297}\u{00003299}\u{0001f004}\u{0001f0cf}\u{0001f170}\u{0001f171}\u{0001f17e}\u{0001f17f}\u{0001f18e}\u{0001f191}\u{0001f192}\u{0001f193}\u{0001f194}\u{0001f195}\u{0001f196}\u{0001f197}\u{0001f198}\u{0001f199}\u{0001f19a}\u{0001f201}\u{0001f202}\u{0001f21a}\u{0001f22f}\u{0001f232}\u{0001f233}\u{0001f234}\u{0001f235}\u{0001f236}\u{0001f237}\u{0001f238}\u{0001f239}\u{0001f23a}\u{0001f250}\u{0001f251}\u{0001f300}\u{0001f301}\u{0001f302}\u{0001f303}\u{0001f304}\u{0001f305}\u{0001f306}\u{0001f307}\u{0001f308}\u{0001f309}\u{0001f30a}\u{0001f30b}\u{0001f30c}\u{0001f30d}\u{0001f30e}\u{0001f30f}\u{0001f310}\u{0001f311}\u{0001f312}\u{0001f313}\u{0001f314}\u{0001f315}\u{0001f316}\u{0001f317}\u{0001f318}\u{0001f319}\u{0001f31a}\u{0001f31b}\u{0001f31c}\u{0001f31d}\u{0001f31e}\u{0001f31f}\u{0001f320}\u{0001f330}\u{0001f331}\u{0001f332}\u{0001f333}\u{0001f334}\u{0001f335}\u{0001f337}\u{0001f338}\u{0001f339}\u{0001f33a}\u{0001f33b}\u{0001f33c}\u{0001f33d}\u{0001f33e}\u{0001f33f}\u{0001f340}\u{0001f341}\u{0001f342}\u{0001f343}\u{0001f344}\u{0001f345}\u{0001f346}\u{0001f347}\u{0001f348}\u{0001f349}\u{0001f34a}\u{0001f34b}\u{0001f34c}\u{0001f34d}\u{0001f34e}\u{0001f34f}\u{0001f350}\u{0001f351}\u{0001f352}\u{0001f353}\u{0001f354}\u{0001f355}\u{0001f356}\u{0001f357}\u{0001f358}\u{0001f359}\u{0001f35a}\u{0001f35b}\u{0001f35c}\u{0001f35d}\u{0001f35e}\u{0001f35f}\u{0001f360}\u{0001f361}\u{0001f362}\u{0001f363}\u{0001f364}\u{0001f365}\u{0001f366}\u{0001f367}\u{0001f368}\u{0001f369}\u{0001f36a}\u{0001f36b}\u{0001f36c}\u{0001f36d}\u{0001f36e}\u{0001f36f}\u{0001f370}\u{0001f371}\u{0001f372}\u{0001f373}\u{0001f374}\u{0001f375}\u{0001f376}\u{0001f377}\u{0001f378}\u{0001f379}\u{0001f37a}\u{0001f37b}\u{0001f37c}\u{0001f380}\u{0001f381}\u{0001f382}\u{0001f383}\u{0001f384}\u{0001f385}\u{0001f386}\u{0001f387}\u{0001f388}\u{0001f389}\u{0001f38a}\u{0001f38b}\u{0001f38c}\u{0001f38d}\u{0001f38e}\u{0001f38f}\u{0001f390}\u{0001f391}\u{0001f392}\u{0001f393}\u{0001f3a0}\u{0001f3a1}\u{0001f3a2}\u{0001f3a3}\u{0001f3a4}\u{0001f3a5}\u{0001f3a6}\u{0001f3a7}\u{0001f3a8}\u{0001f3a9}\u{0001f3aa}\u{0001f3ab}\u{0001f3ac}\u{0001f3ad}\u{0001f3ae}\u{0001f3af}\u{0001f3b0}\u{0001f3b1}\u{0001f3b2}\u{0001f3b3}\u{0001f3b4}\u{0001f3b5}\u{0001f3b6}\u{0001f3b7}\u{0001f3b8}\u{0001f3b9}\u{0001f3ba}\u{0001f3bb}\u{0001f3bc}\u{0001f3bd}\u{0001f3be}\u{0001f3bf}\u{0001f3c0}\u{0001f3c1}\u{0001f3c2}\u{0001f3c3}\u{0001f3c4}\u{0001f3c6}\u{0001f3c7}\u{0001f3c8}\u{0001f3c9}\u{0001f3ca}\u{0001f3e0}\u{0001f3e1}\u{0001f3e2}\u{0001f3e3}\u{0001f3e4}\u{0001f3e5}\u{0001f3e6}\u{0001f3e7}\u{0001f3e8}\u{0001f3e9}\u{0001f3ea}\u{0001f3eb}\u{0001f3ec}\u{0001f3ed}\u{0001f3ee}\u{0001f3ef}\u{0001f3f0}\u{0001f400}\u{0001f401}\u{0001f402}\u{0001f403}\u{0001f404}\u{0001f405}\u{0001f406}\u{0001f407}\u{0001f408}\u{0001f409}\u{0001f40a}\u{0001f40b}\u{0001f40c}\u{0001f40d}\u{0001f40e}\u{0001f40f}\u{0001f410}\u{0001f411}\u{0001f412}\u{0001f413}\u{0001f414}\u{0001f415}\u{0001f416}\u{0001f417}\u{0001f418}\u{0001f419}\u{0001f41a}\u{0001f41b}\u{0001f41c}\u{0001f41d}\u{0001f41e}\u{0001f41f}\u{0001f420}\u{0001f421}\u{0001f422}\u{0001f423}\u{0001f424}\u{0001f425}\u{0001f426}\u{0001f427}\u{0001f428}\u{0001f429}\u{0001f42a}\u{0001f42b}\u{0001f42c}\u{0001f42d}\u{0001f42e}\u{0001f42f}\u{0001f430}\u{0001f431}\u{0001f432}\u{0001f433}\u{0001f434}\u{0001f435}\u{0001f436}\u{0001f437}\u{0001f438}\u{0001f439}\u{0001f43a}\u{0001f43b}\u{0001f43c}\u{0001f43d}\u{0001f43e}\u{0001f440}\u{0001f442}\u{0001f443}\u{0001f444}\u{0001f445}\u{0001f446}\u{0001f447}\u{0001f448}\u{0001f449}\u{0001f44a}\u{0001f44b}\u{0001f44c}\u{0001f44d}\u{0001f44e}\u{0001f44f}\u{0001f450}\u{0001f451}\u{0001f452}\u{0001f453}\u{0001f454}\u{0001f455}\u{0001f456}\u{0001f457}\u{0001f458}\u{0001f459}\u{0001f45a}\u{0001f45b}\u{0001f45c}\u{0001f45d}\u{0001f45e}\u{0001f45f}\u{0001f460}\u{0001f461}\u{0001f462}\u{0001f463}\u{0001f464}\u{0001f465}\u{0001f466}\u{0001f467}\u{0001f468}\u{0001f469}\u{0001f46a}\u{0001f46b}\u{0001f46c}\u{0001f46d}\u{0001f46e}\u{0001f46f}\u{0001f470}\u{0001f471}\u{0001f472}\u{0001f473}\u{0001f474}\u{0001f475}\u{0001f476}\u{0001f477}\u{0001f478}\u{0001f479}\u{0001f47a}\u{0001f47b}\u{0001f47c}\u{0001f47d}\u{0001f47e}\u{0001f47f}\u{0001f480}\u{0001f481}\u{0001f482}\u{0001f483}\u{0001f484}\u{0001f485}\u{0001f486}\u{0001f487}\u{0001f488}\u{0001f489}\u{0001f48a}\u{0001f48b}\u{0001f48c}\u{0001f48d}\u{0001f48e}\u{0001f48f}\u{0001f490}\u{0001f491}\u{0001f492}\u{0001f493}\u{0001f494}\u{0001f495}\u{0001f496}\u{0001f497}\u{0001f498}\u{0001f499}\u{0001f49a}\u{0001f49b}\u{0001f49c}\u{0001f49d}\u{0001f49e}\u{0001f49f}\u{0001f4a0}\u{0001f4a1}\u{0001f4a2}\u{0001f4a3}\u{0001f4a4}\u{0001f4a5}\u{0001f4a6}\u{0001f4a7}\u{0001f4a8}\u{0001f4a9}\u{0001f4aa}\u{0001f4ab}\u{0001f4ac}\u{0001f4ad}\u{0001f4ae}\u{0001f4af}\u{0001f4b0}\u{0001f4b1}\u{0001f4b2}\u{0001f4b3}\u{0001f4b4}\u{0001f4b5}\u{0001f4b6}\u{0001f4b7}\u{0001f4b8}\u{0001f4b9}\u{0001f4ba}\u{0001f4bb}\u{0001f4bc}\u{0001f4bd}\u{0001f4be}\u{0001f4bf}\u{0001f4c0}\u{0001f4c1}\u{0001f4c2}\u{0001f4c3}\u{0001f4c4}\u{0001f4c5}\u{0001f4c6}\u{0001f4c7}\u{0001f4c8}\u{0001f4c9}\u{0001f4ca}\u{0001f4cb}\u{0001f4cc}\u{0001f4cd}\u{0001f4ce}\u{0001f4cf}\u{0001f4d0}\u{0001f4d1}\u{0001f4d2}\u{0001f4d3}\u{0001f4d4}\u{0001f4d5}\u{0001f4d6}\u{0001f4d7}\u{0001f4d8}\u{0001f4d9}\u{0001f4da}\u{0001f4db}\u{0001f4dc}\u{0001f4dd}\u{0001f4de}\u{0001f4df}\u{0001f4e0}\u{0001f4e1}\u{0001f4e2}\u{0001f4e3}\u{0001f4e4}\u{0001f4e5}\u{0001f4e6}\u{0001f4e7}\u{0001f4e8}\u{0001f4e9}\u{0001f4ea}\u{0001f4eb}\u{0001f4ec}\u{0001f4ed}\u{0001f4ee}\u{0001f4ef}\u{0001f4f0}\u{0001f4f1}\u{0001f4f2}\u{0001f4f3}\u{0001f4f4}\u{0001f4f5}\u{0001f4f6}\u{0001f4f7}\u{0001f4f9}\u{0001f4fa}\u{0001f4fb}\u{0001f4fc}\u{0001f500}\u{0001f501}\u{0001f502}\u{0001f503}\u{0001f504}\u{0001f505}\u{0001f506}\u{0001f507}\u{0001f508}\u{0001f509}\u{0001f50a}\u{0001f50b}\u{0001f50c}\u{0001f50d}\u{0001f50e}\u{0001f50f}\u{0001f510}\u{0001f511}\u{0001f512}\u{0001f513}\u{0001f514}\u{0001f515}\u{0001f516}\u{0001f517}\u{0001f518}\u{0001f519}\u{0001f51a}\u{0001f51b}\u{0001f51c}\u{0001f51d}\u{0001f51e}\u{0001f51f}\u{0001f520}\u{0001f521}\u{0001f522}\u{0001f523}\u{0001f524}\u{0001f525}\u{0001f526}\u{0001f527}\u{0001f528}\u{0001f529}\u{0001f52a}\u{0001f52b}\u{0001f52c}\u{0001f52d}\u{0001f52e}\u{0001f52f}\u{0001f530}\u{0001f531}\u{0001f532}\u{0001f533}\u{0001f534}\u{0001f535}\u{0001f536}\u{0001f537}\u{0001f538}\u{0001f539}\u{0001f53a}\u{0001f53b}\u{0001f53c}\u{0001f53d}\u{0001f550}\u{0001f551}\u{0001f552}\u{0001f553}\u{0001f554}\u{0001f555}\u{0001f556}\u{0001f557}\u{0001f558}\u{0001f559}\u{0001f55a}\u{0001f55b}\u{0001f55c}\u{0001f55d}\u{0001f55e}\u{0001f55f}\u{0001f560}\u{0001f561}\u{0001f562}\u{0001f563}\u{0001f564}\u{0001f565}\u{0001f566}\u{0001f567}\u{0001f5fb}\u{0001f5fc}\u{0001f5fd}\u{0001f5fe}\u{0001f5ff}\u{0001f600}\u{0001f601}\u{0001f602}\u{0001f603}\u{0001f604}\u{0001f605}\u{0001f606}\u{0001f607}\u{0001f608}\u{0001f609}\u{0001f60a}\u{0001f60b}\u{0001f60c}\u{0001f60d}\u{0001f60e}\u{0001f60f}\u{0001f610}\u{0001f611}\u{0001f612}\u{0001f613}\u{0001f614}\u{0001f615}\u{0001f616}\u{0001f617}\u{0001f618}\u{0001f619}\u{0001f61a}\u{0001f61b}\u{0001f61c}\u{0001f61d}\u{0001f61e}\u{0001f61f}\u{0001f620}\u{0001f621}\u{0001f622}\u{0001f623}\u{0001f624}\u{0001f625}\u{0001f626}\u{0001f627}\u{0001f628}\u{0001f629}\u{0001f62a}\u{0001f62b}\u{0001f62c}\u{0001f62d}\u{0001f62e}\u{0001f62f}\u{0001f630}\u{0001f631}\u{0001f632}\u{0001f633}\u{0001f634}\u{0001f635}\u{0001f636}\u{0001f637}\u{0001f638}\u{0001f639}\u{0001f63a}\u{0001f63b}\u{0001f63c}\u{0001f63d}\u{0001f63e}\u{0001f63f}\u{0001f640}\u{0001f645}\u{0001f646}\u{0001f647}\u{0001f648}\u{0001f649}\u{0001f64a}\u{0001f64b}\u{0001f64c}\u{0001f64d}\u{0001f64e}\u{0001f64f}\u{0001f680}\u{0001f681}\u{0001f682}\u{0001f683}\u{0001f684}\u{0001f685}\u{0001f686}\u{0001f687}\u{0001f688}\u{0001f689}\u{0001f68a}\u{0001f68b}\u{0001f68c}\u{0001f68d}\u{0001f68e}\u{0001f68f}\u{0001f690}\u{0001f691}\u{0001f692}\u{0001f693}\u{0001f694}\u{0001f695}\u{0001f696}\u{0001f697}\u{0001f698}\u{0001f699}\u{0001f69a}\u{0001f69b}\u{0001f69c}\u{0001f69d}\u{0001f69e}\u{0001f69f}\u{0001f6a0}\u{0001f6a1}\u{0001f6a2}\u{0001f6a3}\u{0001f6a4}\u{0001f6a5}\u{0001f6a6}\u{0001f6a7}\u{0001f6a8}\u{0001f6a9}\u{0001f6aa}\u{0001f6ab}\u{0001f6ac}\u{0001f6ad}\u{0001f6ae}\u{0001f6af}\u{0001f6b0}\u{0001f6b1}\u{0001f6b2}\u{0001f6b3}\u{0001f6b4}\u{0001f6b5}\u{0001f6b6}\u{0001f6b7}\u{0001f6b8}\u{0001f6b9}\u{0001f6ba}\u{0001f6bb}\u{0001f6bc}\u{0001f6bd}\u{0001f6be}\u{0001f6bf}\u{0001f6c0}\u{0001f6c1}\u{0001f6c2}\u{0001f6c3}\u{0001f6c4}\u{0001f6c5}")
        let maxSet = minSetOld.mutableCopy() as! NSMutableCharacterSet
        maxSet.addCharacters(in: NSRange(location: 0x20e3, length: 1)) // Combining Enclosing Keycap (multi-face emoji)
        maxSet.addCharacters(in: NSRange(location: 0xfe0f, length: 1)) // Variation Selector
        maxSet.addCharacters(in: NSRange(location: 0x1f1e6, length: 26)) // Regional Indicator Symbol Letter
        
        let minSet8_3 = minSetOld.mutableCopy() as! NSMutableCharacterSet
        minSet8_3.addCharacters(in: NSRange(location: 0x1f3fb, length: 1)) // Color of skin
        
        
        // 1. Most of string does not contains emoji, so test the maximum range of charset first.
        guard let _ = self.rangeOfCharacter(from: maxSet as CharacterSet) else { return false }
        
        // 2. If the emoji can be detected by the minimum charset, return 'YES' directly.
        if let _ = self.rangeOfCharacter(from: (systemVersion.compareVersion("8.3") == .orderedAscending ? minSetOld : minSet8_3) as CharacterSet) {
            return true
        }

        // 3. The string contains some characters which may compose an emoji, but cannot detected with charset.
        // Use a regular expression to detect the emoji. It's slower than using charset.
        do {
            let regexOld = try NSRegularExpression(pattern: "(©️|®️|™️|〰️|🇨🇳|🇩🇪|🇪🇸|🇫🇷|🇬🇧|🇮🇹|🇯🇵|🇰🇷|🇷🇺|🇺🇸)", options: .caseInsensitive)
            let regex8_3 = try NSRegularExpression(pattern: "(©️|®️|™️|〰️|🇦🇺|🇦🇹|🇧🇪|🇧🇷|🇨🇦|🇨🇱|🇨🇳|🇨🇴|🇩🇰|🇫🇮|🇫🇷|🇩🇪|🇭🇰|🇮🇳|🇮🇩|🇮🇪|🇮🇱|🇮🇹|🇯🇵|🇰🇷|🇲🇴|🇲🇾|🇲🇽|🇳🇱|🇳🇿|🇳🇴|🇵🇭|🇵🇱|🇵🇹|🇵🇷|🇷🇺|🇸🇦|🇸🇬|🇿🇦|🇪🇸|🇸🇪|🇨🇭|🇹🇷|🇬🇧|🇺🇸|🇦🇪|🇻🇳)", options: .caseInsensitive)
            let regex9_0 = try NSRegularExpression(pattern: "(©️|®️|™️|〰️|🇦🇫|🇦🇽|🇦🇱|🇩🇿|🇦🇸|🇦🇩|🇦🇴|🇦🇮|🇦🇶|🇦🇬|🇦🇷|🇦🇲|🇦🇼|🇦🇺|🇦🇹|🇦🇿|🇧🇸|🇧🇭|🇧🇩|🇧🇧|🇧🇾|🇧🇪|🇧🇿|🇧🇯|🇧🇲|🇧🇹|🇧🇴|🇧🇶|🇧🇦|🇧🇼|🇧🇻|🇧🇷|🇮🇴|🇻🇬|🇧🇳|🇧🇬|🇧🇫|🇧🇮|🇰🇭|🇨🇲|🇨🇦|🇨🇻|🇰🇾|🇨🇫|🇹🇩|🇨🇱|🇨🇳|🇨🇽|🇨🇨|🇨🇴|🇰🇲|🇨🇬|🇨🇩|🇨🇰|🇨🇷|🇨🇮|🇭🇷|🇨🇺|🇨🇼|🇨🇾|🇨🇿|🇩🇰|🇩🇯|🇩🇲|🇩🇴|🇪🇨|🇪🇬|🇸🇻|🇬🇶|🇪🇷|🇪🇪|🇪🇹|🇫🇰|🇫🇴|🇫🇯|🇫🇮|🇫🇷|🇬🇫|🇵🇫|🇹🇫|🇬🇦|🇬🇲|🇬🇪|🇩🇪|🇬🇭|🇬🇮|🇬🇷|🇬🇱|🇬🇩|🇬🇵|🇬🇺|🇬🇹|🇬🇬|🇬🇳|🇬🇼|🇬🇾|🇭🇹|🇭🇲|🇭🇳|🇭🇰|🇭🇺|🇮🇸|🇮🇳|🇮🇩|🇮🇷|🇮🇶|🇮🇪|🇮🇲|🇮🇱|🇮🇹|🇯🇲|🇯🇵|🇯🇪|🇯🇴|🇰🇿|🇰🇪|🇰🇮|🇰🇼|🇰🇬|🇱🇦|🇱🇻|🇱🇧|🇱🇸|🇱🇷|🇱🇾|🇱🇮|🇱🇹|🇱🇺|🇲🇴|🇲🇰|🇲🇬|🇲🇼|🇲🇾|🇲🇻|🇲🇱|🇲🇹|🇲🇭|🇲🇶|🇲🇷|🇲🇺|🇾🇹|🇲🇽|🇫🇲|🇲🇩|🇲🇨|🇲🇳|🇲🇪|🇲🇸|🇲🇦|🇲🇿|🇲🇲|🇳🇦|🇳🇷|🇳🇵|🇳🇱|🇳🇨|🇳🇿|🇳🇮|🇳🇪|🇳🇬|🇳🇺|🇳🇫|🇲🇵|🇰🇵|🇳🇴|🇴🇲|🇵🇰|🇵🇼|🇵🇸|🇵🇦|🇵🇬|🇵🇾|🇵🇪|🇵🇭|🇵🇳|🇵🇱|🇵🇹|🇵🇷|🇶🇦|🇷🇪|🇷🇴|🇷🇺|🇷🇼|🇧🇱|🇸🇭|🇰🇳|🇱🇨|🇲🇫|🇻🇨|🇼🇸|🇸🇲|🇸🇹|🇸🇦|🇸🇳|🇷🇸|🇸🇨|🇸🇱|🇸🇬|🇸🇰|🇸🇮|🇸🇧|🇸🇴|🇿🇦|🇬🇸|🇰🇷|🇸🇸|🇪🇸|🇱🇰|🇸🇩|🇸🇷|🇸🇯|🇸🇿|🇸🇪|🇨🇭|🇸🇾|🇹🇼|🇹🇯|🇹🇿|🇹🇭|🇹🇱|🇹🇬|🇹🇰|🇹🇴|🇹🇹|🇹🇳|🇹🇷|🇹🇲|🇹🇨|🇹🇻|🇺🇬|🇺🇦|🇦🇪|🇬🇧|🇺🇸|🇺🇲|🇻🇮|🇺🇾|🇺🇿|🇻🇺|🇻🇦|🇻🇪|🇻🇳|🇼🇫|🇪🇭|🇾🇪|🇿🇲|🇿🇼)", options: .caseInsensitive)
            let regexRange = (systemVersion.compareVersion("8.3") == .orderedAscending ? regexOld : systemVersion.compareVersion("9.0") == .orderedAscending ? regex8_3 : regex9_0).rangeOfFirstMatch(in: self, options: .reportProgress, range: NSRange(location: 0, length: self.characters.count))
            return regexRange.location != NSNotFound
        } catch {
            
        }
        return false
    }
}

// MARK: - type cast

public extension String {
    
    public func charValue() -> Character {
        return Character(self)
    }
    
    /// String 转换 intValue = int32Value
    /// - returns: Int
    public func int32Value() -> Int32 {
        return Int32(self) ?? Int32(0)
    }
    
    /// String 转换 intValue
    /// - returns: Int
    public func intValue() -> Int {
        return Int(self) ?? Int(0)
    }
    
    /// String 转换 floatValue
    /// - returns: float
    public func floatValue() -> Float {
        return Float(self) ?? Float(0)
    }
    
    /// String 转换 doubleValue
    /// - returns: double
    public func doubleValue() -> Double {
        return Double(self) ?? Double(0)
    }
}

// MARK: - Dividing Strings

public extension String {
    
    public func substring(_ range: CountableRange<Int>) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: range.startIndex)
        let endIndex = self.index(self.startIndex, offsetBy: range.endIndex)
        let range = Range(uncheckedBounds: (lower: startIndex, upper: endIndex))
        return self.substring(with: range)
    }
    
    public func substring(to: Int) -> String? {
        if to >= self.characters.count || to < 0 { return nil }
        let index = self.index(self.startIndex, offsetBy: to)
        return self.substring(to: index)
    }
    
    public func substring(from: Int) -> String? {
        if from >= self.characters.count || from < 0 { return nil }
        let index = self.index(self.startIndex, offsetBy: from)
        return self.substring(from: index)
    }
}

// MARK: - tools

public extension String {
    
    public func compareVersion(_ rhs: String) -> ComparisonResult {
        var lhsComponents = self.components(separatedBy: ".")
        var rhsComponents = rhs.components(separatedBy: ".")
        let lhsComponentsLength = lhsComponents.count
        let rhsComponentsLength = rhsComponents.count
        var minLength = min(lhsComponentsLength, rhsComponentsLength)
        while minLength > 0 {
            minLength -= 1
            let lhsFirst = lhsComponents.removeFirst()
            let rhsFirst = rhsComponents.removeFirst()
            if lhsFirst.intValue() == rhsFirst.intValue() { continue}
            return lhsFirst.intValue() > rhsFirst.intValue() ? .orderedDescending : .orderedAscending
        }
        if max(lhsComponents.count, rhsComponents.count) == 0 { return .orderedSame }
        var (isLHS, remainingArray): (Bool, [String]) = lhsComponents.count > rhsComponents.count ? (true, lhsComponents) : (false, rhsComponents)
        var remainingLength = remainingArray.count
        while remainingLength > 0 {
            remainingLength -= 1
            if remainingArray.removeFirst() != "0" {
                return isLHS ? .orderedDescending : .orderedAscending
            }
            continue
        }
        return .orderedSame
    }
    
    public static func uuidString() -> String {
        let uuid = CFUUIDCreate(nil)
        let cfString = CFUUIDCreateString(nil, uuid)
        return (cfString as String?) ?? ""
    }
    
    public func trimming() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    public var isNotBlink: Bool {
        let blankSet = CharacterSet.whitespacesAndNewlines
        for char in self.unicodeScalars.enumerated() {
            if !blankSet.contains(char.element) {
                return true
            }
        }
        return false
    }
    
    public static func fromAnyJSONObject(_ anyJson: Any?) -> String {
        guard let anyJson = anyJson else {
            return ""
        }
        if let number = anyJson as? NSNumber {
            return number.stringValue
        }
        if let dict = anyJson as? [String:Any] {
            return dict.description
        }
        if let array = anyJson as? [Any] {
            return array.description
        }
        return anyJson as! String
    }
    
}

// MARK: - compatable for C String

public extension String {
    public var mutableCCharPointer: UnsafeMutablePointer<Int8> {
        let length = self.lengthOfBytes(using: .utf8)
        let result = UnsafeMutablePointer<Int8>.allocate(capacity: length)
        if let bytes = self.cString(using: .utf8) {
            for i in 0..<length {
                result[i] = bytes[i]
            }
        }
        return result
    }
    
    public var cCharPointer: UnsafePointer<Int8> {
        return UnsafePointer<Int8>(mutableCCharPointer)
    }
    
    public init(cCharArray: [Int8]) {
        let length = cCharArray.count
        let pointer = UnsafeMutablePointer<Int8>.allocate(capacity: length)
        for i in 0..<length {
            pointer[i] = cCharArray[i]
        }
        self.init(cString: pointer)
    }
    
}
