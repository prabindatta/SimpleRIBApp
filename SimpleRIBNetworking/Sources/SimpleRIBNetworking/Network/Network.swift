//
//  Network.swift
//  
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

/// Interface for supplying `NetworkConfiguration` to Network Interface
public protocol NetworkConfigurable {
    
    /// Function to supply and cache`NetworkConfiguration`
    func configure(with networkConfiguration: NetworkConfiguration)
}

/// Interface for Networking dependencies
@dynamicMemberLookup
public protocol Networking {
    
    /// NetworkConfiguration with API and APIGEE flag declarations
    var configuration: NetworkConfiguration { get }
}

/// Interface for App Network initialization
public class Network: Networking {
    
    /// Singleton instance of Networking
    public static let shared = Network()
    
    /// Cached`NetworkConfiguration`
    public var configuration: NetworkConfiguration {
        return _configuration
    }

    // MARK: - Private
    private var _configuration: NetworkConfiguration!
    
    #if DEBUG
    internal init() { }
    #else
    private init() { }
    #endif
}

/// Extension interface of Network conforming to `NetworkConfigurable`
extension Network: NetworkConfigurable {
        
    /// Function to supply and cache `NetworkConfiguration`
    /// - Parameter networkConfiguration: Model conforming to ` NetworkConfiguration`
    public func configure(with networkConfiguration: NetworkConfiguration) {
        self._configuration = networkConfiguration
    }
}

extension Networking {
    
    subscript<T>(dynamicMember keyPath: KeyPath<NetworkConfiguration, T>) -> T {
        configuration[keyPath: keyPath]
    }
}
