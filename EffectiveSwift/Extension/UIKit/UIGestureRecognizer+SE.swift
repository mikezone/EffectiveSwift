//
//  UIGestureRecognizer+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/23.
//  Copyright © 2017年 Mike. All rights reserved.
//

import UIKit

fileprivate var block_key: Int8 = 0

public extension UIGestureRecognizer {
    public convenience init(actionBlock: @escaping (UIGestureRecognizer) -> Swift.Void) {
        self.init()
        self.addActionBlock(actionBlock)
    }
    
    public func addActionBlock(_ actionBlock: @escaping (UIGestureRecognizer) -> Swift.Void) {
        let target = _UIGestureRecognizerBlockTarget(block: actionBlock)
        self.addTarget(target, action: #selector(_UIGestureRecognizerBlockTarget.invoke(sender:)))
        var targets = self._allUIGestureRecognizerBlockTargets
        targets.append(target)
    }
    
    public func removeAllActionBlocks() {
        var targets = self._allUIGestureRecognizerBlockTargets
        for target in targets {
            self.removeTarget(target, action:  #selector(_UIGestureRecognizerBlockTarget.invoke(sender:)))
        }
        targets.removeAll()
    }
    
    private var _allUIGestureRecognizerBlockTargets: [_UIGestureRecognizerBlockTarget] {
        get {
            var targets = objc_getAssociatedObject(self, &block_key) as? [_UIGestureRecognizerBlockTarget]
            if targets == nil {
                targets = [_UIGestureRecognizerBlockTarget]()
                objc_setAssociatedObject(self, &block_key, targets, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return targets!
        }
        set {
            objc_setAssociatedObject(self, &block_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

fileprivate class _UIGestureRecognizerBlockTarget: NSObject {
    internal var block: ((UIGestureRecognizer) -> Swift.Void)!
    
    private override init() {super.init()}
    public convenience init(block: @escaping (UIGestureRecognizer) -> Swift.Void) {
        self.init()
        self.block = block
    }
    
    @objc public func invoke(sender: UIGestureRecognizer) {
        if block != nil {
            block(sender)
        }
    }
}
