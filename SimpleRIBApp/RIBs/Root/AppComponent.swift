//
//  AppComponent.swift
//  SimpleRIBApp
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import RIBs

class AppComponent: Component<EmptyComponent>, RootDependency {
    
    let appPreferences: AppSettingsConstructor
    
    init(appPreferences: AppSettingsConstructor = AppSettings()) {
        self.appPreferences = appPreferences
        super.init(dependency: EmptyComponent())
    }
}
