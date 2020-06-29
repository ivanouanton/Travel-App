//
//  PlaceData.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/25/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import Foundation
import Firebase
import UIKit

struct Place{
    var id: String?
    let name: String
    let category: PlaceCategory
    let description: NSAttributedString?
    let audio: DocumentReference?
    let image: DocumentReference?
    let locationPlace: GeoPoint
    let address: String?
    let price: Int
    var isVisited: Bool = false
    var loadImage: UIImage?
    
    init(_ dictionary: [String: Any]){
        self.id = nil
        self.name = dictionary["name"] as! String
        self.category = PlaceCategory( dictionary["category"] as! String)!
        let jsonStr = (dictionary["description"] as? String) ?? ""
        let description = try? JSONDecoder().decode(RestaurantDescription.self, from: jsonStr.data(using: .utf8)!)
        self.description = description?.getAttributedString()
        
        self.audio = dictionary["audio"] as? DocumentReference
        self.image = dictionary["image"] as? DocumentReference
        self.locationPlace = dictionary["location"] as! GeoPoint
        self.address = dictionary["address"] as? String
        self.price = dictionary["price"] as! Int
    }
}



