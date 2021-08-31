//  Copyright © T-Mobile USA Inc. All rights reserved.

import RIBs
import SimpleRIBNetworking

protocol NoNetworkRouting: ViewableRouting {}

protocol NoNetworkPresentable: Presentable {
    var listener: NoNetworkPresentableListener? { get set }
}

protocol NoNetworkListener: AnyObject {
    func callBackApi()
}

final class NoNetworkInteractor: PresentableInteractor<NoNetworkPresentable>, NoNetworkInteractable {

    weak var router: NoNetworkRouting?
    weak var listener: NoNetworkListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: NoNetworkPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
}

extension NoNetworkInteractor: NoNetworkPresentableListener {
    func callApi() {
        if InternetStatusListener.shared.currentStatus == .reachable {
            listener?.callBackApi()
        }
    }
}
