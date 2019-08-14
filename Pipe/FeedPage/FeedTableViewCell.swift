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
        addSubview(previewImageView)
        addSubview(videoView)
        videoView.addSubview(titleLabel)
    }
    
    func updateViews() {
        titleLabel.text = video?.title
        titleLabel.font = UIFont.systemFont(ofSize: 17.0)
        
        let image = UIImage(named: (video?.thumbURL.path)!)
        previewImageView.image = image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let previewHeight: CGFloat = 200
        let padding: CGFloat = 20
        let videoViewHeight: CGFloat = 260
        
        let widthWithPadding = bounds.width - (2*padding)
        
        previewImageView.bounds = CGRect(x: 0, y: 0, width: widthWithPadding, height: previewHeight)

        let imageYCenter = padding + previewHeight/2.0
        //previewImageView.center = CGPoint(x: bounds.width/2.0, y: imageYCenter)
        previewImageView.center = CGPoint(x: bounds.width/2.0, y: imageYCenter)
        // Rounding the upper left and right corners
        previewImageView.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        previewImageView.alpha = 0.5
        
        let videoViewYCenter = padding + videoViewHeight/2.0
        videoView.bounds = CGRect(x: 0, y: 0, width: widthWithPadding, height: 260)
        videoView.center = CGPoint(x: bounds.width/2.0, y: videoViewYCenter)
        videoView.backgroundColor = UIColor.black
        
        let titleWidth = videoView.bounds.width - 35 - padding*2
        let titleHeight = 40.0
        let titleXCenter = (titleWidth + padding*2)/2.0
        titleLabel.bounds = CGRect(x: 0.0, y: 0.0, width: Double(titleWidth), height: titleHeight)
        titleLabel.center = CGPoint(x: Double(titleXCenter), y: Double(previewHeight) + titleHeight/2.0 + 10)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .left
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.8)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = videoView.bounds
        
        videoView.layer.insertSublayer(gradientLayer, at: 0)
        
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
