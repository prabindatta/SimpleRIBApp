//
//  StartupConfiguratorAppDelegate.swift
//  SimpleRIBApp
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import UIKit
import RIBs
import SimpleRIBNetworking

class StartupConfiguratorAppDelegate: AppDelegateType {
    
    var window: UIWindow?
    private var launchRouter: LaunchRouting?
    var internetStatusListener: InternetStatusListening = InternetStatusListener.shared
    
    func application(_ application: UIApplication,
                     willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
    {
        internetStatusListener.startMonitoring()
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let launchRouter = RootBuilder(dependency: AppComponent()).build()
        self.launchRouter = launchRouter
        launchRouter.launch(from: window)
        
        return true
    }
}
