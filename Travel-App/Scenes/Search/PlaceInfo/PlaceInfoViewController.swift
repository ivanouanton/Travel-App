//
//  PlaceInfoViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/1/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class PlaceInfoViewController: UIViewController {

    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var titleDescriptionLabel: UILabel!
    @IBOutlet weak var subTitleDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var place: PlaceCardModel?
    var category: String = ""
    var image: UIImage = UIImage(named: "preview-target-place")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let place = place else {return}
        self.titleDescriptionLabel.text = place.name
        self.descriptionLabel.text = place.description
        self.placeImage.image = place.image
        self.categoryLabel.text = place.category
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let place = place else {return}
        self.navigationItem.title = place.name
    }
}
