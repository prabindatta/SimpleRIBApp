//  Copyright © T-Mobile USA Inc. All rights reserved.

import RIBs
import SimpleRIBNetworking
import Combine

protocol SearchListRouting: ViewableRouting {
    func route(to event: Event)
}

protocol SearchListPresentable: Presentable {
    var listener: SearchListPresentableListener? { get set }
    func showSearchResult(_ events: [Event])
}

protocol SearchListListener: AnyObject {}

final class SearchListInteractor: PresentableInteractor<SearchListPresentable>, SearchListInteractable, SearchListPresentableListener {

    weak var router: SearchListRouting?
    weak var listener: SearchListListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: SearchListPresentable, searchListService: SearchListServiceable) {
        self.searchListService = searchListService
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: private
    
    private let searchListService: SearchListServiceable
    private var subscriptions = Set<AnyCancellable>()
}

extension SearchListInteractor {
    
    func searchEvents(with query: String) {
        searchListService.execute(for: query)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.handleError(error)
                }
            }, receiveValue: { [weak self] searchListModel in
                self?.presenter.showSearchResult(searchListModel.events)
            })
            .store(in: &subscriptions)
    }
    
    func didSelectItem(_ event: Event) {
        router?.route(to: event)
    }
}

extension SearchListInteractor {
    
    func handleError(_ error: NetworkingError) {
        print("error \(error)")
    }
    
}
