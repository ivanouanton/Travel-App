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
    }
}
