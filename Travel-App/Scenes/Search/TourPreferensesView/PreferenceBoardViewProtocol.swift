//
//  PreferenceBoardViewProtocol.swift
//  Travel-App
//
//  Created by Антон Иванов on 2/9/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import Foundation

protocol PreferenceBoardViewProtocol: class {
    func showCustomTour(_ tour: Tour)
    func showErrorAlert(with message: String)
}
