//  Copyright © T-Mobile USA Inc. All rights reserved.

import RIBs

protocol MainControlRouting: Routing {
    func cleanupViews()
    func attachSearchList()
}

protocol MainControlListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MainControlInteractor: Interactor, MainControlInteractable {

    weak var router: MainControlRouting?
    weak var listener: MainControlListener?

    override init() {}

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
    }
}
