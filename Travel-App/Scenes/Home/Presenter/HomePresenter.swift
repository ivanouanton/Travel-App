//
//  HomePresenter.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

class HomePresenter: HomePresenterProtocol{
    weak var view: HomeViewProtocol!
    
    required init(view: HomeViewProtocol) {
        self.view = view
    }
}
