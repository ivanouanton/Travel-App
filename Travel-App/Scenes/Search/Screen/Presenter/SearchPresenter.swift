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
    var placesCard = [PlaceCardModel]()
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
            self.createPlacesData()
        }
    }
    
    func createPlacesData(){
        var placesModelData = Array<PlaceCardModel>()
        let placeGroup = DispatchGroup()
        
        for (id,place) in self.places {
            if let imgId = place.image {
                placeGroup.enter()
                ToursManager.shared.getImage(with: imgId ) { (image, error) in
                    
                    var placeModel = PlaceCardModel(id: id,
                                                    name: place.name,
                                                    category: self.categories[place.categoryId]?.title ?? "",
                                                    price: place.price,
                                                    image: image,
                                                    location: place.locationPlace,
                                                    description: place.description,
                                                    audio: place.audio)
                    placeGroup.enter()
                    PlaceManager.shared.geocodeLocation(with: place.locationPlace,
                                                        type: .address) { (address, error) in
                                                            
                                                            placeModel.placeName = address
                                                            placesModelData.append(placeModel)

                                                            placeGroup.leave()
                    }
                    
                    placeGroup.leave()
                }
                
            }
        }
        
        placeGroup.notify(queue: DispatchQueue.main){
            self.placesCard = placesModelData
            self.view.setPlacesCollection(with: placesModelData)
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
    
    //TODO remove this method
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
    
    func filterPlaces(with catId: String) {
        if catId == "all"{
            self.showAllMarkers()
            return
        }
        self.view.clearMarkers()
        
        for (id, place) in self.places {
            let cachedImage = PlaceManager.shared.getCategoryImg(with: place.categoryId)
            if place.categoryId == catId {
                self.view.addMarker(id, place: place, markerImg: cachedImage, isActive: true)
            }else{
                self.view.addMarker(id, place: place, markerImg: cachedImage, isActive: false)
            }
        }
    }
    
    func showModalView(with id: String) {
        
        for (index, place) in self.placesCard.enumerated() {
            if place.id == id {
                self.view.showPlaceView(with: index)
            }
        }
    }
    
    func fetchUserLocation() {
        self.view.showLoader(true)
        self.locationManager.fetchLocation { (location, error) in
            if let location = location{
                self.userLocation = GeoPoint(latitude: location.latitude, longitude: location.longitude)
                self.view.didChangeMyLocation(location)
                PlaceManager.shared.geocodeLocation(with: self.userLocation) { (locality, error) in
                    guard let locality = locality else {return}
                    self.view.showLocality(locality: locality)
                    self.view.showLoader(false)
                }
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
    

