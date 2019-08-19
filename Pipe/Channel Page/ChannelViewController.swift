//
//  ChannelViewController.swift
//  Pipe
//
//  Created by Daniel Kim on 8/14/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {

    @IBOutlet var horizontalCollectionView: UICollectionView!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var uploadButton: UIButton!
    @IBOutlet var labels: [UILabel]!
    let mockLabelTitles = ["helloooooooo", "slkdjflsk;fhi", "holoholo"]
    
    @IBAction func goBackToProfile(_ sender: Any) {
        performSegue(withIdentifier: "unwindToProfileSegue", sender: self)
    }
    @IBAction func testPressed(_ sender: Any) {
        print("fuck")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutCategoryLabels(labelTitles: mockLabelTitles)
        configureUploadButton()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("1. Printing contentView Height: ", contentView.frame.height)
        //print("2. Printing self.scrollview Height: ", self.scrollView.frame.height)
        //print("3. Printing scrollview Height: ", scrollView.frame.height)

        //self.contentView.frame.size.height = 1500
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // When dealing with scrollview, always be wary of the contentSize and the contentView size
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height*2)
        //self.contentView.frame.size.height = 1500
        
        //print("Printing:   ", scrollView.frame.height)
        //print("Printing2:   ", scrollView.contentSize.height)
        //print("4. Printing contentView Height: ", contentView.frame.height)
        
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
    }
    
    func configureUploadButton() {
        uploadButton.layer.borderWidth = 1.0
        uploadButton.layer.borderColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0).cgColor
        uploadButton.layer.cornerRadius = 11
        uploadButton.setTitle("      Upload      ", for: .normal)
        uploadButton.setTitleColor(UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0), for: .normal)
    }
    
    func layoutCategoryLabels(labelTitles: [String]) {
        for label in labels {
            label.sizeToFit()
        }
        
        // Setting label text
        labels[1].text = " " + mockLabelTitles[0] + " "
        labels[2].text = " " + mockLabelTitles[1] + " "
        labels[3].text = " " + mockLabelTitles[2] + " "
        
        // Hiding labels without text from view
        for label in labels{
            if label.text == "Label" {
                label.isHidden = true
            }
        }
        
        //Setting Label design
        for label in labels {
            //label.backgroundColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1)
            //label.textColor = UIColor.white
            //label.roundCorners(corners: UIRectCorner.allCorners, radius: 11)
            label.layer.backgroundColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1).cgColor
            label.layer.cornerRadius = 11
            label.textColor = UIColor.white
        }
    }

    /*
    // MARK: - Navigation
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChannelViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 216, height: 156)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ChannelHorizontalCollectionViewCell
        cell.videoCardView.isUserInteractionEnabled = true
        return cell
    }
    
    
}
