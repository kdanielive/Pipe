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

        cell.backgroundColor = UIColor.blue
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
