//
//  NetworkConfiguration.swift
//  
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import Foundation
import Alamofire

/// Interface for API spec declaration
///
/// A place to configure API scheme and API domain name
public protocol ApiConfiguration {
    
    /// API scheme
    ///
    ///  Examples
    /// - `https`
    var scheme: String { get }
        
    /// Rest API host name aka domain name
    ///
    /// Examples
    /// - api.seatgeek.com
    var host: String { get }
    
    /// Host port information, example: 8080
    ///
    /// This information is configured only for mock server in the App
    var port: Int? { get }
}

@dynamicMemberLookup
public protocol NetworkConfiguration {
    
    /// API  configuration
    var apiConfiguration: ApiConfiguration { get }
}

extension NetworkConfiguration {
    
    subscript<T>(dynamicMember keyPath: KeyPath<ApiConfiguration, T>) -> T {
        apiConfiguration[keyPath: keyPath]
    }
}
