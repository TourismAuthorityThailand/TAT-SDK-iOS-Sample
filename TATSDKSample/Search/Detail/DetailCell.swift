//
//  DetailCell.swift
//  TATSDKSample
//


import UIKit

class DetailCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setDetail(title: String, detail: String) {
        titleLabel.text = title
        detailLabel.text = detail
    }
}
