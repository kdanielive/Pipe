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
    // Overlay
    let overlay = UIView()
    // Slider
    var timeObserver: Any?
    let timeRemainingLabel = UILabel()
    let timeSpentLabel = UILabel()
    let progressSlider = UISlider()
    // Play Button
    let playbackButton = UIButton()
    // Fullscreen Button
    let fullScreenButton = UIButton()
    // Options Button
    let optionsButton = UIButton()
    
    //// Stack View
    let stackView = UIStackView()
    
    //// Title Label
    let titleLabel = UILabel()
    
    //// Info Bar
    let infoBar = UIView()
    
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
        setupFullScreenButton()
        setupTimeRemainingLabel()
        setupTimeSpentLabel()
        setupOptionsButton()
        setupOverlay()
        
        // Setup scrollView and contentView
        setupScroll()
        
        // Setting the tagLabels
        setupTagLabels()
        
        // Setting the titleLabel
        setupTitleLabel()
        
        // Setup the infoBar
        setupInfoBar()

        // Do any additional setup after loading the view.
    }
    
    func setupInfoBar() {
        let infoBarX = titleLabel.frame.minX
        let infoBarY = titleLabel.frame.maxY + CGFloat(10)
        let infoBarWidth = contentView.frame.width * (260/375)
        let infoBarHeight = videoContainerView.frame.height * (20/211)
        infoBar.frame = CGRect(x: infoBarX, y: infoBarY, width: infoBarWidth, height: infoBarHeight)
        
        let starImage = UIImageView()
        starImage.image = UIImage(named: "filledRatingIcon")
        starImage.frame = CGRect(x: 0, y: 0, width: infoBarHeight, height: infoBarHeight)
        
        let ratingLabel = UILabel()
        let ratingX = infoBarHeight + CGFloat(5)
        let ratingWidth = infoBarWidth * (40/260)
        ratingLabel.font = UIFont.systemFont(ofSize: 14)
        ratingLabel.numberOfLines = 1
        ratingLabel.frame = CGRect(x: ratingX, y: 0, width: ratingWidth, height: infoBarHeight)
        ratingLabel.text = "4.0"
        
        let playImage = UIImageView()
        let playImageX = ratingLabel.frame.maxX + CGFloat(10)
        playImage.image = UIImage(named: "playedStatIcon")
        playImage.frame = CGRect(x: playImageX, y: 0, width: infoBarHeight, height: infoBarHeight)
        
        let statLabel = UILabel()
        let statX =  playImage.frame.maxX + CGFloat(5)
        let statWidth = infoBarWidth - statX
        statLabel.font = UIFont.systemFont(ofSize: 14)
        statLabel.numberOfLines = 1
        statLabel.text = "52K * 2 months ago"
        statLabel.frame = CGRect(x: statX, y: 0, width: statWidth, height: infoBarHeight)
        
        infoBar.addSubview(starImage)
        infoBar.addSubview(ratingLabel)
        infoBar.addSubview(playImage)
        infoBar.addSubview(statLabel)
        contentView.addSubview(infoBar)
    }
    
    func setupTitleLabel() {
        let titleLabelX = stackView.frame.minX
        let titleLabelY = stackView.frame.maxY + CGFloat(10)
        let titleLabelWidth = contentView.frame.width * (325/375)
        let titleLabelHeight = videoContainerView.frame.height * (50/211)
        titleLabel.frame = CGRect(x: titleLabelX, y: titleLabelY, width: titleLabelWidth, height: titleLabelHeight)
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode  = .byWordWrapping
        titleLabel.text = "“Secret Spots” : 3 bars you must visit in New York City"
        
        contentView.addSubview(titleLabel)
    }
    
    func setupTagLabels() {
        stackView.axis = .horizontal
        stackView.alignment = .center // .leading .firstBaseline .center .trailing .lastBaseline
        stackView.distribution = .fill // .fillEqually .fillProportionally .equalSpacing .equalCentering
        
        let label1 = CustomTagLabel()
        label1.text = "  #travel  "
        stackView.addArrangedSubview(label1)
        
        let label2 = CustomTagLabel()
        label2.text = "  #newyork  "
        stackView.addArrangedSubview(label2)
        
        let spacerView = UIView()
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stackView.addArrangedSubview(spacerView)
        
        let stackViewX = contentView.frame.width * (20/375)
        let stackViewY = stackViewX
        let stackViewWidth = contentView.frame.width - CGFloat(2 * stackViewX)
        let stackViewHeight = CGFloat(20)
        stackView.frame = CGRect(x: stackViewX, y: stackViewY, width: stackViewWidth, height: stackViewHeight
        )
        stackView.spacing = 10
        
        contentView.addSubview(stackView)
    }
    
    func setupScroll() {
        let scrollViewY = videoContainerView.frame.height
        let scrollViewWidth = self.view.frame.width
        let scrollViewHeight = self.view.frame.height - videoContainerView.frame.height
        scrollView.frame = CGRect(x: 0, y: scrollViewY, width: scrollViewWidth, height: scrollViewHeight)
        scrollView.contentSize = CGSize(width: scrollViewWidth, height: self.view.frame.height)
        backgroundView.addSubview(scrollView)
        
        contentView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        scrollView.addSubview(contentView)
    
    }
    
    func setupOverlay() {
        overlay.frame = videoContainerView.frame
        overlay.addSubview(progressSlider)
        overlay.addSubview(playbackButton)
        overlay.addSubview(fullScreenButton)
        overlay.addSubview(timeRemainingLabel)
        overlay.addSubview(timeSpentLabel)
        overlay.addSubview(optionsButton)
        backgroundView.addSubview(overlay)
        
        let hideGesture = UITapGestureRecognizer(target: self, action: #selector(hideOverlay))
        overlay.addGestureRecognizer(hideGesture)
        let showGesture = UITapGestureRecognizer(target: self, action: #selector(showOverlay))
        playerViewController.view.addGestureRecognizer(showGesture)
        
        overlay.isHidden = true
    }
    
    @objc func hideOverlay() {
        overlay.isHidden = true
        videoContainerView.alpha = 1
    }
    
    @objc func showOverlay() {
        overlay.isHidden = false
        videoContainerView.alpha = 0.7
    }
    
    func setupOptionsButton() {
        let buttonCenterX = fullScreenButton.center.x
        let buttonCenterY = videoContainerView.frame.height * (30/211)
        let buttonWidth = videoContainerView.frame.width * (10/375)
        let buttonHeight = videoContainerView.frame.height * (17/211)
        
        optionsButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
        optionsButton.center = CGPoint(x: buttonCenterX, y: buttonCenterY)
        optionsButton.setImage(UIImage(named: "moreIcon"), for: .normal)
        
        //videoContainerView.addSubview(optionsButton)
    }
    
    func setupTimeSpentLabel() {
        let labelCenterX = videoContainerView.frame.width * (40/375)
        let labelCenterY = videoContainerView.frame.height * (187/211)
        timeSpentLabel.frame = timeRemainingLabel.frame
        timeSpentLabel.center = CGPoint(x: labelCenterX, y: labelCenterY)
        timeSpentLabel.font = UIFont.boldSystemFont(ofSize: 12)
        timeSpentLabel.textColor = UIColor.white
        
        //videoContainerView.addSubview(timeSpentLabel)
    }
    
    func setupTimeRemainingLabel() {
        let labelCenterX = fullScreenButton.center.x - videoContainerView.frame.width * (42/375)
        let labelCenterY = fullScreenButton.center.y
        let labelWidth = videoContainerView.frame.width * (50/375)
        let labelHeight = videoContainerView.frame.height * (17/211)
        
        timeRemainingLabel.frame = CGRect(x: 0, y: 0, width: labelWidth, height: labelHeight)
        timeRemainingLabel.center = CGPoint(x: labelCenterX, y: labelCenterY)
        timeRemainingLabel.font = UIFont.boldSystemFont(ofSize: 12)
        
        //videoContainerView.addSubview(timeRemainingLabel)
    }
    
    func setupFullScreenButton() {
        let fullScreenPadding = CGFloat(15)
        let fullScreenWH = videoContainerView.frame.width * (15/375)
        let fullScreenX = videoContainerView.frame.width - fullScreenPadding - fullScreenWH
        let fullScreenY = videoContainerView.frame.height - fullScreenPadding - fullScreenWH
        fullScreenButton.frame = CGRect(x: fullScreenX, y: fullScreenY, width: fullScreenWH, height: fullScreenWH)
        fullScreenButton.setImage(UIImage(named: "fullscreen"), for: .normal)
        fullScreenButton.addTarget(self, action: #selector(goFullScreen), for: .touchUpInside)
        
        //videoContainerView.addSubview(fullScreenButton)
    }
    
    @objc func goFullScreen() {
        let newPlayerViewController = AVPlayerViewController()
        let newPlayer = player
        newPlayerViewController.player = newPlayer
        present(newPlayerViewController, animated: true) {
            newPlayer.play()
        }
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
            
            guard let minsStr2 = timeformatter.string(from: NSNumber(value: currentTimeInSeconds / 60)), let secsStr2 = timeformatter.string(from: NSNumber(value: currentTimeInSeconds.truncatingRemainder(dividingBy: 60))) else {
                return
            }
            timeSpentLabel.text = "\(minsStr2):\(secsStr2)"
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
    
    class CustomTagLabel: UILabel {
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
            //setupViews()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
        }
        
        
        func setupViews() {
            //this causes the label to disappear for some reason
            //self.roundCorners(corners: UIRectCorner.allCorners, radius: 23)
            self.textColor = UIColor.white
            self.font = UIFont.boldSystemFont(ofSize: 12)
            self.layer.cornerRadius = 6
            self.layer.backgroundColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1).cgColor
            
        }
    }
}
