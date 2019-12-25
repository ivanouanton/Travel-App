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
    var places = [String:PlaceData]()
    var categories = [String:Category](){
        didSet{
            var categoriesNames = ["All"]
            for (_, val) in categories {
                categoriesNames.append(val.title)
            }
            self.view.setFilter(with: categoriesNames)
        }
    }
    
    private var categoriesName = ["All"]
    private var categoriesId = ["All"]

    private let imagesCache = NSCache<NSString, UIImage>()
    private let categoriesCache = NSCache<NSString, NSString>()
    private let categoryImagesCache = NSCache<NSString, UIImage>()


    weak var view: SearchViewProtocol!
    let locationManager: LocationManager
    
    required init(view: SearchViewProtocol) {
        self.view = view
        self.locationManager = LocationManager()
    }
    
    private func showAllMarkers(){
        self.view.clearMarkers()
        for (id, place) in self.places {
            let cachedImage = PlaceManager.shared.getCategoryImg(with: place.categoryId)
            self.view.addMarker(id, place: place, markerImg: cachedImage, isActive: true)
        }
    }
}

extension SearchPresenter: SearchPresenterProtocol{
    func viewDidLoad() {
        PlaceManager.shared.getCategories { (categories, categoriesId, error) in
            guard let categories = categories, let categoriesId = categoriesId else { return }
            self.categoriesId = categoriesId
            self.categories = categories
            self.getPlaces(with: nil)
        }
    }
    
    func getPlaces(with option: OptionFilterSelection?) {
        
        PlaceManager.shared.getPlaces(with: option) { (places, error) in
            self.places = places ?? [:]
            self.showAllMarkers()
        }
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
    
    func filterPlaces(with index: Int) {
        if index == 0{
            self.showAllMarkers()
            return
        }
        self.view.clearMarkers()
        
        for (id, place) in self.places {
            let cachedImage = PlaceManager.shared.getCategoryImg(with: place.categoryId)
            if place.categoryId == categoriesId[index] {
                self.view.addMarker(id, place: place, markerImg: cachedImage, isActive: true)
            }else{
                self.view.addMarker(id, place: place, markerImg: cachedImage, isActive: false)
            }
        }
    }
    
    func showModalView(with id: String) {
        guard let data = places[id] else {return}
        var placeImage: UIImage?
        
        let aGroup = DispatchGroup()
        
        if let imageRef = data.image {
            aGroup.enter()
            if let cachedImage = imagesCache.object(forKey: imageRef.documentID as NSString) {
                placeImage = cachedImage
                aGroup.leave()
            }else{
                self.getImage(with: imageRef.parent.collectionID,
                              documentID: imageRef.documentID) { (image, error) in
                                if let image = image{
                                    placeImage = image
                                    self.imagesCache.setObject(image, forKey: imageRef.documentID as NSString)
                                }
                                aGroup.leave()
                }
            }
        }
        
        aGroup.notify(queue: DispatchQueue.main){
            self.view.showModal(with: data, image: placeImage, category: self.categories[data.categoryId]?.title ?? "")
        }
    }
    
    func fetchUserLocation() {
        self.locationManager.fetchLocation { (location, error) in
            if let location = location{
                self.userLocation = GeoPoint(latitude: location.latitude, longitude: location.longitude)
                self.view.didChangeMyLocation(location)
            }
        }
    }
     
    private func getImage(with collectionID: String,
                          documentID: String,
                          completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
                
        let db = Storage.storage().reference()
        let collectionRef = db.child(collectionID)
        let imageRef = collectionRef.child(documentID)
        
            imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    completionHandler(nil, error)
                } else {
                    let image = UIImage(data: data!)
                    completionHandler(image, nil)
                }
            }
        }
    }
    

