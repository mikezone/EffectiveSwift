//
//  Data+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/20.
//  Copyright © 2017年 Mike. All rights reserved.
//

import Foundation

extension Data {
    
    public var md5String: String {
        let messageDigestLength = Int(CC_MD5_DIGEST_LENGTH)
        let messageDigestResult = UnsafeMutablePointer<UInt8>.allocate(capacity: messageDigestLength)
        self.withUnsafeBytes { (pointer: UnsafePointer<UInt8>) -> Void in
            CC_MD5(pointer, UInt32(self.count), messageDigestResult)
        }
        messageDigestResult.deinitialize()
        return String(format: "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      messageDigestResult[0], messageDigestResult[1], messageDigestResult[2], messageDigestResult[3],
                      messageDigestResult[4], messageDigestResult[5], messageDigestResult[6], messageDigestResult[7],
                      messageDigestResult[8], messageDigestResult[9], messageDigestResult[10], messageDigestResult[11],
                      messageDigestResult[12], messageDigestResult[13], messageDigestResult[14], messageDigestResult[15])
    }
    
    public var md5Data: Data {
        let messageDigestLength = Int(CC_MD5_DIGEST_LENGTH)
        let messageDigestResult = UnsafeMutablePointer<UInt8>.allocate(capacity: messageDigestLength)
        self.withUnsafeBytes { (pointer: UnsafePointer<UInt8>) -> Void in
            CC_MD5(pointer, UInt32(self.count), messageDigestResult)
        }
        return Data(bytes: messageDigestResult, count: messageDigestLength)
    }
}
