//
//  CollectionHolderTableViewCell.swift
//  Pipe
//
//  Created by Daniel Kim on 7/31/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit

class CollectionHolderTableViewCell: UITableViewCell, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontalCollectionCell", for: indexPath as IndexPath) as! HorizontalCollectionViewCell
        cell.bounds = CGRect(x: 0, y: 0, width: 120, height: 180)
        cell.backgroundColor = UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.0)
        cell.layer.cornerRadius = 10
        
        let row = indexPath.row
        if(row==0) {    cell.titleLabel.text = "Travel" }
        else if(row==1) {   cell.titleLabel.text = "Music"  }
        else if(row==2) {   cell.titleLabel.text = "Cooking"    }
        else if(row==3) {   cell.titleLabel.text = "Shopping"   }
        else    {   cell.titleLabel.text = "View More"  }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    @IBOutlet var horizontalCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        horizontalCollectionView.dataSource = self
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
