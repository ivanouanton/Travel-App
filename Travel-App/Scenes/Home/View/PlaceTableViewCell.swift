//
//  PlaceTableViewCell.swift
//  Travel-App
//
//  Created by Антон Иванов on 1/28/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    class var reuseIdentifier: String {
        return "PlaceTableViewCell"
    }
    class var nibName: String {
        return "PlaceTableViewCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
