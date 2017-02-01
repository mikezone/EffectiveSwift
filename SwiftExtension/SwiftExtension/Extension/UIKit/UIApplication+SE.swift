//
//  UIApplication+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/26.
//  Copyright © 2017年 Mike. All rights reserved.
//

import UIKit

extension UIApplication {

    public var documentsURL: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    }
    
    public var documentsPath: String? {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }
    
    public var cachesURL: URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last
    }
    
    public var cachesPath: String? {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    }
    
    public var libraryURL: URL? {
        return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last
    }
    
    public var libraryPath: String? {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
    }
    
    public var isPirated: Bool {
        if UIDevice.current.isSimulator { return true } // Simulator is not from appstore
        if getgid() <= 10 { return true } // process ID shouldn't be root
        
        if Bundle.main.infoDictionary?["SignerIdentity"] != nil { return true}
        
        if !_fileExist("_CodeSignature") { return true}
        
        if !_fileExist("SC_Info") { return true }
        
        //if someone really want to crack your app, this method is useless..
        //you may change this method's name, encrypt the code and do more check..
        return false
    }
    
    
    private func _fileExist(_ fileName: String, _ inMainBundle: Void = ()) -> Bool {
        let bundlePath = Bundle.main.bundlePath
        let path = String(format: "%s/%s", bundlePath, fileName)
        return FileManager.default.fileExists(atPath: path)
    }
    
    public var appBundleName: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    
    public var appBundleID: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String
    }
    
    public var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    public var appBuildVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
    
    public var isBeingDebugged: Bool {
        var size = MemoryLayout<kinfo_proc>.size
        var info: kinfo_proc = kinfo_proc()
        memset(&info, 0, MemoryLayout<kinfo_proc>.size)
        let name = UnsafeMutablePointer<Int32>.allocate(capacity: 4)
        name[0] = CTL_KERN
        name[1] = KERN_PROC
        name[2] = KERN_PROC_PID
        name[3] = getpid()
        
        let ret: Int32 = 0
        if ret == sysctl(name, 4, &info, &size, nil, 0) {
            return ret != 0
        }
        return (info.kp_proc.p_flag & P_TRACED) != 0
    }
    
//    public var memoryUsage: UInt64? {
//        var info = task_basic_info()
//        var size = MemoryLayout<task_basic_info>.size
//        
////        var info: task_info_t = UnsafeMutablePointer<Int32>.allocate(capacity: size)
//        
//        var usize = UInt32(size)
////        var size: mach_msg_type_number_t = mach_msg_type_number_t(MemoryLayout<task_basic_info>.size)
//        
//        let kern = task_info(mach_task_self_, task_flavor_t(TASK_BASIC_INFO), info, &usize)
//        
//        return kern != KERN_SUCCESS ? nil : info
//    }
    
//    public var cpuUsage: UInt64 {
//    
//    }
    
    public static var isAppExtension: Bool {
        if Bundle.main.bundlePath.hasSuffix(".appex") { return true }
        guard let clazz = NSClassFromString("UIApplication") else { return true }
        return !clazz.responds(to: Selector(("shared")))
    }
}
