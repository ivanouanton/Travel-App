//
//  HomeViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController{
    var presenter: HomePresenterProtocol!
    
    override func loadView() {
        super.loadView()
        
        self.setupUI()
        self.setupConstraints()
    }
}

extension HomeViewController{
    func setupUI(){
        self.view.backgroundColor = .white
    }
    
    func setupConstraints(){
        
    }
}

extension HomeViewController: HomeViewProtocol{
    
}
