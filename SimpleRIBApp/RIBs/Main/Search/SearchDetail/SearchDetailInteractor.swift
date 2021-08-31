//  Copyright © T-Mobile USA Inc. All rights reserved.

import RIBs

protocol SearchDetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchDetailPresentable: Presentable {
    var listener: SearchDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchDetailListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchDetailInteractor: PresentableInteractor<SearchDetailPresentable>, SearchDetailInteractable, SearchDetailPresentableListener {

    weak var router: SearchDetailRouting?
    weak var listener: SearchDetailListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SearchDetailPresentable) {
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
}
