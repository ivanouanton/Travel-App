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
    @IBOutlet weak var beenButton: UIButton!
    
    var presenter: PlaceInfoPresenterProtocol?
    
    var place: Place?
    var category: String = ""
    var image: UIImage = UIImage(named: "preview-target-place")!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let place = place else {return}
        self.titleDescriptionLabel.text = place.name
        self.descriptionLabel.text = place.description
        self.addressLabel.text = place.address ?? "no address"
        
        // TODO - need refactor
        if let ref = place.image {
            ToursManager.shared.getImage(with: ref) { (image, error) in
                if let image = image {
                    self.placeImage.image = image
                } else {
                    self.placeImage.image = self.image
                }
            }
        }
        
        self.categoryLabel.text = place.category.getName()

        if let audioReference = place.audio {
            audioPlayerView.setupAudio(with: audioReference)
        } else {
            audioPlayerView.isHidden = true
        }
        
        placeImage.addBlur()
        presenter?.checkVisit(place)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let place = place else {return}
        self.navigationItem.title = place.name
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        audioPlayerView.stopPlaing()
    }

    
    @IBAction func didPressedBeenThere(_ sender: Any) {
        presenter?.didPressedIsVisited()
    }
}

extension PlaceInfoViewController: PlaceInfoViewProtocol {
    func showDefaultAlert(with message: String) {
        self.showAlert(message, completion: nil)
    }
    
    func setBeenStatus(with value: Bool) {
        self.beenButton.imageView?.image = value ? UIImage(named: "successful") : UIImage(named: "ok-circle")
    }
}
