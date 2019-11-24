//
//  SearchViewProtocol.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import CoreLocation

protocol SearchViewProtocol: class{
    func didChangeMyLocation(_ location: Location)
}
