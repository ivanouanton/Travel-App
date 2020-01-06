//
//  SplashScreenViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 1/6/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    lazy var presenter = SplashScreenPresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter.checkAuth()
    }
}
