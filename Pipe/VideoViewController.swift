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
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var moreButton: UIButton!
    
    @IBOutlet var videoContainerView: UIView!
    let playerViewController = CustomAVPlayerViewController()
    var player = AVPlayer()
    var screenTouchCount = 0
    //let controlOverlay = UIView()
    //let playButton = UIButton()
    //let fullscreenButton = UIButton()
    let playImage = UIImage(named: "play")
    let pauseImage = UIImage(named: "pause")
    let fullscreenImage = UIImage(named:"fullscreen")
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var fullScreenButton: UIButton!
    var timeObserver: Any?
    @IBOutlet var progressSlider: UISlider!
    @IBOutlet var timeRemainingLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    
    @IBAction func playbackSliderValueChanged(_ sender: UISlider) {
        let duration = player.currentItem!.duration
        let value = Float64(progressSlider.value) * CMTimeGetSeconds(duration)
        let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
        player.seek(to: seekTime )
    }
    
    @IBAction func playVideo(_ sender: UIButton) {
        if(player.rate != 0) {
            player.rate = 0
            sender.setImage(playImage, for: .normal)
        } else {
            player.rate = 1
            sender.setImage(pauseImage, for: .normal)
        }
    }
    
    @IBAction func goFullScreen(_ sender: UIButton) {
        self.player.pause()
        let newPlayerViewController = AVPlayerViewController()
        let videoURL = videos[0].url
        let newPlayer = AVPlayer(url: videoURL)
        
        newPlayerViewController.player = newPlayer
        
        present(newPlayerViewController, animated: true) {
            newPlayer.play()
        }
        playButton.setImage(playImage, for: .normal)
    }
    /*
    @objc func playVideo() {
        if(player.rate != 0) {
            player.rate = 0
            playButton.setImage(playImage, for: .normal)
        } else {
            player.rate = 1
            playButton.setImage(pauseImage, for: .normal)
        }
    }
    */
     @IBAction func speedUp15(_ sender: Any) {
     player.rate = 1.5
     }
    
    
    /*
    @objc func goFullScreen() {
        self.player.pause()
        let newPlayerViewController = AVPlayerViewController()
        let videoURL = videos[0].url
        let newPlayer = AVPlayer(url: videoURL)

        newPlayerViewController.player = newPlayer
        
        present(newPlayerViewController, animated: true) {
            newPlayer.play()
        }
    }
    */
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        //self.viewDidLayoutSubviews()
        
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
        
        //Setting up the Slider
        let interval = CMTime(seconds: 0.01, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { elapsedTime in
            self.updateVideoPlayerState()
        })
        timeRemainingLabel.textColor = UIColor.white
        timeRemainingLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        // Custom UI through storyboard
        playButton.isHidden = true
        fullScreenButton.isHidden = true
        progressSlider.isHidden = true
        timeRemainingLabel.isHidden = true
        backButton.isHidden = true
        /* My effort for custom UI programmatically */
        
        /*
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
            /*
            controlOverlay.isHidden = false
            playButton.isHidden = false
            fullscreenButton.isHidden = false
            */
            playButton.isHidden = false
            fullScreenButton.isHidden = false
            timeRemainingLabel.isHidden = false
            progressSlider.isHidden = false
            backButton.isHidden = false
            
            screenTouchCount = 1 - screenTouchCount
        } else {
            /*
            controlOverlay.isHidden = true
            playButton.isHidden = true
            fullscreenButton.isHidden = true
            */
            playButton.isHidden = true
            fullScreenButton.isHidden = true
            timeRemainingLabel.isHidden = true
            progressSlider.isHidden = true
            backButton.isHidden = true
            
            screenTouchCount = 1 - screenTouchCount
        }
    }
    
    func updateVideoPlayerState() {
        let currentTime = player.currentTime() 
        let currentTimeInSeconds = CMTimeGetSeconds(currentTime)
        progressSlider.value = Float(currentTimeInSeconds)
        if let currentItem = player.currentItem {
            let duration = currentItem.duration
            if (CMTIME_IS_INVALID(duration)) {
                return;
            }
            let currentTime = currentItem.currentTime()
            progressSlider.value = Float(CMTimeGetSeconds(currentTime) / CMTimeGetSeconds(duration))
            
            // Update time remaining label
            let totalTimeInSeconds = CMTimeGetSeconds(duration)
            let remainingTimeInSeconds = totalTimeInSeconds - currentTimeInSeconds
            
            let mins = remainingTimeInSeconds / 60
            let secs = remainingTimeInSeconds.truncatingRemainder(dividingBy: 60)
            let timeformatter = NumberFormatter()
            timeformatter.minimumIntegerDigits = 2
            timeformatter.minimumFractionDigits = 0
            timeformatter.roundingMode = .down
            guard let minsStr = timeformatter.string(from: NSNumber(value: mins)), let secsStr = timeformatter.string(from: NSNumber(value: secs)) else {
                return
            }
            timeRemainingLabel.text = "\(minsStr):\(secsStr)"
        }
    }

}
