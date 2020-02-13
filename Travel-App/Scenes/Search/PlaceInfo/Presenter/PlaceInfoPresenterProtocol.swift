//
//  PlaceInfoPresenterProtocol.swift
//  Travel-App
//
//  Created by Anton Ivanov on 2/13/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import Foundation

protocol PlaceInfoPresenterProtocol: class {
    init(view: PlaceInfoViewProtocol)
    func checkVisit(_ place: PlaceCardModel)
    func didPressedIsVisited()
}
