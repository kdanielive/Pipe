//
//  HorizontalCategoryTableViewCell2.swift
//  Pipe
//
//  Created by Daniel Kim on 8/7/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit

class HorizontalCategoryTableViewCell2: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryHorizontalCell2", for: indexPath as IndexPath) as! HorizontalCategoryCollectionViewCell2
        
        cell.backgroundColor = UIColor.blue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
        return CGSize(width: 152, height: 86)

    }
    
    override func layoutSubviews() {
        collectionView.dataSource = self
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
