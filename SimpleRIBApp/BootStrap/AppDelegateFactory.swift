//
//  AppDelegateFactory.swift
//  SimpleRIBApp
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

enum AppDelegateFactory {
    static func makeAppDelegate() -> AppDelegateType {
        return CompositeAppDelegate(appDelegates: [PushNotificationsAppDelegate(), StartupConfiguratorAppDelegate(), ThirdPartiesConfiguratorAppDelegate()])
    }
}
