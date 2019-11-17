//
//  SearchViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController{
    var presenter: SearchPresenterProtocol!
    
    override func loadView() {
        super.loadView()
        
        self.setupUI()
        self.setupConstraints()
    }
}

extension SearchViewController{
    func setupUI(){
        self.view.backgroundColor = .white
    }
    
    func setupConstraints(){
        
    }
}

extension SearchViewController: SearchViewProtocol{
    
}
