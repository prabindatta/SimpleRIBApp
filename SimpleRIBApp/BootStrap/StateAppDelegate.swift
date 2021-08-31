//
//  StateAppDelegate.swift
//  SimpleRIBApp
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import UIKit
import Combine

protocol AppLifeCycleStateListener {
    typealias AppLifeCycleStateSubject = PassthroughSubject<Void, Never>
    
    var subjectAppCycleEnterdBackground: AppLifeCycleStateSubject { get }
    var subjectAppCycleBecomeActive: AppLifeCycleStateSubject { get }
    var subjectAppCycleEnterForeground: AppLifeCycleStateSubject { get }
    var subjectAppCycleWillTerminate: AppLifeCycleStateSubject { get }
}

class AppServiceState: AppDelegateType, AppLifeCycleStateListener {

    let subjectAppCycleEnterdBackground = AppLifeCycleStateSubject()
    func applicationDidEnterBackground(_ application: UIApplication) {
        subjectAppCycleEnterdBackground.send()
    }

    let subjectAppCycleBecomeActive = AppLifeCycleStateSubject()
    func applicationDidBecomeActive(_ application: UIApplication) {
        subjectAppCycleBecomeActive.send()
    }
    
    let subjectAppCycleEnterForeground = AppLifeCycleStateSubject()
    func applicationWillEnterForeground(_ application: UIApplication) {
        subjectAppCycleEnterForeground.send()
    }
    
    let subjectAppCycleWillTerminate = AppLifeCycleStateSubject()
    func applicationWillTerminate(_ application: UIApplication) {
        subjectAppCycleWillTerminate.send()
    }
}
