//
//  RecentPlacesTableViewCell.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/13/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class RecentPlacesTableViewCell: UITableViewCell {
    
    class var reuseIdentifier: String {
        return "RecentPlacesTableViewCell"
    }
    class var nibName: String {
        return "RecentPlacesTableViewCell"
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
