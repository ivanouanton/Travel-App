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
    
    func setupImage(with category: PlaceCategory) {
        
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
