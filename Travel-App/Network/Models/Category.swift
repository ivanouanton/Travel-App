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
    
//    let transport: [String: String]
    let title: String
    let img: DocumentReference
    
    init(_ dictionary: [String: Any]){
//        self.transport = dictionary["transport"] as! [String: String]
        self.title = dictionary["title"] as! String
        self.img = dictionary["img_marker"] as! DocumentReference
    }
}
