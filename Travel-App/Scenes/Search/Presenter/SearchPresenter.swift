//
//  SearchPresenter.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

class SearchPresenter: SearchPresenterProtocol{
    weak var view: SearchViewProtocol!
    
    required init(view: SearchViewProtocol) {
        self.view = view
    }
}
