//
//  CategoryTableViewController.swift
//  Pipe
//
//  Created by Daniel Kim on 8/6/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let lessons = ["hihihi", "hellohello", "olaola"]
    var recentSearches = ["hihi", "yolo", "recent search"]
    
    var filteredLessons = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search videos"
        navigationItem.searchController = nil
        definesPresentationContext = true
        
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        
        //searchController.searchBar.scopeButtonTitles = ["Hello", "Hi"]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.searchController = nil
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
    
    func isSearching() -> Bool {
        return searchController.isActive && searchBarIsEmpty()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    @objc func deleteRecentSearch(sender: UIButton) {
        recentSearches.remove(at: sender.tag)
        tableView.reloadData()
    }
    
    func returnDeleteButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "deleteRecentSearchIcon"), for: .normal)
        button.addTarget(self, action: #selector(deleteRecentSearch), for: .touchUpInside)
        
        return button
    }
    
    /*
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    */

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if(isSearching()) {
            return 1
        } else if(isFiltering()) {
            return 1
        } else {
            return 3
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(isSearching()){
            return recentSearches.count
        } else if(isFiltering()) {
            return filteredLessons.count
        } else {
            if(section == 0) {
                return 1
            } else {
                return 1
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(isSearching()) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchingCell", for: indexPath) as! SearchingTableViewCell
            
            // Setting deleteRecentSearchButton
            let button = returnDeleteButton()
            button.tag = indexPath.row
            cell.accessoryView = button
            button.sizeToFit()
            
            // Setting the recentSearchList
            let searchLabel = cell.searchLabel!
            let searchLabelX = cell.frame.width * (27/375)
            let searchLabelY = cell.frame.height * (15/48)
            let searchLabelHeight = cell.frame.height * (18/48)
            let searchLabelWidth = cell.frame.width * (260/375)
            searchLabel.frame = CGRect(x: searchLabelX, y: searchLabelY, width: searchLabelWidth, height: searchLabelHeight)
            searchLabel.font = UIFont.systemFont(ofSize: 16)
            searchLabel.text = recentSearches[indexPath.row]
            cell.contentView.addSubview(searchLabel)
            
            return cell
        } else if(isFiltering()) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchedCell", for: indexPath) as! SearchedTableViewCell
            return cell
        } else {
            if(indexPath.section == 0) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "horizontalCategoryCell", for: indexPath) as! HorizontalCategoryTableViewCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "horizontalCategoryCell2", for: indexPath) as! HorizontalCategoryTableViewCell2
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(isSearching()) {
            return "Recent Search"
        } else if(isFiltering()) {
            return nil
        } else {
            if(section == 0){
                return "Topics to learn"
            } else if section == 1 {
                return "살면서 들어보지 못한 흥미로운 주제들"
            } else {
                return "LIPE 디자이너의 픽!"
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(isSearching()) {
            return 44
        } else if(isFiltering()) {
            return 120
        } else {
            if(indexPath.section == 0) {
                return 160
            } else {
                return 224
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(isSearching()) {
            return 0
        } else if(isFiltering()) {
            return 0
        } else {
            if(section == 0) {
                return 59
            } else{
                return 0
            }
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(isSearching()) {
            return 25
        } else if(isFiltering()) {
            return 25
        } else {
            if(section == 0) {
                return 52
            } else {
                return 23
            }
        }
    }
    
    @IBAction func openSearchBar(_ sender: Any) {
        navigationItem.searchController = searchController
        searchController.isActive = true
    }
    
    @IBAction func unwindFromVideo(segue: UIStoryboardSegue) {
    }

    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    */
}

extension CategoryTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
