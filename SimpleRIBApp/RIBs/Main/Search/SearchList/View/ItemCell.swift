//
//  ItemCell.swift
//  SimpleRIBApp
//
//  Created by Prabin Kumar Datta on 30/08/21.
//

import Foundation
import SDWebImage
import UIKit

final class ItemCell: UITableViewCell {
    
    @IBOutlet private weak var eventImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var venueLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var likeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func display(event: Event) {
        if let imageLink = event.performers.first?.image {
            eventImageView.sd_setImage(with: URL(string: imageLink), placeholderImage: UIImage(named: "placeholder"))
        } else {
            eventImageView.image = UIImage(named: "placeholder")
        }
        titleLabel.text = event.title
        venueLabel.text = event.venue.displayLocation
        timeLabel.text = event.dateTime
//        likeImageView.image =
    }
}
