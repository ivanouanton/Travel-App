//
//  ToursPresenterProtocol.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

protocol ToursPresenterProtocol: class {
    init(view: ToursViewProtocol)
    func getTours()
}
