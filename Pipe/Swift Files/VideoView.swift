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
    let creatorLabel = UILabel()
    let timeLabel = UILabel()

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
        let parentWidth = self.frame.width
        let parentHeight = self.frame.height
        
        let padding = 20.0
        let accessoryPadding = 10.0
        
        let previewImageViewHeight = parentHeight * (189/298)
        let previewImageViewWidth = parentWidth
        let accessoryViewHeight = parentHeight * (109/298)
        let accessoryViewWidth = parentWidth
        // Setting Macro views
        previewImageView.frame = CGRect(x: 0, y: 0, width: previewImageViewWidth, height: previewImageViewHeight)
        accessoryView.frame = CGRect(x: 0, y: previewImageViewHeight, width: accessoryViewWidth, height: accessoryViewHeight)
        previewImageView.image = UIImage(named: "newYorkFlip.png")
        accessoryView.backgroundColor = UIColor.white

        // Setting title Label
        let titleLabelXCenter = (Double(accessoryView.frame.width) - accessoryPadding*2)/2.0 + accessoryPadding
        let titleLabelWidth = Double(accessoryView.frame.width) - accessoryPadding*2
        let titleLabelHeight = Double(accessoryView.frame.height*(2/3))
        titleLabel.bounds = CGRect(x: 0.0, y: 0.0, width: Double(titleLabelWidth), height: titleLabelHeight)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.text = "HIhihihihihihihialkfj;klsadfjds;fjdsklfj;kdjslfka;sdfkjshihihihi"
        titleLabel.textColor = UIColor.black
        titleLabel.sizeThatFits(CGSize(width: titleLabelWidth, height: titleLabelHeight))
        titleLabel.numberOfLines = 2
        //titleLabel.preferredMaxLayoutWidth = CGFloat(titleLabelWidth)
        titleLabel.center = CGPoint(x: titleLabelXCenter, y: Double(titleLabel.frame.height/2.0))
        titleLabel.textAlignment = .left
        
        // Setting creator label
        let creatorLabelWidth = Double(accessoryView.frame.width) - accessoryPadding - 50
        let creatorLabelHeight = Double(accessoryView.frame.height*(1/4))
        creatorLabel.font = UIFont.systemFont(ofSize: 14)
        creatorLabel.text = "Muahmmad aliali ahalilasldkfj;aklfdklaflkjfa;lsdkfdsafjkli"
        creatorLabel.textColor = UIColor.gray
        creatorLabel.frame = CGRect(x: accessoryPadding, y: titleLabelHeight, width: creatorLabelWidth, height: creatorLabelHeight)
        
        // Setting time label
        let timeLabelWidth = 50.0
        let timeLabelHeight = 22.0
        let timeLabelPadding = 5.0
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.text = "12:18"
        timeLabel.textAlignment = .center
        timeLabel.textColor = UIColor.white
        timeLabel.frame = CGRect(x: Double(previewImageView.frame.width) - timeLabelWidth - timeLabelPadding, y: Double(previewImageView.frame.height) - timeLabelHeight - timeLabelPadding, width: timeLabelWidth, height: timeLabelHeight)
        timeLabel.backgroundColor = UIColor.black
        // Debugging purposes
        /*
        titleLabel.layer.borderWidth = 1.0
        titleLabel.layer.borderColor = UIColor.white.cgColor
        accessoryView.layer.borderWidth = 1.0
        accessoryView.layer.borderColor = UIColor.white.cgColor
         */
        
        addSubview(previewImageView)
        addSubview(accessoryView)
        accessoryView.addSubview(titleLabel)
        accessoryView.addSubview(creatorLabel)
        previewImageView.addSubview(timeLabel)
        
        // Adding a shadow
        self.previewImageView.roundCorners(corners: [UIRectCorner.topLeft, UIRectCorner.topRight], radius: 5)
        self.accessoryView.roundCorners(corners: [UIRectCorner.bottomLeft, UIRectCorner.bottomRight], radius: 5)

        let shadowView = UIView()
        shadowView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        shadowView.clipsToBounds = false
        shadowView.layer.backgroundColor = UIColor.clear.cgColor
        shadowView.backgroundColor = UIColor.clear
        
        let shadowSize: Double = 5
        
        shadowView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: -shadowSize/2, y: -shadowSize/2, width: Double(self.frame.size.width)+shadowSize, height: Double(self.frame.height)+shadowSize), cornerRadius: 5.0).cgPath
        shadowView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.11).cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowRadius = 4
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.bounds = self.bounds
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(shadowView)
        self.sendSubview(toBack: shadowView)

        /*
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.11).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.backgroundColor = UIColor.clear
        self.layer.addShadow()
        */
        
        
        /*
        // Adding a gradient to the layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = previewImageView.bounds
        previewImageView.layer.insertSublayer(gradientLayer, at: 0)
         */
        
        
        // Adding segue gesture recognizer
        //let gesture = UITapGestureRecognizer(target: self, action: #selector(segueTransport))
        //self.addGestureRecognizer(gesture)
    }
}

extension CALayer {
    func addShadow() {
        self.shadowOffset = .zero
        self.shadowOpacity = 1
        self.shadowRadius = 12
        self.shadowColor = UIColor.black.cgColor
        self.masksToBounds = false
        if cornerRadius != 0 {
            addShadowWithRoundedCorners()
        }
    }
    func roundCorners(radius: CGFloat) {
        self.cornerRadius = radius
        if shadowOpacity != 0 {
            addShadowWithRoundedCorners()
        }
    }
    private func addShadowWithRoundedCorners() {
        if let contents = self.contents {
            masksToBounds = false
            sublayers?.filter{ $0.frame.equalTo(self.bounds) }
                .forEach{ $0.roundCorners(radius: self.cornerRadius) }
            self.contents = nil
            if let sublayer = sublayers?.first,
                sublayer.name == "hi" {
                
                sublayer.removeFromSuperlayer()
            }
            let contentLayer = CALayer()
            contentLayer.name = "hi"
            contentLayer.contents = contents
            contentLayer.frame = bounds
            contentLayer.cornerRadius = cornerRadius
            contentLayer.masksToBounds = true
            insertSublayer(contentLayer, at: 0)
        }
    }
}

/*
extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

}
*/


