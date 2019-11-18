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
        image.backgroundColor = .red
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Marlow & Sons"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir", size: 16)!
   
        label.textColor = UIColor(named: "heavy")
        return label
    }()
    
    private lazy var directionsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Directions", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 14)!
        button.setTitleColor(UIColor(named: "pantone"), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = UIColor(named: "pantone")?.withAlphaComponent(0.2).cgColor
        return button
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Info", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 14)!
        button.setTitleColor(UIColor(named: "pantone"), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = UIColor(named: "pantone")?.withAlphaComponent(0.2).cgColor
        return button
    }()
    
    private lazy var userLocationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = """
        81 Broadway
        Brooklyn, NY 11249
        """
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir", size: 14)!
        label.textColor = UIColor(named: "silver")
        return label
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
        self.addSubview(self.titleLabel)
        self.addSubview(self.directionsButton)
        self.addSubview(self.infoButton)
        self.addSubview(self.userLocationLabel)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.placeImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.placeImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.placeImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.placeImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.titleLabel.leftAnchor.constraint(equalTo: self.placeImage.rightAnchor, constant: 8),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            self.directionsButton.bottomAnchor.constraint(equalTo: self.placeImage.bottomAnchor),
            self.directionsButton.leftAnchor.constraint(equalTo: self.placeImage.rightAnchor, constant: 8),
            self.directionsButton.heightAnchor.constraint(equalToConstant: 35),
            self.directionsButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.33),
            
            self.infoButton.bottomAnchor.constraint(equalTo: self.placeImage.bottomAnchor),
            self.infoButton.leftAnchor.constraint(equalTo: self.directionsButton.rightAnchor, constant: 12),
            self.infoButton.heightAnchor.constraint(equalToConstant: 35),
            self.infoButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            self.userLocationLabel.bottomAnchor.constraint(equalTo: self.infoButton.topAnchor, constant: -8),
            self.userLocationLabel.leftAnchor.constraint(equalTo: self.placeImage.rightAnchor, constant: 8),
            self.userLocationLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            ])
    }
}
