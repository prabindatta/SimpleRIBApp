//  Copyright © T-Mobile USA Inc. All rights reserved.

import RIBs
import SimpleRIBCore

protocol LaunchControlInteractable: Interactable, NoNetworkListener {
    var router: LaunchControlRouting? { get set }
    var listener: LaunchControlListener? { get set }
}

protocol LaunchControlViewControllable: ViewControllerPresentable {}

final class LaunchControlRouter: Router<LaunchControlInteractable> {

    // MARK: - Private
    
    private let viewController: LaunchControlViewControllable
    private let noNetworkBuilder: NoNetworkBuildable
    private var noNetwork: ViewableRouting?
    
    init(interactor: LaunchControlInteractable,
         viewController: LaunchControlViewControllable,
         noNetworkBuilder: NoNetworkBuildable) {
        self.viewController = viewController
        self.noNetworkBuilder = noNetworkBuilder
        
        super.init(interactor: interactor)
        interactor.router = self
    }
}

extension LaunchControlRouter: LaunchControlRouting {
    
    func deAttachNetwork() {
        detachCurrentChild()
    }
    
    func detachCurrentChild() {
        if let noNetwork = noNetwork {
            detachChild(noNetwork)
            self.viewController.dismiss(viewController: noNetwork.viewControllable, animated: false)
            self.noNetwork = nil
        }
    }
 
    func attachNoNetwork() {
        
        let noNetwork = noNetworkBuilder.build(withListener: interactor)
        self.noNetwork = noNetwork
        
        attachChild(noNetwork)
        self.viewController.present(viewController: noNetwork.viewControllable, animated: false)
    }
}
