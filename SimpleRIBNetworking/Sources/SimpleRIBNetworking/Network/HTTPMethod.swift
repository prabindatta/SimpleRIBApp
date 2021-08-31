//
//  HTTPMethod.swift
//  
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import Foundation
import Alamofire

public enum HTTPMethod {
    case get
    case post
    
    var afHttpMethod: Alamofire.HTTPMethod {
        switch self {
        case .`get`: return Alamofire.HTTPMethod.`get`
        case .post: return Alamofire.HTTPMethod.post
        }
    }
}

