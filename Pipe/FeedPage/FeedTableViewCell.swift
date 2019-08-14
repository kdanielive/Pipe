//
//  FeedTableViewCell.swift
//  Pipe
//
//  Created by Daniel Kim on 8/12/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    let videoCard = VideoView()

    /*
    var video: Video? = nil {
        didSet {
            updateViews()
        }
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code¸
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func height(for viewModel: Video) -> CGFloat {
        let videoViewHeight: CGFloat = 260
        let padding: CGFloat = 20
        
        return padding + videoViewHeight + 20
    }
}

// Extension for rounding specific corners
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
