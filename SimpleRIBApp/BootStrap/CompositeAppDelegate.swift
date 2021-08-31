//
//  CompositeAppDelegate.swift
//  SimpleRIBApp
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import UIKit
import SimpleRIBCore

typealias AppDelegateType = UIResponder & UIApplicationDelegate

class CompositeAppDelegate: AppDelegateType {
    
    let appDelegates: [AppDelegateType]

    init(appDelegates: [AppDelegateType]) {
        self.appDelegates = appDelegates
    }
}

extension CompositeAppDelegate {
    
    func application(_ application: UIApplication,
                     willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
    {
        self.appDelegates.concurrentPerform { _ = $0.application?(application, willFinishLaunchingWithOptions: launchOptions) }
        return true
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
    {
        self.appDelegates.concurrentPerform { _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions) }
        return true
    }
}

extension CompositeAppDelegate {
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        self.appDelegates.concurrentPerform { $0.applicationDidEnterBackground?(application) }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        self.appDelegates.concurrentPerform { $0.applicationDidBecomeActive?(application) }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.appDelegates.concurrentPerform { $0.applicationWillEnterForeground?(application) }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.appDelegates.concurrentPerform { $0.applicationWillTerminate?(application) }
    }
}

extension CompositeAppDelegate {
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        self.appDelegates.concurrentPerform { $0.application?(application,
                                               didRegisterForRemoteNotificationsWithDeviceToken: deviceToken) }
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        self.appDelegates.concurrentPerform { $0.application?(application,
                                               didFailToRegisterForRemoteNotificationsWithError: error) }
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        self.appDelegates.concurrentPerform { $0.application?(application,
                                               didReceiveRemoteNotification: userInfo,
                                               fetchCompletionHandler: completionHandler) }
    }
}

extension CompositeAppDelegate {
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool
    {
        var status = true
        self.appDelegates.concurrentPerform {
            status = $0.application?(app, open: url, options: options) ?? false
        }
        return status
    }
}
