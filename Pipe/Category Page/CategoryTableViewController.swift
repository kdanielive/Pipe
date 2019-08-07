//
//  CategoryTableViewController.swift
//  Pipe
//
//  Created by Daniel Kim on 8/6/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    let lessons = ["hihihi", "hellohello", "olaola"]
    var filteredLessons = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search videos"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController?.isActive = false
                
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil. ?? overwrites the nil value
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredLessons = lessons.filter({( lesson : String) -> Bool in
            return lesson.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0) {
            return 1
        } else {
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "horizontalCategoryCell", for: indexPath) as! HorizontalCategoryTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "horizontalCategoryCell2", for: indexPath) as! HorizontalCategoryTableViewCell2
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Topics to learn"
        } else if section == 1 {
            return "살면서 들어보지 못한 흥미로운 주제들"
        } else {
            return "LIPE 디자이너의 픽!"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0) {
            return 160
        } else {
            return 85
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section == 0) {
            return 59
        } else{
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0) {
            return 52
        } else {
            return 23
        }
    }
    
    @IBAction func openSearchBar(_ sender: Any) {
        navigationItem.searchController?.isActive = true
    }
    
}

extension CategoryTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
