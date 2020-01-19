//
//  HomeViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 1/19/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var presenter: HomePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension HomeViewController: HomeViewProtocol{
    
}
