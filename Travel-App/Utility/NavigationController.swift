//
//  NavigationController.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/8/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.backIndicatorImage = UIImage(named: "left-arrow")
        self.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "left-arrow")
        self.navigationBar.tintColor = UIColor(named: "pantone")
        self.navigationBar.backItem?.title = "Anything Else"
        
        self.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor(named: "pantone")!,
         NSAttributedString.Key.font: UIFont(name: "AvenirNextLTPro-Demi", size: 16)!]
        
        self.navigationBar.layer.shadowColor = UIColor.gray.cgColor
        self.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationBar.layer.shadowRadius = 4.0
        self.navigationBar.layer.shadowOpacity = 0.3
        self.navigationBar.layer.masksToBounds = false
    }
}
