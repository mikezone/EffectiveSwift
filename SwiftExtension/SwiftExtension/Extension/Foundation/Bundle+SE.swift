//
//  Bundle+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/23.
//  Copyright © 2017年 Mike. All rights reserved.
//

import Foundation

extension Bundle {
    public static func bundle(named: String) -> Bundle? {
        guard let bundlePath = Bundle.main.path(forResource: named, ofType: "bundle") else {
            return nil
        }
        return Bundle(path: bundlePath)
    }
    
    public static func path(forResource name: String?, ofType ext: String?, inBundle bundleName: String) -> String? {
        // let bundlePath = Bundle.main.path(forResource: bundleName, ofType: "bundle")
        // return Bundle.path(forResource: name, ofType: nil, inDirectory: bundlePath ?? "")
        return Bundle.bundle(named: bundleName)?.path(forResource: name, ofType: ext)
    }
    
    public static func path(forResource name: String?, ofType ext: String?, inDirectory subpath: String?, inBundle bundleName: String) -> String? {
        return Bundle.bundle(named: bundleName)?.path(forResource: name, ofType: ext, inDirectory: subpath)
    }
}
