//
//  ChannelViewController.swift
//  Pipe
//
//  Created by Daniel Kim on 8/14/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var uploadButton: UIButton!
    @IBOutlet var labels: [UILabel]!
    let mockLabelTitles = ["helloooooooo", "slkdjflsk;fhi", "holoholo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutCategoryLabels(labelTitles: mockLabelTitles)
        configureUploadButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    func configureUploadButton() {
        uploadButton.layer.borderWidth = 1.0
        uploadButton.layer.borderColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0).cgColor
        uploadButton.layer.cornerRadius = 11
        uploadButton.setTitle("      Upload      ", for: .normal)
        uploadButton.setTitleColor(UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0), for: .normal)
    }
    
    func layoutCategoryLabels(labelTitles: [String]) {
        for label in labels {
            label.sizeToFit()
        }
        
        // Setting label text
        labels[1].text = " " + mockLabelTitles[0] + " "
        labels[2].text = " " + mockLabelTitles[1] + " "
        labels[3].text = " " + mockLabelTitles[2] + " "
        
        // Hiding labels without text from view
        for label in labels{
            if label.text == "Label" {
                label.isHidden = true
            }
        }
        
        //Setting Label design
        for label in labels {
            //label.backgroundColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1)
            //label.textColor = UIColor.white
            //label.roundCorners(corners: UIRectCorner.allCorners, radius: 11)
            label.layer.backgroundColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1).cgColor
            label.layer.cornerRadius = 11
            label.textColor = UIColor.white
        }
    }

    /*
    // MARK: - Navigation
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
