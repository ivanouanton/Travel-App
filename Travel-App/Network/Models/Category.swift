//
//  Category.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/25/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import Foundation
import Firebase

struct Category{
    
    let id: Int
    let title: String
    let img: DocumentReference
    
    init(_ dictionary: [String: Any]){
        self.id = dictionary["id_category"] as! Int
        self.title = dictionary["name_category"] as! String
        self.img = dictionary["img_categoty"] as! DocumentReference
    }
}
