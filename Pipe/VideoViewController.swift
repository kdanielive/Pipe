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
    
    @IBOutlet var videoContainerView: UIView!
    let playerViewController = CustomAVPlayerViewController()
    var player = AVPlayer()
    
    var screenTouchCount = 0
    
    let controlOverlay = UIView()
    let playButton = UIButton()
    let playImage = UIImage(named: "play")
    let pauseImage = UIImage(named: "pause")
    /*
    let fullscreenButton = UIButton()
    let fullscreenImage = UIImage(named:"fullscreen")
    */
    
    @IBAction func speedUp15(_ sender: Any) {
        player.rate = 1.5
    }
    

    // Custom controls
    //var playPauseButton: PlayPauseButton!
    
    @objc func playVideo() {
        if(player.rate != 0) {
            player.rate = 0
            playButton.setImage(playImage, for: .normal)
        } else {
            player.rate = 1
            playButton.setImage(pauseImage, for: .normal)
        }
    }
    
    @objc func goFullScreen() {
        playerViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        print("yeah")
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
        //playerViewController.videoGravity = "resize"
        videoContainerView.addSubview(playerViewController.view)
        playerViewController.player!.play()
        
        // Do any additional setup after loading the view.
        
        /* My effort for custom UI */
        playerViewController.showsPlaybackControls = true
        
        videoContainerView.addSubview(controlOverlay)
        controlOverlay.frame = CGRect(x: 0, y: 0, width: videoContainerView.frame.width, height: videoContainerView.frame.height)
        controlOverlay.alpha = 0.1
        controlOverlay.backgroundColor = UIColor.white
        //controlOverlay.superview?.bringSubview(toFront: controlOverlay)
        controlOverlay.isUserInteractionEnabled = false
        controlOverlay.isHidden = true
        
        videoContainerView.addSubview(playButton)
        playButton.setImage(pauseImage, for: .normal)
        playButton.frame = CGRect(x: videoContainerView.frame.width / 2 - 30, y: videoContainerView.frame.height / 2 - 30, width: 60, height: 60)
        playButton.isHidden = true
        playButton.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        
        /*
        videoContainerView.addSubview(fullscreenButton)
        fullscreenButton.frame = CGRect(x:0, y:0, width:30, height:30)
        fullscreenButton.isHidden = true
        fullscreenButton.addTarget(self, action: #selector(goFullScreen), for: .touchUpInside)
        fullscreenButton.setImage(fullscreenImage, for: .normal)
        */
        
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
        if(screenTouchCount == 0) {
            controlOverlay.isHidden = false
            playButton.isHidden = false
            //fullscreenButton.isHidden = false
            
            screenTouchCount = 1 - screenTouchCount
        } else {
            controlOverlay.isHidden = true
            playButton.isHidden = true
            //fullscreenButton.isHidden = true
            
            screenTouchCount = 1 - screenTouchCount
        }
    }

}
