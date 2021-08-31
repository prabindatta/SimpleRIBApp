//  Copyright © T-Mobile USA Inc. All rights reserved.

import RIBs

protocol NoNetworkDependency: Dependency {}

final class NoNetworkComponent: Component<NoNetworkDependency> {}

// MARK: - Builder

protocol NoNetworkBuildable: Buildable {
    func build(withListener listener: NoNetworkListener) -> NoNetworkRouting
}

final class NoNetworkBuilder: Builder<NoNetworkDependency>, NoNetworkBuildable {

    override init(dependency: NoNetworkDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: NoNetworkListener) -> NoNetworkRouting {
        _ = NoNetworkComponent(dependency: dependency)
        
        let viewController = NoNetworkViewController()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
        
        let interactor = NoNetworkInteractor(presenter: viewController)
        interactor.listener = listener
        
        return NoNetworkRouter(interactor: interactor, viewController: viewController)
    }
}
