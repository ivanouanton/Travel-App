//
//  Tour.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import Foundation
import Firebase

struct Tour{
    
    let description: String
    let duration: String
    let image: DocumentReference?
    let name: String
    let place: [String: String]
    let transport: [String: String]
    
    init(_ dictionary: [String: Any]){
        self.description = dictionary["description"] as! String
        self.duration = dictionary["duration"] as! String
        self.image = dictionary["image"] as? DocumentReference
        self.name = dictionary["name"] as! String
        self.place = dictionary["place"] as! [String: String]
        self.transport = dictionary["transport"] as! [String: String]
    }
}
