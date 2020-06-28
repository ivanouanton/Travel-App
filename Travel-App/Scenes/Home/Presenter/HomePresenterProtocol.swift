//
//  HomePresenterProtocol.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import Foundation

protocol HomePresenterProtocol: class {
    init(view: HomeViewProtocol)
    func getAttributedDescription() -> NSAttributedString
    func getAttributedMiddleDescription() -> NSAttributedString
    func getAttributedEndDescription() -> NSAttributedString
}
