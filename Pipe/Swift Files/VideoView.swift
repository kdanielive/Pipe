//
//  VideoView.swift
//  Pipe
//
//  Created by Daniel Kim on 8/14/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit

class VideoView: UIView {
    
    let accessoryView = UIView()
    let titleLabel = UILabel()
    let previewImageView = UIImageView()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //common func to init our view
    private func setupView() {
        let padding = 20.0
        let accessoryPadding = 10.0
        
        previewImageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height*(3/4))
        accessoryView.frame = CGRect(x: 0, y: self.frame.height*(3/4), width: self.frame.width, height: self.frame.height/4.0)
        
        previewImageView.image = UIImage(named: "newYorkFlip.png")
        accessoryView.backgroundColor = UIColor.black

        let titleLabelXCenter = (Double(accessoryView.frame.width) - accessoryPadding*2)/2.0 + accessoryPadding
        let titleLabelWidth = Double(accessoryView.frame.width) - accessoryPadding*2
        let titleLabelHeight = Double(accessoryView.frame.height*(2/3))
        
        titleLabel.bounds = CGRect(x: 0.0, y: 0.0, width: Double(titleLabelWidth), height: titleLabelHeight)
        titleLabel.text = "HIhihihihihihihihihihihi"
        titleLabel.font = UIFont(name: "SFProText-Semibold", size: 17)
        titleLabel.textColor = UIColor.white
        titleLabel.sizeThatFits(CGSize(width: titleLabelWidth, height: titleLabelHeight))
        titleLabel.numberOfLines = 2
        //titleLabel.preferredMaxLayoutWidth = CGFloat(titleLabelWidth)
        titleLabel.center = CGPoint(x: titleLabelXCenter, y: Double(titleLabel.frame.height/2.0))
        titleLabel.textAlignment = .left
        
        // Debugging purposes
        /*titleLabel.layer.borderWidth = 1.0
        titleLabel.layer.borderColor = UIColor.white.cgColor
        accessoryView.layer.borderWidth = 1.0
        accessoryView.layer.borderColor = UIColor.white.cgColor*/
                
        addSubview(previewImageView)
        addSubview(accessoryView)
        accessoryView.addSubview(titleLabel)
        
        self.roundCorners(corners: UIRectCorner.allCorners, radius: 12.0)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = previewImageView.bounds
        previewImageView.layer.insertSublayer(gradientLayer, at: 0)
    }
    


}
