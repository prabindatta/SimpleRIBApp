//
//  AppSettings.swift
//  SimpleRIBApp
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import Foundation
import Combine
import SimpleRIBCore

struct AppSettingsType {
    static let clientID = "client_id"
}

protocol AppSettingsConstructor {
    var _userDefaults: UserDefaultsManager { get }
}

protocol AppSettingsEnvironmentFetchable {
    
}

protocol AppSettingsManager {
    func registerDefaultPreferences()
}

typealias AppSettingsManageable = AppSettingsConstructor & AppSettingsManager

class AppSettings: AppSettingsManageable {
    
    let _userDefaults: UserDefaultsManager
        
    init(userDefaults: UserDefaultsManager = UserDefaults.standard)
    {
        _userDefaults = userDefaults
        
        registerDefaultPreferences()
    }
}

extension AppSettings {
    
    private struct Constants {
        static let bundleName = "Settings"
        static let fileExtension = "bundle"
        static let filePath = "Root.plist"
        static let settingsIdentifier = "PreferenceSpecifiers"
        static let preferenceSpecifierKey = "Key"
        static let preferenceSpecifierValue = "DefaultValue"
    }
    
    func registerDefaultPreferences() {
        let settingsBundle = Bundle.main.url(forResource: Constants.bundleName, withExtension: Constants.fileExtension)!
        let settings = NSDictionary(contentsOf: settingsBundle.appendingPathComponent(Constants.filePath))!
        let preferences = settings.object(forKey: Constants.settingsIdentifier) as! [[String : AnyObject]]
        
        var defaultsToRegister = [String: AnyObject]()
        for pref in preferences {
            if let key = pref[Constants.preferenceSpecifierKey] as? String, let val = pref[Constants.preferenceSpecifierValue] {
                defaultsToRegister[key] = val
            }
        }
        
        UserDefaults.standard.register(defaults: defaultsToRegister)
    }
}


