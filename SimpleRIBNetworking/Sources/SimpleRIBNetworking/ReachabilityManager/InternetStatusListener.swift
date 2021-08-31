//
//  InternetStatusListener.swift
//  
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import Foundation
import Combine
import Alamofire

public enum InternetStatus: String {
    case reachable
    case notReachable
}

public protocol InternetStatusListening {
    var publisher: CurrentValueSubject<InternetStatus, Never> { get }
    
    var currentStatus: InternetStatus { get }
    
    func startMonitoring()
}

public class InternetStatusListener: InternetStatusListening {
    
    public static let shared: InternetStatusListener = InternetStatusListener()
    
    private var afReachabilityManager: AFReachabilityManagerProtocol?
    
    internal init(afReachabilityManager: AFReachabilityManagerProtocol? = NetworkReachabilityManager.default) {
        self.afReachabilityManager = afReachabilityManager
        
        let currentStatus: InternetStatus = afReachabilityManager?.isReachable == true ? .reachable : .notReachable
        self.publisher = .init(currentStatus)
    }
    
    public private(set) var publisher: CurrentValueSubject<InternetStatus, Never>
    
    public var currentStatus: InternetStatus {
        return publisher.value
    }
    
    public func startMonitoring() {
        _ = afReachabilityManager?.startListening(onQueue: .main,
                                                  onUpdatePerforming: listenForReachability(_:))
    }
    
    private func listenForReachability(_ status: NetworkReachabilityManager.NetworkReachabilityStatus) {
        switch status {
        case .reachable(_):
            publisher.send(.reachable)
        default:
            publisher.send(.notReachable)
        }
    }
}
