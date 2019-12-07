//
//  TourHederView.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/8/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class TourHederView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNextLTPro-Demi", size: 16.0)
        label.textColor = UIColor(named: "heavy")
        return label
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNextLTPro-Demi", size: 14)
        label.textColor = UIColor(named: "silver")
        return label
    }()
    
    func setupView(with title: String, duration: String){
        self.titleLabel.text = title
        self.durationLabel.text = duration
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.durationLabel)
        
        NSLayoutConstraint.activate([
            self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            
            self.durationLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            self.durationLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.durationLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
        
    }

}
