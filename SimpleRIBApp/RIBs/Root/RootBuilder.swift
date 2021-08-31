//  Copyright © T-Mobile USA Inc. All rights reserved.

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    let rootViewController: RootViewController
    
    init(dependency: RootDependency, rootViewController: RootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

extension RootComponent: LaunchControlDependency {
    
    var launchControlViewController: LaunchControlViewControllable {
        self.rootViewController
    }
}

extension RootComponent: MainControlDependency {
    var mainControlViewController: MainControlViewControllable {
        self.rootViewController
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let viewController = RootViewController()
        let component = RootComponent(dependency: dependency, rootViewController: viewController)
        let interactor = RootInteractor(presenter: viewController)
        
        let launchControlBuilder = LaunchControlBuilder(dependency: component)
        let mainControlBuilder = MainControlBuilder(dependency: component)

        return RootRouter(interactor: interactor,
                          viewController: viewController,
                          launchControlBuilder: launchControlBuilder,
                          mainControlBuilder: mainControlBuilder)
    }
}
