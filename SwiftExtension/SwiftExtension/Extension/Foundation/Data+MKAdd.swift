//
//  Data+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/20.
//  Copyright © 2017年 Mike. All rights reserved.
//

import Foundation

// MARK: - Hash

extension Data {
    
    public var md2String: String? {
        return String(data: self, encoding: .utf8)?.md2String
    }
    
    public var md4String: String? {
        return String(data: self, encoding: .utf8)?.md4String
    }
    
    public var md5String: String? {
        return String(data: self, encoding: .utf8)?.md5String
    }
    
    public var sha1String: String? {
        return String(data: self, encoding: .utf8)?.sha1String
    }
    
    public var sha224String: String? {
        return String(data: self, encoding: .utf8)?.sha224String
    }
    
    public var sha256String: String? {
        return String(data: self, encoding: .utf8)?.sha256String
    }
    
    public var sha384String: String? {
        return String(data: self, encoding: .utf8)?.sha384String
    }
    
    public var sha512String: String? {
        return String(data: self, encoding: .utf8)?.sha512String
    }
    
    public func hmacString(_ algorithm: CCHmacAlgorithm, _ key: String) -> String? {
        return String(data: self, encoding: .utf8)?.hmacString(algorithm, key)
    }
    
    public func hmacMD5String(_ key: String) -> String? {
        return hmacString(CCHmacAlgorithm(kCCHmacAlgMD5), key)
    }
    
    public func hmacSHA1String(_ key: String) -> String? {
        return hmacString(CCHmacAlgorithm(kCCHmacAlgSHA1), key)
    }
    
    public func hmacSHA224String(_ key: String) -> String? {
        return hmacString(CCHmacAlgorithm(kCCHmacAlgSHA224), key)
    }
    
    public func hmacSHA256String(_ key: String) -> String? {
        return hmacString(CCHmacAlgorithm(kCCHmacAlgSHA256), key)
    }
    
    public func hmacSHA384String(_ key: String) -> String? {
        return hmacString(CCHmacAlgorithm(kCCHmacAlgSHA384), key)
    }
    
    public func hmacSHA512String(_ key: String) -> String? {
        return hmacString(CCHmacAlgorithm(kCCHmacAlgSHA512), key)
    }
    
    public var crc32String: String? {
        guard let crc32Value = self.crc32Value else { return nil }
        return String(format: "%08x", crc32Value)
    }
    
    public var crc32Value: UInt? {
        return String(data: self, encoding: .utf8)?.crc32Value
    }
    
}

// MARK: - Encrypt and Decrypt

extension Data {
    
    public func aes256Encrypt(_ key: Data, _ iv: Data) -> Data? {
        if key.count != 16 && key.count != 24 && key.count != 32 {
            return nil
        }
        
        if iv.count != 16 && key.count != 0 {
            return nil
        }
        
        let bufferSize = self.count + kCCBlockSizeAES128
        let buffer = UnsafeMutablePointer<CChar>.allocate(capacity: bufferSize)
        var encryptedSize: Int = 0;
        let cryptStatus = CCCrypt(CCOperation(kCCEncrypt),
                                  CCAlgorithm(kCCAlgorithmAES128),
                                  CCOptions(kCCOptionPKCS7Padding),
                                  String(data: key, encoding: .utf8)?.cString(using: .utf8),
                                  key.count,
                                  String(data: iv, encoding: .utf8)?.cString(using: .utf8),
                                  String(data: self, encoding: .utf8)?.cString(using: .utf8),
                                  self.count,
                                  buffer,
                                  bufferSize,
                                  &encryptedSize);
        if cryptStatus == CCCryptorStatus(kCCSuccess) {
            let result = Data(bytes: buffer, count: encryptedSize)
            free(buffer);
            return result;
        } else {
            free(buffer);
            return nil;
        }
    }
    
    public func aes256Decrypt(_ key: Data, _ iv: Data) -> Data? {
        if key.count != 16 && key.count != 24 && key.count != 32 {
            return nil
        }
        
        if iv.count != 16 && key.count != 0 {
            return nil
        }
        
        let bufferSize = self.count + kCCBlockSizeAES128
        let buffer = UnsafeMutablePointer<CChar>.allocate(capacity: bufferSize)
        var encryptedSize: Int = 0;
        let cryptStatus = CCCrypt(CCOperation(kCCDecrypt),
                                  CCAlgorithm(kCCAlgorithmAES128),
                                  CCOptions(kCCOptionPKCS7Padding),
                                  String(data: key, encoding: .utf8)?.cString(using: .utf8),
                                  key.count,
                                  String(data: iv, encoding: .utf8)?.cString(using: .utf8),
                                  String(data: self, encoding: .utf8)?.cString(using: .utf8),
                                  self.count,
                                  buffer,
                                  bufferSize,
                                  &encryptedSize);
        if cryptStatus == CCCryptorStatus(kCCSuccess) {
            let result = Data(bytes: buffer, count: encryptedSize)
            free(buffer);
            return result;
        } else {
            free(buffer);
            return nil;
        }
    }
}
