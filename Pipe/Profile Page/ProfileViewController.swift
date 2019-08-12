//
//  ProfileViewController.swift
//  Pipe
//
//  Created by Daniel Kim on 8/1/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit
import GoogleSignIn

class ProfileViewController: UIViewController, GIDSignInUIDelegate {
    
    
    @IBAction func logoutAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FirstPageViewController") as! FirstPageViewController
        self.present(nextViewController, animated:true, completion:nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

