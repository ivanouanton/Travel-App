//
//  Loader.swift
//  Travel-App
//
//  Created by Антон Иванов on 1/10/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit
import Lottie

class Loader: UIView {
    
    private let animationView = AnimationView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        self.animationView.animation = Animation.named("circleLoader")
        self.animationView.contentMode = .scaleAspectFit
        self.animationView.loopMode = .loop
        self.animationView.play()
        
        self.addSubview(self.animationView)
        
        self.animationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.animationView.widthAnchor.constraint(equalToConstant: 80),
            self.animationView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
