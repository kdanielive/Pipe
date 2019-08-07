//
//  HorizontalCategoryTableViewCell.swift
//  Pipe
//
//  Created by Daniel Kim on 8/6/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit

class HorizontalCategoryTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet var horizontalCategoryCollectionView: UICollectionView!
    
    let images = ["AcademicCategory"]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryHorizontalCell", for: indexPath as IndexPath) as! HorizontalCategoryCollectionViewCell
        cell.categoryImage.image = UIImage(named: images[0])
        cell.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        cell.layer.cornerRadius = 9
        
        return cell
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section != 0) {
            return CGSize(width: 152, height: 86)
        } else {
            
        }
    }
     */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func layoutSubviews() {
        horizontalCategoryCollectionView.dataSource = self
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
