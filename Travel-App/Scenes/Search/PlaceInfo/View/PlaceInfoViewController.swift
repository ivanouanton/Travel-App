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
        
        guard let place = place else { return }
        
        self.titleDescriptionLabel.text = place.name
        self.descriptionLabel.attributedText = place.description
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

        self.audioPlayerView.delegate = self
        
        if let audioReference = place.audio {
            audioPlayerView.setupAudio(with: audioReference)
            placeImage.addBlur()
        } else {
            audioPlayerView.isHidden = true
        }
        
        presenter?.checkVisit(place)
        
        if place.category == .introduction {
            setupDefaultPage()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let place = place else {return}
        self.navigationItem.title = place.category == .introduction ? "Rome" : place.name
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        audioPlayerView.stopPlaing()
    }

    @IBAction func didPressedBeenThere(_ sender: Any) {
        presenter?.didPressedIsVisited()
    }
    
    func setupDefaultPage() {

        beenLAbel.isHidden = true
        beenButton.isHidden = true
        addressLabel.isHidden = true
        priceLabel.isHidden = true
        categoryLabel.isHidden = true
        titleVertSpacing.constant = -70
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

extension PlaceInfoViewController: AudioPlayerDelegate {
    
    func playerDidFinished() {
        guard let place = self.place else { return }
        if !place.isVisited {
            self.presenter?.didPressedIsVisited()
            self.place?.isVisited = true
        }
        
        PlaceManager.shared.getPlaces(with: nil) { (_, _) in }
    }
}
