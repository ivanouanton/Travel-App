//
//  ToursPresenter.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import FirebaseStorage
import FirebaseFirestore
import UIKit

class ToursPresenter{
    weak var view: ToursViewProtocol?
    
    var filter: [Int:Int]?
    
    required init(view: ToursViewProtocol) {
        self.view = view
    }
}

extension ToursPresenter: ToursPresenterProtocol{
    func getTours(){
        ToursManager.shared.getTours(filter ?? [:]) { (tours, error) in
            if let tours = tours{
                self.view?.updateContent(with: tours)
            }
        }
    }
}
