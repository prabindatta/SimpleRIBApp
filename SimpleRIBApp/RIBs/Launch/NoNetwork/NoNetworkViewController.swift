//  Copyright © T-Mobile USA Inc. All rights reserved.

import UIKit
import RIBs

protocol NoNetworkPresentableListener: AnyObject {
    func callApi()
}

final class NoNetworkViewController: UIViewController, NoNetworkPresentable, NoNetworkViewControllable {

    weak var listener: NoNetworkPresentableListener?
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    var detailLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    var tryAgain: UIButton = {
        let tryAgain = UIButton()
        tryAgain.setTitle("Try Again", for: .normal)
        return tryAgain
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.alpha = 1
        makeImageView()
        maketitleLabel()
        makeDetailLabel()
        makeTryAgainButton()
    }
        
    func makeImageView() {

        imageView.image = UIImage(named: "no-signal")
        let width = self.view.frame.width / 3
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
            make.height.equalTo(width)
        }
    }
    
    func maketitleLabel() {
        
        titleLabel.text = "Having trouble \n connecting?"
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(70)
        }
    }
    
    func makeDetailLabel() {
        
        detailLabel.text = "We've all been there. Check your network \n or Wi-Fi connection and refresh"
        detailLabel.font = UIFont.preferredFont(forTextStyle: .body)
        detailLabel.numberOfLines = 0
        detailLabel.textColor = .black
        detailLabel.textAlignment = .center
        detailLabel.lineBreakMode = .byTruncatingTail
        view.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
    }
    
    func makeTryAgainButton() {
        tryAgain.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.buttonFontSize)
        tryAgain.backgroundColor = #colorLiteral(red: 0.8862745098, green: 0, blue: 0.4549019608, alpha: 1)
        tryAgain.setTitleColor(.white, for: .normal)
        tryAgain.sizeToFit()
        tryAgain.contentEdgeInsets = UIEdgeInsets(top: 15,left: 60,bottom: 15,right: 60)
        tryAgain.addTarget(self, action: #selector(reTryAPICall), for: .touchUpInside)
        
        view.addSubview(tryAgain)
        tryAgain.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    @objc
    func reTryAPICall() {
        listener?.callApi()
    }
}
