//
//  RouteListCell.swift
//  TATSDKSample


import UIKit
import TATSDK
import SDWebImage

class RouteListCell: UITableViewCell {
    
    @IBOutlet weak var routeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDetailCell(info: TATGetRoutesResult){
        routeImage.sd_setImage(with: URL.init(string: info.thumbnail), placeholderImage: UIImage.init(named: "no_image"))
        nameLabel.text = info.name
        infoLabel.text = info.info
        dayLabel.text = "\(info.numberOfDays!) Day(s) "
        distanceLabel.text = convertDistance(distance: info.distance)
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
