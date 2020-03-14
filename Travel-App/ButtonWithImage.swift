//
//  ButtonWithImage.swift
//  Travel-App
//
//  Created by Антон Иванов on 3/14/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit

class ButtonWithImage: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5,
                                           left: (bounds.width - 35),
                                           bottom: 5,
                                           right: 5)
            
            titleEdgeInsets = UIEdgeInsets(top: 0,
                                           left: 24,
                                           bottom: 0,
                                           right: (imageView?.frame.width)!)
        }
        
    }
    
}
