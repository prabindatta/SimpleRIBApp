//
//  NetworkService.swift
//  
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import Foundation
import Combine
import Alamofire

public protocol NetworkService {
    var networkClient: NetworkClient { get }
}

public extension NetworkService {
    
    // Data
    func execute() -> AnyPublisher<Data, NetworkingError> {
        networkClient.execute()
    }
    
    // Void
    func execute() -> AnyPublisher<Void, NetworkingError> {
        networkClient.execute()
    }

    // Decodable
    func execute<T: Decodable>() -> AnyPublisher<T, NetworkingError> {
        networkClient.execute()
    }
}
