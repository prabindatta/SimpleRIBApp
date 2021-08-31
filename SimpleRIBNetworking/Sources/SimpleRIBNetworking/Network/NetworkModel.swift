//
//  NetworkModel.swift
//  
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import Foundation
import Alamofire

public struct NetworkModel {
    
    public let route: String
    public let httpMethod: HTTPMethod
    public let parameters: [String: Any]?
    
    public init(route: String, httpMethod: HTTPMethod, parameters: Encodable? = nil) {
        self.route = route
        self.httpMethod = httpMethod
        self.parameters = parameters?.dictionary
    }
}

extension Encodable {
    
    var dictionary: [String: Any]? {
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        guard let data = try? encoder.encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
