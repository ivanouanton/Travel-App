//
//  SearchPresenter.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class SearchPresenter{
    
    var userLocation = GeoPoint(latitude: Defaults.location.latitude,
                            longitude: Defaults.location.longitude)
    
    var places = [Place]() {
        didSet {
            self.view.showPreviewPlaces(with: places)
        }
    }

    var placesCard = [PlaceCardModel]()

    weak var view: SearchViewProtocol!
    let locationManager: LocationManager
    
    required init(view: SearchViewProtocol) {
        self.view = view
        self.locationManager = LocationManager()
    }
    
    private func showAllMarkers(){
        self.view.clearMarkers()
        for place in self.places {
            self.view.addMarker(place.id!,
                                place: place,
                                isActive: true)
        }
    }
}

extension SearchPresenter: SearchPresenterProtocol{

    func viewDidLoad() {
        
        self.getPlaces(with: nil)
        self.view.setFilter(with: PlaceCategory.categories)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reviewPlaces),
                                               name: Notification.Name.didChangeVisitedState,
                                               object: nil)
    }
    
    @objc func reviewPlaces() {
        var placesModelData = Array<Place>()
        for place in self.places {
            var newPlace = place
            newPlace.isVisited = FirebaseProfileManager.shared.placesId.contains(place.id!)
            placesModelData.append(newPlace)
        }
        places = placesModelData
    }
    
    func getPlaces(with option: OptionFilterSelection?) {
        self.view.showLoader(true)
        FirebaseProfileManager.shared.getAuthUserData { (user, image, error) in
            PlaceManager.shared.getPlaces(with: option) { (places, error) in
                self.places = places ?? []
                self.reviewPlaces()
                self.showAllMarkers()
                self.view.showPreviewPlaces(with: self.places)
                self.downloadAllImages()
                self.view.showLoader(false)
            }
        }
    }
    
    func downloadAllImages() {
        
        let concurrentTasks = 10
        
        let queue = DispatchQueue(label: "queuename", attributes: .concurrent)
        let sema = DispatchSemaphore(value: concurrentTasks)
        
            for (ind, place) in self.places.enumerated() {
                if let ref = place.image {
                    queue.async {
                        TAImageClient.getImage(with: ref) { [weak self] (image, error) in
                            defer{ sema.signal() }
                            
                            guard let self = self else { return }
                            guard let image = image else {
                                print(error?.localizedDescription ?? "Error")
                                return
                            }
                            self.places[ind].loadImage = image
                            self.view.showPreviewPlaces(with: self.places)
                        }
                        sema.wait()
                    }
                }
                
            }
    }
    
    func deselect(with: OptionFilterSelection) {
        self.getPlaces(with: nil)
    }
    
    func getTourRoute(with tour: Tour) {
        let placesId = tour.place
        var places = [GeoPoint]()
        var placeNames = [String]()
        let aGroup = DispatchGroup()
        
        for placeId in placesId{
            aGroup.enter()
            PlaceManager.shared.getPlace(with: placeId) { (place, error) in
                if let place = place {
                    places.append(place.locationPlace)
                    placeNames.append(place.name)
                    aGroup.leave()
                }
            }
        }
        
        aGroup.notify(queue: DispatchQueue.main){
            
            self.getRoute(with: places.reversed())
            self.view.setupTourInfo(with: placeNames, title: tour.name)
        }
    }
    
    func getRoute(with locations: [GeoPoint]) {
        let places = [self.userLocation] + locations
        PlaceManager.shared.getRoute(with: places, completionHandler: { (routes, error) in
            if let routes = routes{
                self.view.drawPath(with: routes)
            }
        })
    }
    
    func filter(with category: PlaceCategory?) {
        guard let category = category else {
            self.showAllMarkers()
            return
        }
        
        self.view.clearMarkers()
        self.places.forEach { (place) in
            let needShow = place.category == category
            self.view.addMarker(place.id!, place: place, isActive: needShow)
        }
    }
    
    func showModalView(with id: String) {
        
        for (index, place) in self.places.enumerated() {
            if place.id == id {
                self.view.showPlaceView(with: index)
            }
        }
    }
    
    func fetchUserLocation() {
        self.locationManager.fetchLocation { (location, error) in
            if let location = location{
                self.userLocation = GeoPoint(latitude: location.latitude, longitude: location.longitude)
                PlaceManager.shared.userLocation = self.userLocation
                self.view.didChangeMyLocation(location)
                PlaceManager.shared.geocodeLocation(with: self.userLocation) { (locality, error) in
                    guard let locality = locality else {return}
                    self.view.showLocality(locality: locality)
                }
            }
        }
    }
}
    

