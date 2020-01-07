//
//  RecentPlaceCollectionViewCell.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/13/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class RecentPlaceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var titlePlaceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var place: PlaceCardModel? {
        didSet {
            guard let place = place else {return}
            placeImage.image = place.image
            titlePlaceLabel.text = place.name
            categoryLabel.text = place.category
            switch place.price {
            case 0:
                self.priceLabel.text = "Free"
            case 1:
                self.priceLabel.text = "€"
            case 2:
                self.priceLabel.text = "€€"
            default:
                break
            }
        }
    }
    
    
    func setupRecentPlaceCell(with image: UIImage){
        self.placeImage.image = image
    }
    
    class var reuseIdentifier: String {
        return "RecentPlaceCollectionViewCell"
    }
    class var nibName: String {
        return "RecentPlaceCollectionViewCell"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        self.placeImage.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}



