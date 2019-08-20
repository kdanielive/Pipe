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
        cell.bounds = CGRect(x: 0, y: 0, width: 120, height: 130)
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 10
        
        let row = indexPath.row
        if(row==0) {    cell.titleLabel.text = "Travel" }
        else if(row==1) {   cell.titleLabel.text = "Music"  }
        else if(row==2) {   cell.titleLabel.text = "Cooking"    }
        else if(row==3) {   cell.titleLabel.text = "Shopping"   }
        else    {   cell.titleLabel.text = "View More"  }
        cell.titleLabel.font = UIFont.systemFont(ofSize: 15)
        
        cell.cellImage.image = UIImage(named: "cellIcon")
        cell.bringSubview(toFront: cell.titleLabel)
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
    
    func setShadow(supView: UIView) {
        
        let shadowView = UIView()
        shadowView.frame = CGRect(x: 0, y: 0, width: supView.frame.width, height: supView.frame.height)
        shadowView.clipsToBounds = false
        shadowView.layer.backgroundColor = UIColor.clear.cgColor
        shadowView.backgroundColor = UIColor.clear
        
        let shadowSize: Double = 5
        
        shadowView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: -shadowSize/2, y: -shadowSize/2, width: Double(supView.frame.size.width)+shadowSize, height: Double(supView.frame.height)+shadowSize), cornerRadius: 5.0).cgPath
        shadowView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.11).cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowRadius = 4
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.bounds = supView.bounds
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        
        supView.addSubview(shadowView)
        supView.sendSubview(toBack: shadowView)

    }

}
