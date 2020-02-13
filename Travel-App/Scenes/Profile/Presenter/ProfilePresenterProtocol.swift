//
//  ProfilePresenterProtocol.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

protocol ProfilePresenterProtocol: class {
    init(view: ProfileViewProtocol)
    func getUserData()
    func checkRecentPlaces()
}
