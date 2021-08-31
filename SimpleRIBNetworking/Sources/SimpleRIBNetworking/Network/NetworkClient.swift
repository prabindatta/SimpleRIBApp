//
//  NetworkClient.swift
//  
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import Foundation
import Combine
import Alamofire

public struct NetworkClient {
        
    public let networkInterface: Networking
    public let networkModel: NetworkModel
    
    public init(networkInterface: Networking = Network.shared,
                networkModel: NetworkModel)
    {
        self.networkInterface = networkInterface
        self.networkModel = networkModel
    }
}

extension NetworkClient {
    
    var url: URL {
        
        var components = URLComponents()
        components.scheme = networkInterface.scheme
        components.host = networkInterface.host
        components.path = networkModel.route
        components.port = networkInterface.port
        
        let url = components.url!
                
        return url
    }
}

extension NetworkClient {
    
    func networkRequest() -> NetworkRequesting {
        
        return NetworkRequest(url: url,
                              method: networkModel.httpMethod.afHttpMethod,
                              parameters: networkModel.parameters)
    }
}

extension NetworkClient {
    
    func execute() -> AnyPublisher<Data, NetworkingError> {
        let request = networkRequest()
        return request
            .execute()
//            .compactMap({ data in
//                print("Data \(String(data: data, encoding: .utf8))")
//                return data
//            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension NetworkClient {
    
    func execute() -> AnyPublisher<Void, NetworkingError> {
        execute()
            .map { (data: Data) -> Void in () }
            .eraseToAnyPublisher()
    }
}

extension NetworkClient {

    func execute<T: Decodable>() -> AnyPublisher<T, NetworkingError> {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return execute()
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is NetworkingError:
                    return error as! NetworkingError
                default:
                    return NetworkingError.unknown(message: "Response data model serializing error: " + error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
}
