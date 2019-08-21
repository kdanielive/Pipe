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
    
    
    //// MacroViews: scrollView, contentView, backgroundView
    let scrollView = UIScrollView()
    let contentView = UIView()
    @IBOutlet var backgroundView: UIView!
    
    //// Video Views
    let videoContainerView = UIView()
    let playerViewController = CustomAVPlayerViewController()
    var player = AVPlayer(url: Video.allVideos()[4].url)
    
    //// Video components
    // Slider
    var timeObserver: Any?
    let timeRemainingLabel = UILabel()
    let progressSlider = UISlider()
    // Play Button
    let playbackButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the videoContainerView
        setupVideoContainerView()
        
        // Getting rid of the given controls
        playerViewController.showsPlaybackControls = false
        
        // Implementing video player at the top of the view
        loadVideoIntoContainerView()

        //// Set up components in the containerView
        setupSlider()
        setupPlaybackButton()

        // Do any additional setup after loading the view.
    }
    
    func setupPlaybackButton() {
        let playbackButtonWH = videoContainerView.frame.width * (35/375)
        playbackButton.frame = CGRect(x: 0, y: 0, width: playbackButtonWH, height: playbackButtonWH)
        playbackButton.center = videoContainerView.center
        playbackButton.setImage(UIImage(named: "pause"), for: .normal)
        playbackButton.addTarget(self, action: #selector(playbackPressed), for: .touchUpInside)
        videoContainerView.addSubview(playbackButton)
        
        NotificationCenter.default.addObserver(self, selector: #selector(videoFinished), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    @objc func videoFinished() {
        playbackButton.setImage(UIImage(named: "rewind"), for: .normal)
        playbackButton.tag = 2
    }
    
    @objc func playbackPressed() {
        if(playbackButton.tag == 0) {
            playbackButton.setImage(UIImage(named: "play"), for: .normal)
            playbackButton.tag = 1
            player.pause()
        } else if playbackButton.tag == 1 {
            playbackButton.setImage(UIImage(named: "pause"), for: .normal)
            playbackButton.tag = 0
            player.play()
        } else {
            playbackButton.setImage(UIImage(named: "pause"), for: .normal)
            playbackButton.tag = 0
            player.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
            player.play()
        }
    }
    
    func setupSlider() {
        let sliderX = CGFloat(0)
        let sliderY = videoContainerView.frame.height
        let sliderWidth = videoContainerView.frame.width
        let sliderHeight = CGFloat(10)
        
        progressSlider.minimumTrackTintColor = UIColor.blue
        progressSlider.maximumTrackTintColor = UIColor.gray
        progressSlider.thumbTintColor = UIColor.blue
        progressSlider.maximumValue = 1.0
        progressSlider.minimumValue = 0
        progressSlider.setValue(0, animated: false)
        progressSlider.frame = CGRect(x: sliderX, y: sliderY - sliderHeight/2, width: sliderWidth, height: sliderHeight)
        setSliderThumbTintColor(UIColor.blue)
        
        backgroundView.addSubview(progressSlider)
        backgroundView.bringSubview(toFront: progressSlider)
        
        progressSlider.addTarget(self, action: #selector(playbackSliderValueChanged), for: .valueChanged)
        
        let interval = CMTime(seconds: 0.01, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { elapsedTime in
            self.updateVideoPlayerState()
        })
        timeRemainingLabel.textColor = UIColor.white
        timeRemainingLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
    
    func setSliderThumbTintColor(_ color: UIColor) {
        let circleImage = makeCircleWith(size: CGSize(width: 14, height: 14),
                                         backgroundColor: color)
        progressSlider.setThumbImage(circleImage, for: .normal)
        progressSlider.setThumbImage(circleImage, for: .highlighted)
    }
    
    @objc func playbackSliderValueChanged(sender: UISlider) {
        let duration = player.currentItem!.duration
        let value = Float64(progressSlider.value) * CMTimeGetSeconds(duration)
        let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
        player.seek(to: seekTime )
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
    
    func loadVideoIntoContainerView () {
        playerViewController.player = player
        addChildViewController(playerViewController)
        playerViewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        playerViewController.view.frame = videoContainerView.bounds
        //playerViewController.videoGravity = "resize"
        videoContainerView.addSubview(playerViewController.view)
        playerViewController.player!.play()
    }
    
    func setupVideoContainerView() {
        let videoContainerViewWidth = view.frame.width
        let videoContainerViewHeight = view.frame.width * (211/375)
        videoContainerView.frame = CGRect(x: 0, y: 0, width: videoContainerViewWidth, height: videoContainerViewHeight)
        
        backgroundView.addSubview(videoContainerView)
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
    
    fileprivate func makeCircleWith(size: CGSize, backgroundColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backgroundColor.cgColor)
        context?.setStrokeColor(UIColor.clear.cgColor)
        let bounds = CGRect(origin: .zero, size: size)
        context?.addEllipse(in: bounds)
        context?.drawPath(using: .fill)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
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
