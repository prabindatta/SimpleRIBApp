//
//  ViewController+Presentable.swift
//  
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import UIKit
import RIBs

public protocol ViewControllerPresentable: ViewControllable {
    func present(viewController: ViewControllable, animated: Bool)
    func dismiss(viewController: ViewControllable, animated: Bool)
}

extension ViewControllerPresentable where Self: UIViewController {
    
    public func present(viewController: ViewControllable, animated: Bool) {
        self.present(viewController.uiviewController, animated: animated, completion: nil)
    }
    
    public func dismiss(viewController: ViewControllable, animated: Bool) {
        if presentedViewController === viewController.uiviewController {
            dismiss(animated: animated, completion: nil)
        }
    }
}

public enum ViewControllerMode {
    case presentation
    case navigation
}

extension ViewControllable {
    
    public var showingMode: ViewControllerMode {
        
        guard let navigationController = uiviewController.navigationController else {
            return .presentation
        }
        
        if let controller = navigationController.children.first, controller == uiviewController {
            return .presentation
        } else {
            return .navigation
        }
    }
}

public extension ViewControllable {
    
    @discardableResult
    func presentationStyleFullScreeWithCrossDissolve() -> Self {
        self.uiviewController.modalTransitionStyle = .crossDissolve
        self.uiviewController.modalPresentationStyle = .overFullScreen
        return self
    }
    
    @discardableResult
    func presentationStyleFullScreenWithAnimation() -> Self {
        self.uiviewController.modalTransitionStyle = .coverVertical
        self.uiviewController.modalPresentationStyle = .overFullScreen
        return self
    }
    
    @discardableResult
    func presentationStyleFullScreeWithoutAnimation() -> Self {
        self.uiviewController.modalTransitionStyle = .crossDissolve
        self.uiviewController.modalPresentationStyle = .fullScreen
        return self
    }
    
    @discardableResult
    func presentationStyleDefault() -> Self {
        self.uiviewController.modalPresentationStyle = .automatic
        return self
    }
}
