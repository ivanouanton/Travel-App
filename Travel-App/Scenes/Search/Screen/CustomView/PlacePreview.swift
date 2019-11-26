//
//  PlacePreview.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/19/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class PlacePreview: UIView {
    
    var place: PlaceData? {
        didSet{
            guard let place = place else {return}
            self.titleLabel.text = place.name
        }
    }
    
    private lazy var placeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "preview-target-place")
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
        label.font = UIFont(name: "AvenirNextLTPro-Demi", size: 16.0)
        label.textColor = UIColor(named: "heavy")
        return label
    }()
    
    private lazy var directionsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Directions", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Demi", size: 14)
        button.setTitleColor(UIColor(named: "pantone"), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = UIColor(named: "pantone")?.withAlphaComponent(0.2).cgColor
        return button
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Info", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Demi", size: 14)
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
        label.font = UIFont(name: "AvenirNextLTPro-Regular", size: 14)
        label.textColor = UIColor(named: "silver")
        return label
    }()
    
    private lazy var placeTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cafe"
        label.font = UIFont(name: "AvenirNextLTPro-Regular", size: 14)
        label.textColor = UIColor(named: "onyx")
        return label
    }()
    
    private lazy var dot: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 4).isActive = true
        view.widthAnchor.constraint(equalToConstant: 4).isActive = true
        view.layer.cornerRadius = 2
        view.layer.backgroundColor =  UIColor(named: "heavy")?.cgColor
        return view
    }()
    
    private lazy var placePrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "££"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNextLTPro-Regular", size: 14)
        label.textColor = UIColor(named: "silver")
        return label
    }()
    
    private lazy var placeMarks: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 5
        stack.addArrangedSubview(self.placeTitle)
        stack.addArrangedSubview(self.dot)
        stack.addArrangedSubview(self.placePrice)
        return stack
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
        self.addSubview(self.placeMarks)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.placeImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.placeImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.placeImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.placeImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            self.titleLabel.leftAnchor.constraint(equalTo: self.placeImage.rightAnchor, constant: 8),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            self.placeMarks.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 7),
            self.placeMarks.leftAnchor.constraint(equalTo: self.placeImage.rightAnchor, constant: 8),

            self.directionsButton.bottomAnchor.constraint(equalTo: self.placeImage.bottomAnchor, constant: -3),
            self.directionsButton.leftAnchor.constraint(equalTo: self.placeImage.rightAnchor, constant: 8),
            self.directionsButton.heightAnchor.constraint(equalToConstant: 35),
            self.directionsButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.33),
            
            self.infoButton.bottomAnchor.constraint(equalTo: self.placeImage.bottomAnchor, constant: -3),
            self.infoButton.leftAnchor.constraint(equalTo: self.directionsButton.rightAnchor, constant: 12),
            self.infoButton.heightAnchor.constraint(equalToConstant: 35),
            self.infoButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            self.userLocationLabel.bottomAnchor.constraint(equalTo: self.infoButton.topAnchor, constant: -8),
            self.userLocationLabel.leftAnchor.constraint(equalTo: self.placeImage.rightAnchor, constant: 8),
            self.userLocationLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            ])
    }
}
