//
//  UIControl+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/23.
//  Copyright © 2017年 Mike. All rights reserved.
//

import UIKit

fileprivate var block_key: Int8 = 0

public extension UIControl {
    
    public func removeAllTargets() {
        for target in self.allTargets {
            self.removeTarget(target, action: nil, for: .allEvents)
        }
        _allUIControlBlockTargets.removeAll()
    }
    
    public func setTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents) {
        guard let target = target else { return }
        let targets = self.allTargets
        for currentTarget in targets {
            if let actions = self.actions(forTarget: currentTarget, forControlEvent: controlEvents) {
                for currentAction in actions {
                    self.removeTarget(currentTarget, action: NSSelectorFromString(currentAction), for: controlEvents)
                }
            }
        }
        self.addTarget(target, action: action, for: controlEvents)
    }
    
    public func addBlock(_ block: @escaping (Any) -> Swift.Void, for controlEvents: UIControlEvents) {
        let target = _UIControlBlockTarget(block: block, events: controlEvents)
        self.addTarget(target, action: #selector(_UIControlBlockTarget.invoke(sender:)), for: controlEvents)
        self._allUIControlBlockTargets.append(target)
    }
    
    public func setBlock(_ block: @escaping (Any) -> Swift.Void, for controlEvents: UIControlEvents) {
        self.removeAllBlocks(for: controlEvents)
        self.addBlock(block, for: controlEvents)
    }
    
    public func removeAllBlocks(for controlEvents: UIControlEvents) {
        var targets = self._allUIControlBlockTargets
        var removes = [_UIControlBlockTarget]()
        for target in targets {
            if !target.events.intersection(controlEvents).isEmpty {
                let newEvent = target.events.subtracting(controlEvents)
                if !newEvent.isEmpty {
                    self.removeTarget(target, action: #selector(_UIControlBlockTarget.invoke(sender:)), for: target.events)
                    target.events = newEvent
                    self.addTarget(target, action: #selector(_UIControlBlockTarget.invoke(sender:)), for: target.events)
                } else {
                    self.removeTarget(target, action: #selector(_UIControlBlockTarget.invoke(sender:)), for: target.events)
                    removes.append(target)
                }
            }
        }
        for willRemove in removes {
            if targets.contains(willRemove) {
                targets.remove(at: targets.index(of: willRemove)!)
            }
        }
        self._allUIControlBlockTargets = targets
    }
    
    private var _allUIControlBlockTargets: [_UIControlBlockTarget] {
        get {
            var targets = objc_getAssociatedObject(self, &block_key) as? [_UIControlBlockTarget]
            if targets == nil {
                targets = [_UIControlBlockTarget]()
                objc_setAssociatedObject(self, &block_key, targets, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return targets!
        }
        set {
            objc_setAssociatedObject(self, &block_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

fileprivate class _UIControlBlockTarget : NSObject {
    internal var block: ((Any) -> Swift.Void)!
    internal var events: UIControlEvents!
    
    private override init() {super.init()}
    public convenience init(block: @escaping (Any) -> Swift.Void, events: UIControlEvents) {
        self.init()
        self.block = block
        self.events = events
    }
    
    @objc public func invoke(sender: Any) {
        if block != nil {
            block(sender)
        }
    }
}
