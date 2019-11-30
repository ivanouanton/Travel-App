//
//  CategoryFilterCell.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/30/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class CategoryFilterCell: UICollectionViewCell {
    
    var title: String = ""{
        didSet{
            self.titleLabel.text = " " + title + " "
        }
    }
    
    private lazy var titleLabel: Label = {
        let label = Label()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont(name: "AvenirNextLTPro-Regular", size: 14.0)
        label.textColor = UIColor(named: "heavy")
        return label
    }()

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let autoLayoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)

        let targetSize = CGSize(width: 0, height: layoutAttributes.frame.width)

        let autoLayoutSize = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .defaultLow, verticalFittingPriority: .required)
        let autoLayoutFrame = CGRect(origin: autoLayoutAttributes.frame.origin, size: autoLayoutSize)

        autoLayoutAttributes.frame = autoLayoutFrame
        return autoLayoutAttributes
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.contentView.heightAnchor.constraint(equalToConstant: 32),
            self.contentView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.contentView.rightAnchor.constraint(equalTo: self.rightAnchor),

            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func showIndicator(){
        self.titleLabel.layer.addBorder(edge: .bottom, color: UIColor(named: "smokyTopaz")!, thickness: 2)
    }
    
    func removeIndicator(){
        self.titleLabel.layer.sublayers?.removeAll()
    }
}
