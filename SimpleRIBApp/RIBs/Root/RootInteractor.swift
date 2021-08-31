//  Copyright © T-Mobile USA Inc. All rights reserved.

import RIBs

protocol RootRouting: ViewableRouting {
    func routeToMainControl()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    func showBusyIndicator()
    func hideBusyIndicator()
}

protocol RootListener: AnyObject {}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    weak var router: RootRouting?
    weak var listener: RootListener?

    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
}

extension RootInteractor {
    
    func launchSequenceStarted() {
        presenter.showBusyIndicator()
    }
    
    func launchSequenceCompleted() {
        presenter.hideBusyIndicator()
        router?.routeToMainControl()
    }
}
