//
//  FeedTableViewCell.swift
//  Pipe
//
//  Created by Daniel Kim on 8/12/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    let videoView = UIView()
    let titleLabel = UILabel()
    let previewImageView = UIImageView()
    
    var video: Video? = nil {
        didSet {
            updateViews()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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

extension FeedTableViewCell {
    func addSubviews() {
        videoView.contentMode = .scaleAspectFill
        videoView.clipsToBounds = true
        videoView.layer.cornerRadius = 10.0
        
        //previewImageView.contentMode = .scaleAspectFill
        //previewImageView.clipsToBounds = true
        //previewImageView.layer.cornerRadius = 4.0
        
        //videoView.addSubview(titleLabel)
        //videoView.addSubview(previewImageView)
        addSubview(videoView)
        addSubview(previewImageView)
        

        //addSubview(titleLabel)
        //addSubview(previewImageView)
    }
    
    func updateViews() {
        titleLabel.text = video?.title
        titleLabel.font = UIFont.systemFont(ofSize: 24.0)
        
        let image = UIImage(named: (video?.thumbURL.path)!)
        previewImageView.image = image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let videoHeight: CGFloat = 200
        let padding: CGFloat = 20
        let videoViewHeight: CGFloat = 260
        
        let widthWithPadding = bounds.width - (2*padding)
        
        let titleSize = titleLabel.sizeThatFits(CGSize(width: widthWithPadding, height: .infinity))
        titleLabel.bounds = CGRect(x: 0, y: 0, width: titleSize.width, height: titleSize.height)
    
        //previewImageView.bounds = CGRect(x: 0, y: 0, width: widthWithPadding, height: previewHeight)
        previewImageView.bounds = CGRect(x: 0, y: 0, width: widthWithPadding, height: videoHeight)

        //titleLabel.center = CGPoint(x: titleLabel.bounds.width/2.0 + padding, y: padding + titleLabel.bounds.height/2.0)

        //let imageYCenter = titleLabel.frame.origin.y + titleSize.height + padding + previewHeight/2.0
        let imageYCenter = padding + videoHeight/2.0
        //previewImageView.center = CGPoint(x: bounds.width/2.0, y: imageYCenter)
        previewImageView.center = CGPoint(x: bounds.width/2.0, y: imageYCenter)
        
        previewImageView.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)

        
        let videoViewYCenter = padding + videoViewHeight/2.0
        videoView.bounds = CGRect(x: 0, y: 0, width: widthWithPadding, height: 260)
        videoView.center = CGPoint(x: bounds.width/2.0, y: videoViewYCenter)
        videoView.backgroundColor = UIColor.black
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
