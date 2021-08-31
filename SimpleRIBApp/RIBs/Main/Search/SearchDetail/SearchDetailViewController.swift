//  Copyright © T-Mobile USA Inc. All rights reserved.

import UIKit
import QuartzCore
import RIBs

protocol SearchDetailPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SearchDetailViewController: UIViewController, SearchDetailPresentable, SearchDetailViewControllable {

    weak var listener: SearchDetailPresentableListener?
    private let event: Event
    
    var eventImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    var eventVenueLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    var eventTimeLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    init(event: Event) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.3529411765, blue: 0.9490196078, alpha: 1)
        self.title = event.title
        
        makeEventImageView()
        makeEventVenueLabel()
        makeEventTimeLabel()
    }
    
    func makeEventImageView() {
        
        eventImageView.layer.cornerRadius = CGFloat(20.0)
        eventImageView.layer.masksToBounds = true
        eventImageView.image = UIImage(named: "placeholder")
        view.addSubview(eventImageView)
        eventImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        if let imageLink = event.performers.first?.image {
            eventImageView.sd_setImage(with: URL(string: imageLink), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    func makeEventVenueLabel() {
        
        eventVenueLabel.text = event.venue.displayLocation
        eventVenueLabel.numberOfLines = 0
        eventVenueLabel.textColor = .black
        eventVenueLabel.lineBreakMode = .byTruncatingTail
        eventVenueLabel.textAlignment = .left
        eventVenueLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        view.addSubview(eventVenueLabel)
        eventVenueLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(16)
            make.top.equalTo(eventImageView.snp.bottom).offset(40)
        }
    }
    
    func makeEventTimeLabel() {
        eventTimeLabel.text = event.dateTime
        eventTimeLabel.numberOfLines = 0
        eventTimeLabel.textColor = .black
        eventTimeLabel.lineBreakMode = .byTruncatingTail
        eventTimeLabel.textAlignment = .left
        eventTimeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        view.addSubview(eventTimeLabel)
        eventTimeLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(16)
            make.top.equalTo(eventVenueLabel.snp.bottom).offset(16)
        }
    }
}
