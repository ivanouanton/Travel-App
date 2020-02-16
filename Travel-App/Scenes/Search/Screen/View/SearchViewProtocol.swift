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
    func addMarker(_ id: String, place: Place, markerImg: UIImage?, isActive: Bool)
    func setFilter(with categories: [String])
    func clearMarkers()
    func drawPath(with routes: String?)
    func setupTourInfo(with places: [String], title: String)
    func setPlacesCollection(with places: [PlaceCardModel])
    func showPreviewPlaces(with places: [Place])
    func showPlaceView(with index: Int)
    func showLocality(locality: String)
    func showLoader(_ isNeededShowing: Bool)
}
