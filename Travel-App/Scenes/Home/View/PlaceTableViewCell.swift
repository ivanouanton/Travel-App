//
//  PlaceTableViewCell.swift
//  Travel-App
//
//  Created by Антон Иванов on 1/28/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryBgView: UIView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var idTitleLabel: UILabel!
    
    func setupCategoryView(with category: PlaceCategory) {
        categoryBgView.backgroundColor = category.getColor()
        categoryImage.image = category.getImage()
    }
    
    class var reuseIdentifier: String {
        return "PlaceTableViewCell"
    }
    class var nibName: String {
        return "PlaceTableViewCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
