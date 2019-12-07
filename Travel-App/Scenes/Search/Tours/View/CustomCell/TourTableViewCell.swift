//
//  TourTableViewCell.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class TourTableViewCell: UITableViewCell {
    
    class var reuseIdentifier: String {
        return "reusableTourCell"
    }
    class var nibName: String {
        return "TourTableViewCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
