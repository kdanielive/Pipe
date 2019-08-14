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
        
        addSearchBar()

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
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0) {  return videos.count }
        else{   return 1;   }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if(section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "videocell", for: indexPath) as! FeedTableViewCell
            return cell
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell") as! CollectionHolderTableViewCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0) {
            return "Featured Videos"
        } else  {
            return "Topics in Lifestyle"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0) {
            let video = videos[indexPath.row]
            return FeedTableViewCell.height(for: video)
        } else {
            return 200
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    @IBAction func openSearchBar(_ sender: Any) {
        navigationItem.searchController = searchController
        searchController.isActive = true
    }
}

extension VideoTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        //filterContentForSearchText(searchController.searchBar.text!)
    }
}
