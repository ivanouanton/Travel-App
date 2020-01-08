//
//  SettingTableViewCell.swift
//  Travel-App
//
//  Created by Антон Иванов on 1/8/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var cellIndicator: UIImageView!
    
    var title = ""{
        didSet {
            titleLabel.text = title
        }
    }
    
    var value: String?{
        didSet {
            guard let value = value else {return}
            valueLabel.text = value
            cellIndicator.isHidden = true
        }
    }

    class var reuseIdentifier: String {
        return "SettingTableViewCell"
    }
    class var nibName: String {
        return "SettingTableViewCell"
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
