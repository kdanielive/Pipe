//
//  VideoTableViewController.swift
//  Pipe
//
//  Created by Daniel Kim on 7/30/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit
import AVKit

class VideoTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet var searchBarItem: UIBarButtonItem!
    // Adding Searchbar
    let searchController = UISearchController(searchResultsController: nil)
    var videos: [Video] = Video.allVideos()
    
    let lessons = ["hihihi", "hellohello", "olaola"]
    var recentSearches = ["hihi", "yolo", "recent search"]
    var filteredLessons = [String]()
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchBar()
        
        // Removing tableview cell borderlines
        self.tableView.separatorStyle = .none

        // Removing navigation bar color
        self.navigationController?.navigationBar.barTintColor = UIColor.white

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0) {  return videos.count }
        else if (section == 1){   return 1;   }
        else {
            return videos.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if(section == 1)  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell") as! CollectionHolderTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "videocell", for: indexPath) as! FeedTableViewCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor  = UIColor.white
        
        let titleLabel = UILabel()
        switch section {
        case 0:
            titleLabel.text = "Featured Videos"
        case 1:
            titleLabel.text = "Topics in Lifestyle"
        case 2:
            titleLabel.text = "Contents in Travel"
        case 3:
            titleLabel.text = "Learning Economics"
        default:
            titleLabel.text = "Oops"
        }
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.frame = CGRect(x: 20, y: 0, width: tableView.bounds.size.width-20, height: 30)
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 50))

        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 1){
            return 200
        } else {
            let viewWidth = self.view.frame.width
            let requiredHeight = (viewWidth-40)*(298/335)+40
            print("printing", requiredHeight)
            return requiredHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    @IBAction func openSearchBar(_ sender: Any) {
        navigationItem.searchController = searchController
        searchController.isActive = true
    }
    
    @IBAction func unwindFromVideo(segue: UIStoryboardSegue) {
    }

}

extension VideoTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        //filterContentForSearchText(searchController.searchBar.text!)
    }
}
