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
     
     func setDetail(info: TATPlace?){
          thumbmail.downloaded(from: info?.thumbnailUrl, placeholderImage: UIImage.init(named: "no_image"))
          nameLabel.text = info?.name
          addressLabel.text = "\(setTextAddress(location: info?.location))"
          categoryLabel.text = "\(info?.category?.description ?? "-")"
          distanceLabel.text = "\(convertDistance(distance: info?.distance ?? 0))"
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
     
     func setTextAddress(location : TATLocation?) -> String{
          var text = ""
          guard let location = location else { return "-" }
          if !location.address.isEmpty {
               text = "\(location.address) "
          }
          
          if !location.subDistrict.isEmpty {
               text += "\(location.subDistrict) "
          }
          
          if !location.district.isEmpty {
               text += "\(location.district) "
          }
          
          if !location.province.isEmpty {
               text += "\(location.province) "
          }
          
          if !location.postcode.isEmpty {
               text += "\(location.postcode) "
          }
          
          return text
     }
     
}

