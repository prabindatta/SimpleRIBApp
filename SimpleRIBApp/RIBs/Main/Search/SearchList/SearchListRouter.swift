//  Copyright © T-Mobile USA Inc. All rights reserved.

import RIBs
import SimpleRIBCore

protocol SearchListInteractable: Interactable, SearchDetailListener {
    var router: SearchListRouting? { get set }
    var listener: SearchListListener? { get set }
}

protocol SearchListViewControllable: ViewControllerNavigable {}

final class SearchListRouter: ViewableRouter<SearchListInteractable, SearchListViewControllable>, SearchListRouting {

    init(interactor: SearchListInteractable, viewController: SearchListViewControllable, searchDetailBuilder: SearchDetailBuildable) {
        self.searchDetailBuilder = searchDetailBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: - Private
    
    private let searchDetailBuilder: SearchDetailBuildable
    private var searchDetail: ViewableRouting?
}

extension SearchListRouter {
    func route(to event: Event) {
        let searchDetail = searchDetailBuilder.build(withListener: interactor, event: event)
        self.searchDetail = searchDetail
        
        attachChild(searchDetail)
        
        viewController.push(view: searchDetail.viewControllable)
    }
}
