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

    func setDetail(title: String?, detail: String?, isHTMLDetail : Bool) {
        titleLabel.text = title
//
        guard isHTMLDetail else {
            detailLabel.text = detail
            return
        }
        guard let data = detail?.data(using: String.Encoding.unicode) else { return }
        
        try? detailLabel.attributedText =
            NSAttributedString(data: data,
                               options: [.documentType:NSAttributedString.DocumentType.html],
                               documentAttributes: nil)
    }
}
