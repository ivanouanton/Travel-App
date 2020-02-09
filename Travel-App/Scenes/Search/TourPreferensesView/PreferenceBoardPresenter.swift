//
//  PreferenceBoardPresenter.swift
//  Travel-App
//
//  Created by Антон Иванов on 2/9/20.
//  Copyright © 2020 companyName. All rights reserved.
//


class PreferenceBoardPresenter: PreferenceBoardPresenterProtocol {
    
    weak var view: PreferenceBoardViewProtocol!

    required init(view: PreferenceBoardViewProtocol) {
        self.view = view
    }
    
    func createCustomTour(with categories: [PlaceCategory], options: [Int : [Int]]) {
        print("Hello")
        
    }
}
