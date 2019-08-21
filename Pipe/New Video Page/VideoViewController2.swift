//
//  VideoViewController2.swift
//  Pipe
//
//  Created by Daniel Kim on 8/21/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController2: UIViewController {


    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    
    let videoContainerView = UIView()
    let playerViewController = CustomAVPlayerViewController()
    var player = AVPlayer(url: Video.allVideos()[4].url)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the videoContainerView
        setupVideoContainerView()
        
        // Getting rid of the given controls
        playerViewController.showsPlaybackControls = false
        
        // Implementing video player at the top of the view
        playerViewController.player = player
        addChildViewController(playerViewController)
        playerViewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        playerViewController.view.frame = videoContainerView.bounds
        //playerViewController.videoGravity = "resize"
        videoContainerView.addSubview(playerViewController.view)
        playerViewController.player!.play()


        

        // Do any additional setup after loading the view.
    }
    
    func setupVideoContainerView() {
        let videoContainerViewWidth = view.frame.width
        let videoContainerViewHeight = view.frame.width * (211/375)
        videoContainerView.frame = CGRect(x: 0, y: 0, width: videoContainerViewWidth, height: videoContainerViewHeight)
        
        view.addSubview(videoContainerView)
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    class CustomAVPlayerViewController: AVPlayerViewController {
        var screenTouchCount = 0
        
        override func viewDidLoad() {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(procNotification))
            self.view.addGestureRecognizer(gesture)
        }
        
        @objc func procNotification() {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "overlay"), object: nil)
        }
    }

}
