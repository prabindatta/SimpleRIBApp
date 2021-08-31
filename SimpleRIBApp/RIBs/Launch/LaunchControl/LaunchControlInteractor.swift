//  Copyright © T-Mobile USA Inc. All rights reserved.

import UIKit
import RIBs
import SimpleRIBNetworking
import Combine

protocol LaunchControlRouting: Routing {
    func attachNoNetwork()
    func deAttachNetwork()
}

protocol LaunchControlListener: AnyObject {
    func launchSequenceStarted()
    func launchSequenceCompleted()
}

final class LaunchControlInteractor: Interactor, LaunchControlInteractable {

    weak var router: LaunchControlRouting?
    weak var listener: LaunchControlListener?

    override init() {
        super.init()
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        if InternetStatusListener.shared.currentStatus == .reachable {
            listener?.launchSequenceStarted()
            subscribeForLaunchEvents()
        } else {
            router?.attachNoNetwork()
        }
        
        //TODO: Yet to decide about this logic
//        InternetStatusListener.shared.publisher.sink { [weak self] internetStatus in
//            if internetStatus == .reachable {
//                self?.subscribeForLaunchEvents()
//                self?.router?.deAttachNetwork()
//            } else {
//                self?.router?.attachNoNetwork()
//            }
//        }.store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        router?.deAttachNetwork()
    }
    
    func subscribeForLaunchEvents() {
        if let _ = AppConfiguration.clientID() {
            DispatchQueue.main.async {
                self.listener?.launchSequenceCompleted()
            }
        }
    }
}

extension LaunchControlInteractor {
    
    func callBackApi() {
        router?.deAttachNetwork()
        subscribeForLaunchEvents()
    }
}
