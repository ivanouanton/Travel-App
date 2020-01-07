//
//  UserProfile.swift
//  Travel-App
//
//  Created by Антон Иванов on 1/7/20.
//  Copyright © 2020 companyName. All rights reserved.
//

struct UserProfile{
    let email: String
    let name: String
    let surname: String
    let uid: String
    let address: String?
    let places: [String]?
    
    init(_ dictionary: [String: Any]){
        self.email = dictionary["email"] as! String
        self.name = dictionary["name"] as! String
        self.surname = dictionary["surname"] as! String
        self.uid = dictionary["uid"] as! String
        self.address = dictionary["address"] as? String
        self.places = dictionary["places"] as? [String]
    }
}
