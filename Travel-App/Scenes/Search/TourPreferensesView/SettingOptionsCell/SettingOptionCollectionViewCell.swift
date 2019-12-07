//
//  SettingOptionCollectionViewCell.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/5/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class SettingOptionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    private var mainBackColor: UIColor = UIColor(named: "pantone")!
    private var activeImage: UIImage?{
        didSet{
            guard let image = activeImage else {return}
            self.imageView.image = image
        }
    }
    private var deactiveImage: UIImage?

    class var reuseIdentifier: String {
        return "optionCell"
    }
    class var nibName: String {
        return "SettingOptionCollectionViewCell"
    }
    
    func configureCell(text: String?, actImage: UIImage?, defImage: UIImage?) {
        self.title.text = text
        self.activeImage = actImage
        self.deactiveImage = defImage
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = self.mainBackColor.withAlphaComponent(0.2)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.contentView.backgroundColor = self.mainBackColor
                self.title.textColor = UIColor(named: "white")!
            }else{
                self.contentView.backgroundColor = self.mainBackColor.withAlphaComponent(0.2)
                self.title.textColor = self.mainBackColor
            }
//            self.contentView.backgroundColor = isSelected ? self.mainBackColor.withAlphaComponent(0.2) : self.mainBackColor
//            self.title.textColor = isSelected ? UIColor(named: "white")! : self.mainBackColor
        }
    }

}
