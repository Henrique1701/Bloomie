//
//  JourneyTableViewCell.swift
//  Bloomy
//
//  Created by Wilton Ramos on 19/01/21.
//

import UIKit

class JourneyTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var rewardImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
