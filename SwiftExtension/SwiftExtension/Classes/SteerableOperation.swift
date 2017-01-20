//
//  SteerableOperation.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/20.
//  Copyright © 2017年 Mike. All rights reserved.
//

import Foundation

class SteerableOperation: Operation {
    private var isFinishValue: Bool = false
    private var isExecutingValue: Bool = false
    override var isFinished: Bool {
        get {
            return isFinishValue
        }
        set {
            self.willChangeValue(forKey: "isFinished")
            isFinishValue = newValue
            self.didChangeValue(forKey: "isFinished")
        }
    }
    override var isExecuting: Bool {
        get {
            return isExecutingValue
        }
        set {
            self.willChangeValue(forKey: "isExecuting")
            isExecutingValue = newValue
            self.didChangeValue(forKey: "isExecuting")
        }
    }
}
