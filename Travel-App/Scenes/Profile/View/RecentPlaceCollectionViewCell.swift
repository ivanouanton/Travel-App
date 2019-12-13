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



