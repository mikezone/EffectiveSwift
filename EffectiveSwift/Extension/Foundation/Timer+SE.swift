//
//  Timer+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/23.
//  Copyright © 2017年 Mike. All rights reserved.
//

import Foundation

public extension Timer {
    
    @objc public class func _execBlock(timer: Timer) {
        if let closure = timer.userInfo as? ((_ timer: Timer) -> Swift.Void) {
            closure(timer)
        }
    }
    
//    @available(iOS 8.0, macOS 10.9, *)
//    public convenience init(timeInterval interval: TimeInterval, repeats: Bool, closure: @escaping (Timer) -> Swift.Void) {
//        self.init(timeInterval: interval, target: Timer.self, selector: #selector(Timer._execBlock(timer:)), userInfo: closure, repeats: repeats)
//    }
    
    @available(iOS 8.0, macOS 10.9, *)
    public class func timer(timeInterval interval: TimeInterval, repeats: Bool, closure: @escaping (Timer) -> Swift.Void) -> Timer {
        return Timer(timeInterval: interval, target: Timer.self, selector: #selector(Timer._execBlock(timer:)), userInfo: closure, repeats: repeats)
    }
    
    @available(iOS 8.0, macOS 10.9, *)
    public class func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, closure: @escaping (Timer) -> Swift.Void) -> Timer {
        let timer = Timer.timer(timeInterval: interval, repeats: repeats, closure: closure)
        timer.fire()
        RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
        return timer
    }
}
