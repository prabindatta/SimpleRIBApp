//  Copyright © T-Mobile USA Inc. All rights reserved.

import RIBs
import SimpleRIBCore
import UIKit

protocol MainControlInteractable: Interactable, SearchListListener {
    var router: MainControlRouting? { get set }
    var listener: MainControlListener? { get set }
}

protocol MainControlViewControllable: ViewControllerPresentable {}

final class MainControlRouter: Router<MainControlInteractable> {
    
    init(interactor: MainControlInteractable, viewController: MainControlViewControllable, searchListBuilder: SearchListBuildable) {
        self.viewController = viewController
        self.searchListBuilder = searchListBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        attachSearchList()
    }

    // MARK: - Private

    private let viewController: MainControlViewControllable
    private let searchListBuilder: SearchListBuildable
    private var searchList: ViewableRouting?
    private weak var navController: ViewControllable?
}

extension MainControlRouter: MainControlRouting {
    
    func cleanupViews() {
        detatchCurrentChild()
    }
    
    func detatchCurrentChild() {
        if let searchList = self.searchList {
            detachChild(searchList)
            self.searchList = nil
        }
    }
    
    func attachSearchList() {
        let searchList = searchListBuilder.build(withListener: interactor)
        self.searchList = searchList
        
        attachChild(searchList)
        
        let navController = UINavigationController(root: searchList.viewControllable)
        navController.presentationStyleFullScreeWithCrossDissolve()
        self.navController = navController
        viewController.present(viewController: navController, animated: true)
    }
}
