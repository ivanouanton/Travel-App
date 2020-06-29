//
//  AudioPlayerView.swift
//  Travel-App
//
//  Created by Anton Ivanov on 2/7/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class AudioPlayerView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var fastforwardButton: UIButton!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var player = AVPlayer()
    var sliderTimer: Timer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.isUserInteractionEnabled = false
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("AudioPlayerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        hideLoadingIndicator()
    }
    
    func setupAudio(with ref: DocumentReference) {
        PlaceManager.shared.getAudioURL(with: ref) { (hardUrl, error) in
            self.hideLoadingIndicator()

            if let error = error{
                print(error.localizedDescription)
            }
            if let url = hardUrl {
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    self.player = AVPlayer(playerItem: AVPlayerItem(url: url))

                    self.setupSlider()
                    self.contentView.isUserInteractionEnabled = true

                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        
        rewindButton.alpha = 0
        fastforwardButton.alpha = 0
    }
    
    // MARK: Notifications
    
    @objc func episodeLoadedNotification(_ notification: Notification) {
        if let percentage: NSNumber = notification.object as? NSNumber {
            self.statusLabel.text = "\(percentage.intValue)% Loaded"
        }
    }
    
    
    // MARK: - Actions

    @IBAction func playButtonPressed(_ sender: AnyObject) {
        
        if self.player.timeControlStatus == AVPlayer.TimeControlStatus.playing{
            self.player.pause()
        }else{
            self.player.play()
        }
        updatePlayButton()
    }

    @IBAction func rewindButtonPressed(_ sender: AnyObject) {
//        TPGAudioPlayer.sharedInstance().skipDirection(skipDirection: SkipDirection.backward, timeInterval: kTestTimeInterval, offset: TPGAudioPlayer.sharedInstance().currentTimeInSeconds)
    }

    @IBAction func fastforwardButtonPressed(_ sender: AnyObject) {
//        TPGAudioPlayer.sharedInstance().skipDirection(skipDirection: SkipDirection.forward, timeInterval: kTestTimeInterval, offset: TPGAudioPlayer.sharedInstance().currentTimeInSeconds)
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {

        
        let newTime = CMTimeMakeWithSeconds(Float64(sender.value), preferredTimescale: 100)
        
        player.seek(to: newTime, completionHandler: { (finished) -> Void in
           
        })
    }
    
    func stopPlaing() {
        if self.player.timeControlStatus == AVPlayer.TimeControlStatus.playing{
            self.player.pause()
            updatePlayButton()
        }
    }

    func updatePlayButton() {
        let playPauseImage: UIImage
        
        if player.rate == 0.0 {
            playPauseImage  = UIImage(named: "play")!
        }else {
            playPauseImage  = UIImage(named: "pause")!
        }

        self.playButton.setImage(playPauseImage, for: UIControl.State())
    }

    func setupSlider() {
        if let duration = player.currentItem?.asset.duration {
            let seconds = CMTimeGetSeconds(duration)
            self.progressSlider.maximumValue = Float(seconds)
        }
        self.progressSlider.minimumValue = 0.0

        if let _ = self.sliderTimer {
            self.sliderTimer?.invalidate()
        }

        self.sliderTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(sliderTimerTriggered), userInfo: nil, repeats: true)

        self.setupTotalTimeLabel()
    }

    @objc func sliderTimerTriggered() {
        let playerCurrentTime = player.currentTime().seconds

        self.progressSlider.value = Float( playerCurrentTime )

        self.updateCurrentTimeLabel(Float( playerCurrentTime ))
    }

    func updateCurrentTimeLabel(_ currentTimeInSeconds: Float) {
        if currentTimeInSeconds.isNaN || currentTimeInSeconds.isInfinite {
            return
        }

        currentTimeLabel.text = timeLabelString( Int( currentTimeInSeconds ) )
    }

    func setupTotalTimeLabel() {
        
        if let duration = player.currentItem?.asset.duration {
            let seconds = CMTimeGetSeconds(duration)
            
            if seconds.isNaN || seconds.isInfinite {
                return
            }

            totalTimeLabel.text = timeLabelString( Int (seconds) )
        }
    }

    func showLoadingIndicator() {
        self.playButton.isHidden = true
        self.loadingIndicator.isHidden = false

        self.loadingIndicator.startAnimating()
    }

    func hideLoadingIndicator() {
        self.playButton.isHidden = false
        self.loadingIndicator.isHidden = true

        self.loadingIndicator.stopAnimating()
    }

    func timeLabelString(_ duration: Int) -> String {
        let currentMinutes = Int(duration) / 60
        let currentSeconds = Int(duration) % 60

        return currentSeconds < 10 ? "\(currentMinutes):0\(currentSeconds)" : "\(currentMinutes):\(currentSeconds)"
    }
}
