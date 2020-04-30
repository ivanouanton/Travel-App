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
    @IBOutlet weak var beenLAbel: UILabel!
    
    @IBOutlet weak var introductionLabel: UILabel!
    
    @IBOutlet weak var titleVertSpacing: NSLayoutConstraint!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var presenter: PlaceInfoPresenterProtocol?
    
    var place: Place?
    var category: String = ""
    var image: UIImage = UIImage(named: "City-Introduction")!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView.startAnimating()
        placeImage.addBlur(0.75)
        
        guard let place = place else {
            setupDefaultPage()
            return
        }
        
        self.titleDescriptionLabel.text = place.name
        self.descriptionLabel.text = place.description
        self.addressLabel.text = place.address ?? "no address"
        
        // TODO - need refactor
        if let ref = place.image {
            TAImageClient.getImage(with: ref) { (image, error) in
                if let image = image {
                    self.placeImage.image = image
                } else {
                    self.placeImage.image = self.image
                }
                self.activityIndicatorView.stopAnimating()
                self.placeImage.removeBlur()
            }
        }
        
        self.categoryLabel.text = place.category.getName()

        if let audioReference = place.audio {
            audioPlayerView.setupAudio(with: audioReference)
        } else {
            audioPlayerView.isHidden = true
        }
        
//        placeImage.addBlur()
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
    
    func setupDefaultPage() {
        audioPlayerView.isHidden = true
        beenLAbel.isHidden = true
        beenButton.isHidden = true
        introductionLabel.isHidden = false
        addressLabel.isHidden = true
        priceLabel.isHidden = true
        categoryLabel.isHidden = true
        titleVertSpacing.constant = -30
        title = "Rome"
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
