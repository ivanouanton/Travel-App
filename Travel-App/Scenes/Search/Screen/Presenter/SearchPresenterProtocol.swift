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
    func showModalView(with id: String)
    func filter(with category: PlaceCategory?)
    func getRoute(with locations: [GeoPoint])
    func getTourRoute(with tour: Tour)
    func getPlaces(with option: OptionFilterSelection?)
    func viewDidLoad()
    func deselect(with: OptionFilterSelection)
    func showAllMarkers()
}
