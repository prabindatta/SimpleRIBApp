//
//  AppConfiguration.swift
//  SimpleRIBApp
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import Foundation
import SimpleRIBCore

protocol AppConfigurationFetchable {
    static func clientID(with defaults: UserDefaultsManager) -> String?
}

extension AppConfigurationFetchable {
    
    static func clientID(with defaults: UserDefaultsManager = UserDefaults.standard) -> String? {
        clientID(with: defaults)
    }
}

struct AppConfiguration: AppConfigurationFetchable {
    
    static func clientID(with defaults: UserDefaultsManager) -> String? {
        defaults.value(forKey: AppSettingsType.clientID) as? String
    }
}
