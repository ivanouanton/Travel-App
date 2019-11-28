//
//  SearchViewProtocol.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import CoreLocation
import UIKit

protocol SearchViewProtocol: class{
    func didChangeMyLocation(_ location: Location)
    func addPlace(_ id: String, place: PlaceData)
    func showModal(with data: PlaceData, image: UIImage?)
}
