//
//  AFReachabilityManagerMock.swift
//  
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import XCTest
import Alamofire
@testable import SimpleRIBNetworking

class AFReachabilityManagerMock: AFReachabilityManagerProtocol {
    
    var shouldReturnReachable: Bool = false
    
    var isReachable: Bool {
        shouldReturnReachable
    }
    
    var didCallStartListening: Bool = false
    
    var listener: NetworkReachabilityManager.Listener?
    
    func startListening(onQueue queue: DispatchQueue,
                        onUpdatePerforming listener: @escaping NetworkReachabilityManager.Listener) -> Bool {
        
        self.didCallStartListening = true
        self.listener = listener
        return true
    }
    
    func sendStatus(_ status: NetworkReachabilityManager.NetworkReachabilityStatus) {
        self.listener?(status)
    }
}
