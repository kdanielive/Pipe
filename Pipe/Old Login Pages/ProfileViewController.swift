//
//  ProfileViewController.swift
//  Pipe
//
//  Created by Daniel Kim on 8/1/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit
import GoogleSignIn

class ProfileViewController: UIViewController, GIDSignInUIDelegate, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBAction func logoutAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FirstPageViewController") as! FirstPageViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func openSearchBar(_ sender: Any) {
        navigationItem.searchController = searchController
        searchController.isActive = true

    }

    func addSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search videos"
        navigationItem.searchController = nil
        definesPresentationContext = true
        
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.searchController = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self

        addSearchBar()
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

extension ProfileViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        //filterContentForSearchText(searchController.searchBar.text!)
    }
}

