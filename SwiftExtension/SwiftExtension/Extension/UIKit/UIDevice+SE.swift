//
//  UIDevice+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/23.
//  Copyright © 2017年 Mike. All rights reserved.
//

import UIKit

extension UIDevice {
    
    public var isSimulator: Bool {
        return machineModel == "x86_64" || machineModel == "i386"
    }
    
    public var isPad: Bool {
        return UI_USER_INTERFACE_IDIOM() == .pad
    }

    public var isJailbroken: Bool {
        if isSimulator { return false } // Dont't check simulator
        
        // iOS9 URL Scheme query changed ...
        // NSURL *cydiaURL = [NSURL URLWithString:@"cydia://package"];
        // if ([[UIApplication sharedApplication] canOpenURL:cydiaURL]) return YES;
        
        let paths = ["/Applications/Cydia.app",
                     "/private/var/lib/apt/",
                     "/private/var/lib/cydia",
                     "/private/var/stash"]
        for path in paths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        
        let bash = fopen("/bin/bash", "r")
        if bash != nil {
            fclose(bash)
            return true
        }
        
        let path = String(format: "/private/%s", String.uuidString())
        do {
            try "test".write(toFile: path, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: path)
            return true
        } catch {
        
        }
        return false
    }
    
    public var canMakePhoneCalls: Bool {
        return UIApplication.shared.canOpenURL(URL(string: "tel://")!)
    }
    
    public var machineModel: String {
        var model = ""
        var size: size_t = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        let chars: UnsafeMutablePointer<CChar> = UnsafeMutablePointer<CChar>.allocate(capacity: size)
        sysctlbyname("hw.machine", chars, &size, nil, 0)
        model = String(cString: chars)
        chars.deinitialize()
        return model
    }
    
    public var machineModelName: String? {
        let nameMap = ["Watch1,1" : "Apple Watch  38mm",
                       "Watch1,2" : "Apple Watch 42mm",
                       "Watch2,3" : "Apple Watch Series 2 38mm",
                       "Watch2,4" : "Apple Watch Series 2 42mm",
                       "Watch2,6" : "Apple Watch Series 1 38mm",
                       "Watch1,7" : "Apple Watch Series 1 42mm",
                       
                       "iPod1,1" : "iPod touch 1",
                       "iPod2,1" : "iPod touch 2",
                       "iPod3,1" : "iPod touch 3",
                       "iPod4,1" : "iPod touch 4",
                       "iPod5,1" : "iPod touch 5",
                       "iPod7,1" : "iPod touch 6",
                       
                       "iPhone1,1" : "iPhone 1G",
                       "iPhone1,2" : "iPhone 3G",
                       "iPhone2,1" : "iPhone 3GS",
                       "iPhone3,1" : "iPhone 4 (GSM)",
                       "iPhone3,2" : "iPhone 4",
                       "iPhone3,3" : "iPhone 4 (CDMA)",
                       "iPhone4,1" : "iPhone 4S",
                       "iPhone5,1" : "iPhone 5",
                       "iPhone5,2" : "iPhone 5",
                       "iPhone5,3" : "iPhone 5c",
                       "iPhone5,4" : "iPhone 5c",
                       "iPhone6,1" : "iPhone 5s",
                       "iPhone6,2" : "iPhone 5s",
                       "iPhone7,1" : "iPhone 6 Plus",
                       "iPhone7,2" : "iPhone 6",
                       "iPhone8,1" : "iPhone 6s",
                       "iPhone8,2" : "iPhone 6s Plus",
                       "iPhone8,4" : "iPhone SE",
                       "iPhone9,1" : "iPhone 7",
                       "iPhone9,2" : "iPhone 7 Plus",
                       "iPhone9,3" : "iPhone 7",
                       "iPhone9,4" : "iPhone 7 Plus",
                       
                       "iPad1,1" : "iPad 1",
                       "iPad2,1" : "iPad 2 (WiFi)",
                       "iPad2,2" : "iPad 2 (GSM)",
                       "iPad2,3" : "iPad 2 (CDMA)",
                       "iPad2,4" : "iPad 2",
                       "iPad2,5" : "iPad mini 1",
                       "iPad2,6" : "iPad mini 1",
                       "iPad2,7" : "iPad mini 1",
                       "iPad3,1" : "iPad 3 (WiFi)",
                       "iPad3,2" : "iPad 3 (4G)",
                       "iPad3,3" : "iPad 3 (4G)",
                       "iPad3,4" : "iPad 4",
                       "iPad3,5" : "iPad 4",
                       "iPad3,6" : "iPad 4",
                       "iPad4,1" : "iPad Air",
                       "iPad4,2" : "iPad Air",
                       "iPad4,3" : "iPad Air",
                       "iPad4,4" : "iPad mini 2",
                       "iPad4,5" : "iPad mini 2",
                       "iPad4,6" : "iPad mini 2",
                       "iPad4,7" : "iPad mini 3",
                       "iPad4,8" : "iPad mini 3",
                       "iPad4,9" : "iPad mini 3",
                       "iPad5,1" : "iPad mini 4",
                       "iPad5,2" : "iPad mini 4",
                       "iPad5,3" : "iPad Air 2",
                       "iPad5,4" : "iPad Air 2",
                       "iPad6,3" : "iPad Pro (9.7 inch)",
                       "iPad6,4" : "iPad Pro (9.7 inch)",
                       "iPad6,7" : "iPad Pro (12.9 inch)",
                       "iPad6,8" : "iPad Pro (12.9 inch)",
                       
                       "AppleTV2,1" : "Apple TV 2",
                       "AppleTV3,1" : "Apple TV 3",
                       "AppleTV3,2" : "Apple TV 3",
                       "AppleTV5,3" : "Apple TV 4",
                       
                       "i386" : "Simulator x86",
                       "x86_64" : "Simulator x64"]
        return nameMap[machineModel]
    }
    
    public var systemUptime: Date {
        let interval = ProcessInfo.processInfo.systemUptime
        return Date(timeIntervalSinceNow: -interval)
    }
    
    public var diskSpace: UInt64? {
        do {
            let attrs = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            guard let space = attrs[.systemSize] as? UInt64 else { return nil}
            return space
        } catch {
            
        }
        return nil
    }
    
    public var diskSpaceFree: UInt64? {
        do {
            let attrs = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            guard let space = attrs[.systemFreeSize] as? UInt64 else { return nil}
            return space
        } catch {
            
        }
        return nil
    }
    
    public var diskSpaceUsed: UInt64? {
        guard let total = diskSpace, let free = diskSpaceFree, total > free
            else { return nil }
        return total - free
    }
}
