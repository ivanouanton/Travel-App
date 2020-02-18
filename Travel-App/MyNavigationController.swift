//
//  MyNavigationController.swift
//  Travel-App
//
//  Created by Антон Иванов on 2/14/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.backIndicatorImage = UIImage(named: "left-arrow")
        navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "left-arrow")
        navigationBar.tintColor = UIColor(named: "white")

        self.delegate = self
    }

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}
