//
//  TourTableViewCell.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class TourTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tourImageView: UIImageView!
    @IBOutlet weak var placesLeftLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var tour: Tour?{
        didSet{
            guard let tour = tour else { return }
            self.placesLeftLabel.text = String(tour.place.count)
            self.descriptionLabel.text = tour.description
            self.tourImageView.image = tour.image
            self.price = tour.price
        }
    }
    
    private var price: Int = 0{
        didSet{
            switch price{
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
    
    class var reuseIdentifier: String {
        return "reusableTourCell"
    }
    class var nibName: String {
        return "TourTableViewCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.descriptionLabel.sizeToFit()
        
        self.tourImageView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        
        self.layer.cornerRadius = 10
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 3.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let selectedView = UIView()
        selectedView.layer.cornerRadius = 10
        selectedView.layer.backgroundColor = UIColor(named: "silver")?.withAlphaComponent(0.2).cgColor
        selectedBackgroundView = selectedView
        
    }
}

extension UIView {
func roundCorners(corners:UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
}
}
