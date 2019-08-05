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
    
    // Macro Scroll View
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!

    // Video control Images and Icons
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
    
    // Video controls
    @IBOutlet var playButton: UIButton!
    @IBOutlet var fullScreenButton: UIButton!
    var timeObserver: Any?
    @IBOutlet var progressSlider: UISlider!
    @IBOutlet var timeRemainingLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var moreButton: UIButton!
    
    // Macro View Controls
    var popupView = UIView()
    var gestureRecognizerView = UIView()
    var captionsView = UIView()
    @IBOutlet var contentViewTopConstraint: NSLayoutConstraint!
    
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
    @IBAction func pressedMoreOptionsPanelButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let popupViewController = storyboard.instantiateViewController(withIdentifier: "PopupTableView") as! MoreOptionsTableViewController
        addChildViewController(popupViewController)
        popupView = UIView(frame: CGRect(x: 0, y: self.view.bounds.height - 220, width: self.view.bounds.width, height: 220))
        popupViewController.view.frame = popupView.bounds
        self.view.addSubview(popupView)
        popupView.addSubview(popupViewController.view)
        gestureRecognizerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - 220))
        self.view.addSubview(gestureRecognizerView)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissModalView))
        gestureRecognizerView.addGestureRecognizer(gesture)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        //self.viewDidLayoutSubviews()
        
        // Video Player at the top part of the view
        let videoURL = videos[0].url
        player = AVPlayer(url: videoURL)
        
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
    
        
        NotificationCenter.default.addObserver(self, selector: #selector(popOverlay), name: NSNotification.Name(rawValue: "overlay"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(popCaptions), name: NSNotification.Name(rawValue: "popCaptions"), object: nil)
 
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
    
    @objc func popOverlay() {
        if(screenTouchCount == 0) {
            playButton.isHidden = false
            fullScreenButton.isHidden = false
            timeRemainingLabel.isHidden = false
            progressSlider.isHidden = false
            backButton.isHidden = false
            
            screenTouchCount = 1 - screenTouchCount
        } else {
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
    
    @objc func dismissModalView() {
        popupView.removeFromSuperview()
        gestureRecognizerView.removeFromSuperview()
    }
    
    @objc func popCaptions() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let captionsViewController = storyboard.instantiateViewController(withIdentifier: "CaptionsViewController") as! CaptionsViewController
        addChildViewController(captionsViewController)
        captionsView = UIView(frame: CGRect(x: 0, y: videoContainerView.frame.height + 50, width: self.view.frame.width, height: self.view.bounds.height / 3))
        captionsViewController.view.frame = captionsView.bounds
        self.view.addSubview(captionsView)
        captionsView.addSubview(captionsViewController.view)
        
        //scrollView.bounds = CGRect(x: 0, y: videoContainerView.frame.height + captionsView.frame.height, width: self.view.frame.width, height: self.view.frame.height - videoContainerView.frame.height - captionsView.frame.height)
    }
    
    class CustomAVPlayerViewController: AVPlayerViewController {
        var screenTouchCount = 0
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "overlay"), object: nil)
        }
        
        override func viewDidLoad() {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(procNotification))
            self.view.addGestureRecognizer(gesture)
        }
        
        @objc func procNotification() {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "overlay"), object: nil)
        }
    }

}
