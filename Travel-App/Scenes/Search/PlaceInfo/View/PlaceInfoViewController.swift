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
    
    let style = """
    <style type="text/css">
    p.p1 {margin: 0.0px 0.0px 0.0px 0.0px; font: 7.0px 'Avenir Next LT Pro'; color: #c2c0c1; min-height: 16.8px}
    p.p2 {margin: 0.0px 0.0px 0.0px 0.0px; font: 10.0px 'Avenir Next LT Pro'; color: #c2c0c1}
    p.p3 {margin: 0.0px 0.0px 0.0px 0.0px; font: 10.0px 'Avenir Next LT Pro'; color: #363739}
    p.p4 {margin: 0.0px 0.0px 0.0px 0.0px; font: 9.0px 'Avenir Next LT Pro'; color: #363739; min-height: 16.8px}
    p.p5 {margin: 0.0px 0.0px 0.0px 0.0px; font: 16.0px 'Avenir Next LT Pro'; color: #0F2B44}

    span.s1 {font-family: 'AvenirNextLTPro-Demi'; font-weight: bold; font-style: normal; font-size: 14.00px}
    span.s2 {font-family: 'AvenirNextLTPro-Regular'; font-weight: normal; line-height: 130%; font-style: normal; font-size: 14.00px}
    span.s3 {font-family: 'AvenirNextLTPro-Demi'; font-weight: bold; font-style: normal; font-size: 16.00px}
    span.italic {font-family: 'AvenirNextLTPro-Italic'; font-weight: normal; font-style: normal; font-size: 14.00px}
    </style>
    """
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView.startAnimating()
        placeImage.addBlur(0.75)
        
        guard let place = place else { return }
        
        self.setDescription(with: place.description)
       
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
    
    private func setupDefaultPage() {

        beenLAbel.isHidden = true
        beenButton.isHidden = true
        addressLabel.isHidden = true
        priceLabel.isHidden = true
        categoryLabel.isHidden = true
        titleVertSpacing.constant = -70
        title = "Rome"
    }
    
    private func setDescription(with html: String?) {
        self.descriptionLabel.text = "Description will be added soon"
        guard let html = html else { return }
        
        let prettyHtml = html.replacingOccurrences(of: "\\", with: "")

        let htmlWithTitle = prettyHtml.replacingOccurrences(of: "<style type=\"text/css\"> </style>", with: style)
        let data = Data(htmlWithTitle.utf8)
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            self.descriptionLabel.attributedText = attributedString
        }
    }
}

extension String {
    func makeHTMLfriendly() -> String {
        var finalString = ""
        for char in self {
            for scalar in String(char).unicodeScalars {
                finalString.append("&#\(scalar.value)")
            }
        }
        return finalString
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
