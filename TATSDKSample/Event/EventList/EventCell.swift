//
//  EventCell.swift
//  TATSDKSample


import UIKit
import SDWebImage
import TATSDK

class EventCell: UITableViewCell {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDetailCell(info: TATGetEventsResult){
        eventImage.sd_setImage(with: URL(string: info.thumbnail), placeholderImage: UIImage.init(named: "no_image"), completed: nil)
        titleLabel.text = info.name
        distanceLabel.text = convertDistance(distance: info.distance)
        dateLabel.text = info.eventTime
    }

    func convertDistance(distance: Double) -> String {
        var textDisplay = ""
        guard distance != 0.0 else { return "" }
        if(distance >= 1000) {
            let temp = Double(String(format: "%.1f", (distance/1000)))
            textDisplay = String(format: "%g km.", temp!)
        } else {
            textDisplay = String(format: "%.0f m.", distance)
        }
        return textDisplay
    }
}