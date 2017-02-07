//
//  NotificationCenter+SE.swift
//  SwiftExtension
//
//  Created by Mike on 17/2/2.
//  Copyright © 2017年 Mike. All rights reserved.
//

import Foundation

public extension NotificationCenter {
    
    
    /// Posts a given notification to the receiver on main thread.
    ///
    /// - Parameters:
    ///   - noti: The notification to post.
    ///           An exception is raised if notification is nil.
    ///   - wait: A Boolean that specifies whether the current thread blocks
    ///           until after the specified notification is posted on the
    ///           receiver on the main thread. Specify YES to block this
    ///           thread; otherwise, specify NO to have this method return
    ///           immediately.
    public func postOnMainThread(notification noti: Notification, waitUntilDone wait: Bool = false) {
        if pthread_main_np() != 0 {
            return post(noti)
        }
        self.performSelector(onMainThread: #selector(_postNotification(notification:)), with: noti, waitUntilDone: wait)
    }
    
    
    /// Creates a notification with a given name and sender and posts it to the
    /// receiver on main thread.
    ///
    /// - Parameters:
    ///   - aName: The name of the notification.
    ///   - anObject: The object posting the notification.
    ///   - aUserInfo: Information about the the notification. May be nil.
    ///   - wait: A Boolean that specifies whether the current thread blocks
    ///           until after the specified notification is posted on the
    ///           receiver on the main thread. Specify YES to block this
    ///           thread; otherwise, specify NO to have this method return
    ///           immediately.
    public func postOnMainThread(name aName: NSNotification.Name, object anObject: Any? = nil, userInfo aUserInfo: [AnyHashable : Any]? = nil, waitUntilDone wait: Bool = false) {
        if pthread_main_np() != 0 {
            return post(name: aName, object: anObject, userInfo: aUserInfo)
        }
        var info = [String : Any](minimumCapacity: 3)
        info["name"] = aName
        if anObject != nil { info["object"] = anObject! }
        if aUserInfo != nil { info["userInfo"] = aUserInfo! }
        self.performSelector(onMainThread: #selector(_postNotification(info:)), with: info, waitUntilDone: wait)
    }
    
    @objc private func _postNotification(notification noti: Notification) {
        post(noti)
    }
    
    @objc private func _postNotification(info: [String : Any]) {
        guard let name = info["name"] as? NSNotification.Name else {
            return
        }
        let object = info["object"]
        let userInfo = info["userInfo"]
        post(name: name, object: object, userInfo: userInfo as? [AnyHashable : Any])
    }
}
