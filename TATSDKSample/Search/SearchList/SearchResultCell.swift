//
//  DetailCell.swift
//  TATSDKSample
//

import UIKit
import TATSDK

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var thumbmail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     
     func setDetail(info: TATPlace){
          thumbmail.downloaded(from: info.thumbnailUrl, placeholderImage: UIImage.init(named: "no_image"))
          nameLabel.text = info.name
          addressLabel.text = "\(setTextAddress(location: info.location))"
          categoryLabel.text = "\(info.category.description ?? "-")"
          distanceLabel.text = "\(convertDistance(distance: info.distance))"
          self.layoutIfNeeded()
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
    
    func setTextAddress(location : TATLocation) -> String{
        var text = ""
        if let address = location.address , !address.isEmpty {
            text = "\(address) "
        }
        
        if let subDistrict = location.subDistrict , !subDistrict.isEmpty {
            text += "\(subDistrict) "
        }
        
        if let district = location.district , !district.isEmpty {
            text += "\(district) "
        }
        
        if let province = location.province , !province.isEmpty {
            text += "\(province) "
        }
        
        if let postcode = location.postcode , !postcode.isEmpty {
            text += "\(postcode) "
        }
        
        return text
    }

}

