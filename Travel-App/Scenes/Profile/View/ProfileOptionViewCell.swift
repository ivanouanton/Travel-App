//
//  ProfileOptionViewCell.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/13/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class ProfileOptionViewCell: UITableViewCell {
    
    @IBOutlet weak var keyInfo: UILabel!
    @IBOutlet weak var valueInfo: UILabel!
    
    func setupOption(with key: String, value: String){
        
        self.keyInfo.text = key
        self.valueInfo.text = value
    }
    
    class var reuseIdentifier: String {
        return "ProfileOptionViewCell"
    }
    class var nibName: String {
        return "ProfileOptionViewCell"
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
