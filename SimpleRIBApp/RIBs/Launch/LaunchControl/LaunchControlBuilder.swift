//  Copyright © T-Mobile USA Inc. All rights reserved.

import RIBs

protocol LaunchControlDependency: Dependency {
    var launchControlViewController: LaunchControlViewControllable { get }
}

final class LaunchControlComponent: Component<LaunchControlDependency> {

    fileprivate var launchControlViewController: LaunchControlViewControllable {
        return dependency.launchControlViewController
    }
    
    override init(dependency: LaunchControlDependency) {
        super.init(dependency: dependency)
    }
}

extension LaunchControlComponent: NoNetworkDependency {}

// MARK: - Builder

protocol LaunchControlBuildable: Buildable {
    func build(withListener listener: LaunchControlListener) -> LaunchControlRouting
}

final class LaunchControlBuilder: Builder<LaunchControlDependency>, LaunchControlBuildable {

    override init(dependency: LaunchControlDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LaunchControlListener) -> LaunchControlRouting {
        let component = LaunchControlComponent(dependency: dependency)
        
        let interactor = LaunchControlInteractor()
        interactor.listener = listener
        
        let noNetworkBuilder = NoNetworkBuilder(dependency: component)
        
        return LaunchControlRouter(interactor: interactor,
                                   viewController: component.launchControlViewController,
                                   noNetworkBuilder: noNetworkBuilder)
    }
}
