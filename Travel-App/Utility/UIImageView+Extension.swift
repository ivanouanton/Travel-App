//
//  UIImageView+Extension.swift
//  Travel-App
//
//  Created by Anton Ivanov on 2/14/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit

extension UIImageView  {
    func addBlur(_ alpha: CGFloat = 0.5) {
        // create effect
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)

        // set boundry and alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha
        effectView.tag = 1205
        
        self.addSubview(effectView)
    }
    
    func removeBlur() {
        for subview in self.subviews {
            if subview.tag == 1205 {
                subview.removeFromSuperview()
                break
            }
        }
    }
}
