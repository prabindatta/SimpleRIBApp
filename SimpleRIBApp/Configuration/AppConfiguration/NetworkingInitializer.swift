//
//  NetworkingInitializer.swift
//  SimpleRIBApp
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import Foundation
import SimpleRIBNetworking

struct NetworkingInitializer {
    
    private let schmea =  "https"
    private let host = "api.seatgeek.com"

    let networkEngine: NetworkConfigurable
    
    init(networkingEngine: NetworkConfigurable = Network.shared)
    {
        self.networkEngine = networkingEngine
    }
    
    func initialize() {

        struct ApiConfiguration: SimpleRIBNetworking.ApiConfiguration {
            let scheme: String
            let host: String
            let port: Int?
        }
        
        struct NetworkConfiguration: SimpleRIBNetworking.NetworkConfiguration {
            var apiConfiguration: SimpleRIBNetworking.ApiConfiguration
        }
        
        let scheme = self.schmea
        let host = self.host
        
        let apiNetworkConfig = ApiConfiguration(scheme: scheme, host: host, port: nil)
        let networkConfig = NetworkConfiguration(apiConfiguration: apiNetworkConfig)
        
        self.networkEngine.configure(with: networkConfig)
    }
}
