//
//  RouteDetailCell.swift
//  TATSDKSample


import UIKit
import TATSDK

class RouteDetailCell: UITableViewCell {
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var transportTypeLabel: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDetailCell(info: TATStop) {
        placeImage.downloaded(from: info.thumbnailUrl, placeholderImage: UIImage.init(named: "no_image"))
        distanceLabel.text = convertDistance(distance: info.distance)
        nameLabel.text = info.name
         transportTypeLabel.text = getTextProperty(key: info.travelBy).textDisplay.isEmpty ? "" : "By \(getTextProperty(key: info.travelBy).textDisplay)"
        transportTypeLabel.textColor = getTextProperty(key: info.travelBy).color
    }
    
    func getTextProperty(key: String) -> (textDisplay: String,color: UIColor) {
        switch key {
        case "C":
            return (textDisplay: "Car",color: UIColor.red)
        case "W":
            return (textDisplay: "Walk",color: UIColor.green)
        case "P":
            return (textDisplay: "Public Transport",color: UIColor.blue)
        default:
            return (textDisplay: "",color: UIColor.purple)
        }
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
