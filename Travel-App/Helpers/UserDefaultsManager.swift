//
//  UserDefaultsManager.swift
//  Travel-App
//
//  Created by Anton Ivanov on 1/6/20.
//  Copyright © 2020 Anton Ivanov. All rights reserved.
//

import Foundation

class UserDefaultsService {
    
    static let shared = UserDefaultsService()
    
    private init() {
    }
    
    enum UserDefaultsField: String{
        case uid = "com.TravelApp.uid"
        case isLoggedIn = "com.TravelApp.isLoggedIn"
        case isOnBoardShowed = "com.TravelApp.isOnBoardShowed"
    }
    
    func saveData<T>(_ data: T, keyValue: UserDefaultsField){
        UserDefaults.standard.set(data, forKey: keyValue.rawValue)
    }
    
    func getData(for keyValue: UserDefaultsField) -> Any?{
        return UserDefaults.standard.value(forKey: keyValue.rawValue)
    }

    func clearData(for keyValue: UserDefaultsField){
        UserDefaults.standard.removeObject(forKey: keyValue.rawValue)
    }
}
