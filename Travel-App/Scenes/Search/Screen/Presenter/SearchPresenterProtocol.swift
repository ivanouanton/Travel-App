//
//  SearchPresenterProtocol.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import Firebase

protocol SearchPresenterProtocol: class {
    init(view: SearchViewProtocol)
    
    func fetchUserLocation()
    func getPlaces()
    func showModalView(with id: String)
    func filterPlaces(with index: Int)
    func getRoute(with location: GeoPoint)
}
