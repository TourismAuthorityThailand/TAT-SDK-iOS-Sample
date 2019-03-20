//
//  HeaderCell.swift
//  TATSDKSample


import UIKit

class HeaderCell: UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var viewOnMapButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewOnMapButton.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDetailCell(day: Int, index: Int){
        dayLabel.text = "Day \(day)"
        viewOnMapButton.tag = index
    }

}
