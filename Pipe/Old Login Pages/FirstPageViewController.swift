//
//  FirstPageViewController.swift
//  Pipe
//
//  Created by Daniel Kim on 8/6/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit
import GoogleSignIn

class FirstPageViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet var googleSignUpButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: NSNotification.Name("SuccessfulSignInNotification"), object: nil)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        let imageName = "GoogleSignUp"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: 162, height: 50)
        self.googleSignUpButton.addSubview(imageView)
        self.googleSignUpButton.bringSubview(toFront: imageView)

        // Do any additional setup after loading the view.
    }
    
    @objc func didSignIn() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        self.present(nextViewController, animated:false, completion:nil)
        
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
