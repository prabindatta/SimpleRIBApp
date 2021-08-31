//
//  UserDefaultsManagable.swift
//  
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import Foundation

public protocol UserDefaultsManager {
    
    func set(_ value: Any?, forKey: String)
    
    func data(forKey: String) -> Data?
    func value(forKey: String) -> Any?
    
    func removeObject(forKey: String)
    func removePersistentDomain(forName: String)

    @discardableResult
    func synchronize() -> Bool
}

public extension UserDefaultsManager {
    
    func publishable() throws -> UserDefaults {
        guard let self = self as? UserDefaults else {
            throw NSError(domain: "SimpleRIBCore", code: 0, userInfo: ["LocalizedDecription": "\(self) does not conform to type  UserDefaults"])
        }
        return self
    }
}

extension UserDefaults: UserDefaultsManager {}
