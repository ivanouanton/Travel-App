//
//  PlaceCardModel.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/29/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit
import Firebase

struct PlaceCardModel {
    var id: String
    var name: String
    var category: String
    var price: Int
    var image: UIImage?
    var location: GeoPoint?
    var placeName: String?
    var description: String
    var audio: DocumentReference?
    var isVisited: Bool = false
}
