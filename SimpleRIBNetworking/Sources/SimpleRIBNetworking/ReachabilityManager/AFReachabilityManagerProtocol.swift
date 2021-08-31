//
//  AFReachabilityManagerProtocol.swift
//  
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import Foundation
import Alamofire

protocol AFReachabilityManagerProtocol {
    
    var isReachable: Bool { get }
    
    func startListening(onQueue queue: DispatchQueue,
                        onUpdatePerforming listener: @escaping NetworkReachabilityManager.Listener) -> Bool
}

extension NetworkReachabilityManager: AFReachabilityManagerProtocol { }
