//
//  RecommendedVideosTableViewCell.swift
//  Pipe
//
//  Created by Daniel Kim on 8/1/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit

class RecommendedVideosTableViewCell: UITableViewCell {

    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.text = "The moments I loved as a teacher"
        authorLabel.text = "Jaeho Park"
        
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.adjustsFontForContentSizeCategory = true
        
        //titleLabel.adjustsFontSizeToFitWidth = true
        //titleLabel.minimumScaleFactor = 0.2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
