//
//  VideoViewController.swift
//  Pipe
//
//  Created by Daniel Kim on 7/30/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {

    var videos = Video.allVideos()
    let controlOverlay = UIView()
    @IBOutlet var videoContainerView: UIView!
    var screenTouchCount = 0
    let playerViewController = CustomAVPlayerViewController()
    var player = AVPlayer()
    
    var buttonTouchCount = 0

    // Custom controls
    //var playPauseButton: PlayPauseButton!

    @IBAction func testTouch(_ sender: Any) {
        if(buttonTouchCount == 0) {
            player.rate = 2.0
            buttonTouchCount = 1 - buttonTouchCount
        } else {
            player.rate = 1.0
            buttonTouchCount = 1 - buttonTouchCount
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Video Player at the top part of the view
        let videoURL = videos[0].url
        player = AVPlayer(url: videoURL)
        
        /*
        // Custom controls part
        playerViewController.showsPlaybackControls = false
        playPauseButton = PlayPauseButton()
        playPauseButton.avPlayer = player
        videoContainerView.addSubview(playPauseButton)
        playPauseButton.setup(in: self)
        */
        
        // Back to implementing video player at the top of the view
        playerViewController.player = player
        addChildViewController(playerViewController)
        playerViewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        playerViewController.view.frame = videoContainerView.bounds
        playerViewController.videoGravity = "resize"
        videoContainerView.addSubview(playerViewController.view)
        playerViewController.player!.play()
        
        // Do any additional setup after loading the view.
        /* My effort for custom UI */
        videoContainerView.addSubview(controlOverlay)
        controlOverlay.bounds = CGRect(x: videoContainerView.frame.origin.x, y: videoContainerView.frame.origin.y, width: videoContainerView.frame.width * 2, height: videoContainerView.frame.height * 2)
        controlOverlay.alpha = 0.1
        controlOverlay.backgroundColor = UIColor.blue
        controlOverlay.superview?.bringSubview(toFront: controlOverlay)
        controlOverlay.isUserInteractionEnabled = false
        controlOverlay.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(popOverlay), name: NSNotification.Name(rawValue: "overlay"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        playPauseButton.updateUI()
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    class CustomAVPlayerViewController: AVPlayerViewController {
        var screenTouchCount = 0
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "overlay"), object: nil)
        }
    }
    
    @objc func popOverlay() {
        print("event triggered")
        if(screenTouchCount == 0) {
            controlOverlay.isHidden = false
            screenTouchCount = 1 - screenTouchCount
        } else {
            controlOverlay.isHidden = true
            screenTouchCount = 1 - screenTouchCount
        }
    }

}
