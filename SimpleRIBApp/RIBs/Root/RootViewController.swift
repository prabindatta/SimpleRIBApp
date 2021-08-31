//  Copyright © T-Mobile USA Inc. All rights reserved.

import UIKit
import RIBs
import SnapKit

protocol RootPresentableListener: AnyObject {}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable, LaunchControlViewControllable, MainControlViewControllable {

    weak var listener: RootPresentableListener?
    
    var busyIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.3529411765, blue: 0.9490196078, alpha: 1)
        
        makeActivityIndicator()
    }
    
    func makeActivityIndicator() {
        view.addSubview(busyIndicator)
        busyIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension RootViewController {
    
    func showBusyIndicator() {
        busyIndicator.startAnimating()
    }
    
    func hideBusyIndicator() {
        busyIndicator.stopAnimating()
    }
}
