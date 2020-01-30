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
        self.contentView.backgroundColor = isSelected ? self.mainBackColor : self.mainBackColor?.withAlphaComponent(0.4)
    }
    
    func configure(with category: PlaceCategory) {
        self.title.text = category.getName()
        self.imageView.image = category.getImage()
        self.mainBackColor = category.getColor()
        self.contentView.backgroundColor = isSelected ? self.mainBackColor : self.mainBackColor?.withAlphaComponent(0.4)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.isSelected = false
    }
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? self.mainBackColor : self.mainBackColor?.withAlphaComponent(0.4)
        }
    }
    

}
