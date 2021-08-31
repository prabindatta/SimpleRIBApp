//  Copyright © T-Mobile USA Inc. All rights reserved.

import RIBs

protocol SearchListDependency: Dependency {
    var searchListService: SearchListServiceable { get }
}

final class SearchListComponent: Component<SearchListDependency>, SearchDetailDependency {}

// MARK: - Builder

protocol SearchListBuildable: Buildable {
    func build(withListener listener: SearchListListener) -> SearchListRouting
}

final class SearchListBuilder: Builder<SearchListDependency>, SearchListBuildable {

    override init(dependency: SearchListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchListListener) -> SearchListRouting {
        let component = SearchListComponent(dependency: dependency)
        
        let viewController = SearchListViewController()
        viewController.presentationStyleFullScreeWithoutAnimation()
        
        let interactor = SearchListInteractor(presenter: viewController, searchListService: component.dependency.searchListService)
        interactor.listener = listener
        
        let searchDetailBuilder = SearchDetailBuilder(dependency: component)
        
        return SearchListRouter(interactor: interactor, viewController: viewController, searchDetailBuilder: searchDetailBuilder)
    }
}
