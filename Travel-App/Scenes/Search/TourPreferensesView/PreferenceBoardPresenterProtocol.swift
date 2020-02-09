//
//  PreferenceBoardPresenterProtocol.swift
//  Travel-App
//
//  Created by Антон Иванов on 2/9/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import Foundation

protocol PreferenceBoardPresenterProtocol: class {
    init(view: PreferenceBoardViewProtocol)
    func createCustomTour(with categories: [PlaceCategory], prices: [Int], durations: [Int])
}
