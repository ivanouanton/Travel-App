//
//  OptionFilterTableViewCell.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class OptionFilterTableViewCell: UITableViewCell {

    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var topLine: UIView!
    
    override var isSelected: Bool{
        didSet{
            self.optionLabel.font = isSelected ? UIFont(name: "AvenirNextLTPro-Demi", size: 14.0) : UIFont(name: "AvenirNextLTPro-Regular", size: 14.0)
        }
    }
    
    func setupLabel(with text: String){
        self.optionLabel.text = text
    }
    
    func setupAsFirstRow(){
        self.topLine.isHidden = true    
    }
    
    class var reuseIdentifier: String {
        return "optionCell"
    }
    class var nibName: String {
        return "OptionFilterTableViewCell"
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
