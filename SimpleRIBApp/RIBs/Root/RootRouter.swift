//  Copyright © T-Mobile USA Inc. All rights reserved.

import RIBs

protocol RootInteractable: Interactable, LaunchControlListener, MainControlListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    init(interactor: RootInteractable,
                  viewController: RootViewControllable,
                  launchControlBuilder: LaunchControlBuildable,
                  mainControlBuilder: MainControlBuildable) {
        self.launchControlBuilder = launchControlBuilder
        self.mainControlBuilder = mainControlBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        attachLaunchControl()
    }
    
    // MARK: - Private
    
    private let launchControlBuilder: LaunchControlBuildable
    private let mainControlBuilder: MainControlBuildable
    
    private var launchControl: Routing?
    private var mainControl: Routing?
}

extension RootRouter {
    
    func detachCurrentChild() {
        
        children.forEach { detachChild($0) }
        
        self.launchControl = nil
        self.mainControl = nil
    }
    
    func attachLaunchControl() {
        let launchControl = launchControlBuilder.build(withListener: interactor)
        self.launchControl = launchControl
        attachChild(launchControl)
    }
    
    func attachMainControl() {
        let mainControl = mainControlBuilder.build(withListener: interactor)
        self.mainControl = mainControl
        attachChild(mainControl)
    }
    
    func routeToMainControl() {
        detachCurrentChild()
        attachMainControl()
    }
}
