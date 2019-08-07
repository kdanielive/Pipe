//
//  EmailSignUpViewController.swift
//  Pipe
//
//  Created by Daniel Kim on 8/7/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit

class EmailSignUpViewController: UIViewController {
    
    @IBOutlet var labels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for label in labels {
            label.font = UIFont(name: "SFProText-Regular", size: 13)
            label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
            label.adjustsFontSizeToFitWidth = true
        }
        
        labels[0].text = "Full Name"
        labels[1].text = "Email Address"
        labels[2].text = "Password (8+ letters)"

        // Do any additional setup after loading the view.
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
