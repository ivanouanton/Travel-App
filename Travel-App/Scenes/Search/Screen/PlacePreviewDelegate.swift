//
//  PlacePreviewDelegate.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/1/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

protocol PlacePreviewDelegate: class {
    func getInfoPlace(with data: PlaceData, image: UIImage?, category: String)
    func createRoute()
}
