//
//  PlaceData.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/25/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import Foundation
import Firebase

struct PlaceData{
    
    let name: String
    let categoryId: String
    let description: String
    let audio: DocumentReference?
    let image: DocumentReference?
    let locationPlace: GeoPoint
    let price: Int
    
    init(_ dictionary: [String: Any]){
        self.name = dictionary["name"] as! String
        self.categoryId = dictionary["category"] as! String
        self.description = dictionary["description"] as! String
        self.audio = dictionary["audio"] as? DocumentReference
        self.image = dictionary["image"] as? DocumentReference
        self.locationPlace = dictionary["location"] as! GeoPoint
        self.price = dictionary["price"] as! Int
    }
}



