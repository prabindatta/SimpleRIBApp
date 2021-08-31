//  Copyright © T-Mobile USA Inc. All rights reserved.

import RIBs

protocol NoNetworkInteractable: Interactable {
    var router: NoNetworkRouting? { get set }
    var listener: NoNetworkListener? { get set }
}

protocol NoNetworkViewControllable: ViewControllable {}

final class NoNetworkRouter: ViewableRouter<NoNetworkInteractable, NoNetworkViewControllable>, NoNetworkRouting {

    override init(interactor: NoNetworkInteractable, viewController: NoNetworkViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
