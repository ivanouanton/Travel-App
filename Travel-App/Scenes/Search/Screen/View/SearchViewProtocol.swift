//
//  SearchViewProtocol.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import CoreLocation
import UIKit

protocol SearchViewProtocol: class{
    func didChangeMyLocation(_ location: Location)
    func addMarker(_ id: String, place: PlaceData, markerImg: UIImage?, isActive: Bool)
    func showModal(with data: PlaceData, image: UIImage?, category: String)
    func setFilter(with categories: [String])
    func clearMarkers()
    func drawPath(with routes: String?)
    func setupTourInfo(with places: [String], title: String)
    func setPlacesCollection(with places: [PlaceCardModel])
    func showPlaceView(with index: Int)
}
