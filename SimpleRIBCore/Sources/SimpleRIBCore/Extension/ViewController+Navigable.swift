//
//  ViewController+Navigable.swift
//  
//
//  Created by Prabin Kumar Datta on 30/08/21.
//

import UIKit
import RIBs

public protocol ViewControllerNavigable: ViewControllable {
    func push(view: ViewControllable)
    func pop()
}

extension ViewControllerNavigable where Self: UIViewController {
    
    public func push(view: ViewControllable) {
        navigationController?.pushViewController(view.uiviewController, animated: true)
    }
    
    public func pop() {
        navigationController?.popViewController(animated: true)
    }
}

extension UINavigationController: ViewControllable {
    public var uiviewController: UIViewController { return self }

    public convenience init(root: ViewControllable) {
        self.init(rootViewController: root.uiviewController)
    }
}

