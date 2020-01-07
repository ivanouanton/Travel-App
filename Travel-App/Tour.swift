//
//  Tour.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit
import Firebase

struct Tour{
    let description: String
    let duration: String
    let imageRef: DocumentReference?
    let name: String
    let place: [String]
    let transport: [String]
    let price: Int
    var image: UIImage?
    
    init(_ dictionary: [String: Any]){
        self.description = dictionary["description"] as! String
        self.duration = dictionary["duration"] as! String
        self.imageRef = dictionary["image"] as? DocumentReference
        self.name = dictionary["name"] as! String
        self.place = dictionary["place"] as! [String]
        self.transport = dictionary["transport"] as! [String]
        self.price = dictionary["price"] as! Int
        self.image = nil
    }
}
