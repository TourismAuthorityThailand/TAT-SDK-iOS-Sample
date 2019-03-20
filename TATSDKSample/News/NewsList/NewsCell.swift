//
//  NewsCell.swift
//  TATSDKSample

import UIKit
import SDWebImage
import TATSDK

class NewsCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDetailCell(info: TATGetNewsResult){
        newsImage.sd_setImage(with: URL(string: info.thumbnail), placeholderImage: UIImage.init(named: "no_image"), completed: nil)
        titleLabel.text = info.name
        introLabel.text = info.introduction
        dateLabel.text = info.publishDate
    }

}
