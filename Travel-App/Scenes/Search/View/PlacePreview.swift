//
//  PlacePreview.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/19/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class PlacePreview: UIView {
    
    private lazy var placeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "place")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.setupConstraints()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI(){
        self.layer.cornerRadius = 7
        
        self.addSubview(self.placeImage)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.placeImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.placeImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.placeImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.placeImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35),
            
            
            ])
    }
}
