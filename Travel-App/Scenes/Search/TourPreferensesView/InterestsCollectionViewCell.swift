//
//  InterestsCollectionViewCell.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/3/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class InterestsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    private var mainBackColor: UIColor?{
        didSet{
            self.contentView.backgroundColor = mainBackColor?.withAlphaComponent(0.4)
        }
    }

    class var reuseIdentifier: String {
        return "interstCell"
    }
    class var nibName: String {
        return "InterestsCollectionViewCell"
    }
    
    func configureCell(name: String, image: UIImage, color: UIColor) {
        self.title.text = name
        self.imageView.image = image
        self.mainBackColor = color
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print(self.frame)
    }
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? self.mainBackColor : self.mainBackColor?.withAlphaComponent(0.4)
        }
    }
    

}
