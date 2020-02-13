//
//  PlaceInfoViewProtocol.swift
//  Travel-App
//
//  Created by Anton Ivanov on 2/13/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import Foundation

protocol PlaceInfoViewProtocol: class {
    func setBeenStatus(with value: Bool)
    func showDefaultAlert(with message: String)
}
