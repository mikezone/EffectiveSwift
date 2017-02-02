//
//  DispatchQueue+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/24.
//  Copyright © 2017年 Mike. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    public var isMainQueue: Bool {
        return pthread_main_np() != 0
    }
    
    public static func asyncOnMainQueue(execute work: @escaping @convention(block) () -> Swift.Void) {
        if pthread_main_np() != 0 {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }
    
    public static func syncOnMainQueue(execute work: @escaping @convention(block) () -> Swift.Void) {
        if pthread_main_np() != 0 {
            work()
        } else {
            DispatchQueue.main.sync(execute: work)
        }
    }
}
