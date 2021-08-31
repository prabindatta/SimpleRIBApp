//  Copyright © T-Mobile USA Inc. All rights reserved.

import RIBs

protocol MainControlDependency: Dependency {
    var mainControlViewController: MainControlViewControllable { get }
}

final class MainControlComponent: Component<MainControlDependency>, SearchListDependency {
    var searchListService: SearchListServiceable {
        SearchListService()
    }
    
    fileprivate var mainControlViewController: MainControlViewControllable {
        return dependency.mainControlViewController
    }
    
    let networkingInitializer: NetworkingInitializer
    init(dependency: MainControlDependency, networkingInitializer: NetworkingInitializer) {
        self.networkingInitializer = networkingInitializer
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol MainControlBuildable: Buildable {
    func build(withListener listener: MainControlListener) -> MainControlRouting
}

final class MainControlBuilder: Builder<MainControlDependency>, MainControlBuildable {

    override init(dependency: MainControlDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MainControlListener) -> MainControlRouting {
        let component = MainControlComponent(dependency: dependency, networkingInitializer: NetworkingInitializer())
        component.networkingInitializer.initialize()
        
        let interactor = MainControlInteractor()
        interactor.listener = listener
        
        let searchListBuilder = SearchListBuilder(dependency: component)
        
        return MainControlRouter(interactor: interactor,
                                 viewController: component.mainControlViewController,
                                 searchListBuilder: searchListBuilder)
    }
}
