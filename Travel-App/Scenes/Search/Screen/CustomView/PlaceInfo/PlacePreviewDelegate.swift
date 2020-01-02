//
//  PlacePreviewDelegate.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/1/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit
import Firebase

protocol PlacePreviewDelegate: class {
    func getInfoPlace(with data: PlaceCardModel, image: UIImage?, category: String)
    func createRoute(with location: GeoPoint)
    func didSelect(with place: PlaceCardModel)
}
