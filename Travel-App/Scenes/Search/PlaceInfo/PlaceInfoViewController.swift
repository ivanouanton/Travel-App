//
//  PlaceInfoViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/1/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class PlaceInfoViewController: UIViewController {

    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var titleDescriptionLabel: UILabel!
    @IBOutlet weak var subTitleDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var audioPlayerView: AudioPlayerView!
    
    var place: PlaceCardModel?
    var category: String = ""
    var image: UIImage = UIImage(named: "preview-target-place")!
    
    var audioPlayer = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let place = place else {return}
        self.titleDescriptionLabel.text = place.name
        self.descriptionLabel.text = place.description
        self.placeImage.image = place.image
        self.categoryLabel.text = place.category

        guard let audioReference = place.audio else { return }
        audioPlayerView.setupAudio(with: audioReference)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.removeObserver( self )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let place = place else {return}
        self.navigationItem.title = place.name
        
        NotificationCenter.default.addObserver(self, selector: #selector(audioPlayerView.episodeLoadedNotification(_:)), name: .mediaLoadProgress, object: nil)

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        placeImage.addBlur()
    }
    
    @IBAction func playAudio(_ sender: Any) {
        if self.audioPlayer.timeControlStatus == AVPlayer.TimeControlStatus.playing{
            self.audioPlayer.pause()
        }else{
            self.audioPlayer.play()
        }
    }
//
//    private func setupAudio(with ref: DocumentReference) {
//        PlaceManager.shared.getAudioURL(with: ref) { (hardUrl, error) in
//            if error == nil, let url = hardUrl {
//                self.audioPlayer = AVPlayer(playerItem: AVPlayerItem(url: url))
//            }
//        }
//    }
}

extension UIImageView  {
    func addBlur(_ alpha: CGFloat = 0.3) {
        // create effect
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)

        // set boundry and alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha

        self.addSubview(effectView)
    }
}
