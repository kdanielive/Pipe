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

    @IBOutlet var labels: [UILabel]!
    let mockLabelTitles = ["helloooooooo", "slkdjflsk;fhi", "holoholo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutCategoryLabels(labelTitles: mockLabelTitles)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    func layoutCategoryLabels(labelTitles: [String]) {
        for label in labels {
            label.sizeToFit()
        }
        
        // Setting label text
        labels[1].text = mockLabelTitles[0]
        labels[2].text = mockLabelTitles[1]
        labels[3].text = mockLabelTitles[2]
        
        // Hiding labels without text from view
        for label in labels{
            if label.text == "Label" {
                label.isHidden = true
            }
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
