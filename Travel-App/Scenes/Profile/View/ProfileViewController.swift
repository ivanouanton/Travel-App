//
//  ProfileViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController{
    var presenter: ProfilePresenterProtocol!
    
    override func loadView() {
        super.loadView()
        
        self.setupUI()
        self.setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProfileViewController{
    func setupUI(){
        self.view.backgroundColor = .white
    }
    
    func setupConstraints(){
        
    }
}

extension ProfileViewController: ProfileViewProtocol{
    
}

