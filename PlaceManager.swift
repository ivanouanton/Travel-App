//
//  PlaceManager.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/8/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseStorage
import GoogleMaps

class PlaceManager {
    static let shared = PlaceManager()

    private let placesImageCache = NSCache<NSString, UIImage>()
    private let categoryImagesCache = NSCache<NSString, UIImage>()
    private let duration = ["A Few Hours", "Half Day",  "Full Day"]
    
    var places = [PlaceData]()

    private init() {
        self.getPlaces(with: nil) { (places, error) in
            guard let places = places else { return }
            self.places = places.map({ (arg0) -> PlaceData in
                
                var (key, value) = arg0
                    value.id = key
                return value
            })
        }
    }
    
    func getCategoryImg(with id: String) -> UIImage?{
        let cachedImage = self.categoryImagesCache.object(forKey: id as NSString)
        return cachedImage
    }
    
    func getRoute(with positions: [GeoPoint],
                  completionHandler: @escaping (_ routes: String?, _ error: Error?) -> Void){
        
        let origin = positions.first!
        let destination = positions.last!
        var wayPoints = ""
        
        for index in 1..<(positions.count - 1){
            let point = positions[index]
        
            wayPoints = wayPoints.count == 0 ? "via:\(point.latitude),\(point.longitude)" : "\(wayPoints)|via:\(point.latitude),\(point.longitude)"
        }
        
        let strOrigin = "\(origin.latitude),\(origin.longitude)"
        let strDestination = "\(destination.latitude),\(destination.longitude)"
        
        NetworkProvider.shared.getMoyaProvider().request(.getRout(origin: strOrigin, destination: strDestination, points: wayPoints)) { result in
            switch result{
            case .success(let response):
                if let json : [String:Any] = try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String: Any]{
                    guard let routes = json["routes"] as? NSArray else {
                        return
                    }
                    if (routes.count > 0) {
                        let overview_polyline = routes[0] as? NSDictionary
                        let dictPolyline = overview_polyline?["overview_polyline"] as? NSDictionary
                        let routes = dictPolyline?.object(forKey: "points") as? String

                        completionHandler(routes, nil)
                    }
                }else{
                    completionHandler(nil, nil)
                }

            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func getPlace(with id: String, completion: @escaping (_ place: PlaceData?, _ error: Error?) -> Void){
        let db = Firestore.firestore()
        
        let docRef = db.collection("Place").document(id)
        docRef.getDocument { (document, err) in
            
            if let place = document.flatMap({
              $0.data().flatMap({ (data) in
                return PlaceData(data)
              })
            }) {
                completion(place, nil)
            } else {
                completion(nil, err)
            }
        }
    }
    
    func getPlaceCardModel(with id: String, completion: @escaping (_ place: PlaceCardModel?, _ error: Error?) -> Void){
        let db = Firestore.firestore()
        var placeData: PlaceCardModel? = nil
        var error: Error? = nil
        let cardGroup = DispatchGroup()
        
        let docRef = db.collection("Place").document(id)
        
        cardGroup.enter()
        docRef.getDocument { (document, err) in
            error = err
            if let data = document?.data() {
                
                let place = PlaceData(data)
                if let imgId = place.image {
                    
                    cardGroup.enter()
                    ToursManager.shared.getImage(with: imgId ) { (image, error) in
                        placeData = PlaceCardModel(id: id,
                                                       name: place.name,
                                                       category: place.categoryId,
                                                       price: place.price,
                                                       image: image,
                                                       location: place.locationPlace,
                                                       description: place.description)
                        cardGroup.leave()
                    }
                }
            }
            cardGroup.leave()
        }
        
        cardGroup.notify(queue: .main) {
            completion(placeData, error)
        }
    }
    
    
    
    func getPlaces(with option: OptionFilterSelection? , completion: @escaping (_ places: [String:PlaceData]?, _ error: Error?) -> Void){
        let db = Firestore.firestore()
        var places = [String:PlaceData]()

        let docRef = db.collection("Place")
        var query = docRef.order(by: "name")
        
        switch option {
        case .price(let price):
            query = query.whereField("price", isEqualTo: price)
        case .visited:
            break
        case .mustVisit:
            query = query.whereField("isMustVisit", isEqualTo: true)
        case .none:
            break
        }
        
        query.getDocuments() { (querySnapshot, err) in
            if let err = err {
                completion(nil, err)
                print("Error getting documents: \(err)")
            } else {
                print(querySnapshot!.documents.count)
                for document in querySnapshot!.documents {
                    let data = PlaceData(document.data())

                    places[document.documentID] = data
                }
            }
            completion(places, nil)
        }
    }

    func getCategories(completion: @escaping (_ categories: [String:Category]?, _ categoriesId: [String]?, _ error: Error?) -> Void){
        let db = Firestore.firestore()
        let aGroup = DispatchGroup()
        var categories = [String:Category]()
        var categoriesId = ["All"]

        
        let categoryDocRef = db.collection("Category")
        aGroup.enter()
        categoryDocRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = Category(document.data())
                    categories[document.documentID] = data
                    
                    categoriesId.append(document.documentID)
                    
                    if let _ = self.categoryImagesCache.object(forKey: data.img.documentID as NSString) {
                    }else{
                        aGroup.enter()
                        ToursManager.shared.getImage(with: data.img) { (image, error) in
                            if let image = image{
                                self.categoryImagesCache.setObject(image, forKey: document.documentID as NSString)
                            }
                            aGroup.leave()
                        }
                    }
                }
            }
            aGroup.leave()
        }
        
        aGroup.notify(queue: DispatchQueue.main){
            completion(categories, categoriesId, nil)
        }
    }
    
    func geocodeLocation(with location: GeoPoint,
                         type: GeocodeType = GeocodeType.locality,
                         completion: @escaping (_ name: String?, _ error: Error?) -> Void){
        NetworkProvider.shared.getMoyaProvider().request(.geocode(latitude: location.latitude, longitude: location.longitude)) { result in
            switch result{
            case .success(let response):
                if let json : [String:Any] = try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String: Any]{
                    
                    guard let results = json["results"] as? Array<Any>,
                        !results.isEmpty,
                        let result = results[0] as? [String: Any] else {
                            completion(nil, nil)
                            return
                    }
                    
                    switch type {
                    case .locality:
                        guard let addressComponents = result["address_components"] as? Array<Any>,
                        let component = addressComponents[2] as? [String: Any],
                        let locality = component["short_name"] as? String else {
                            completion(nil, nil)
                            return
                        }
                        completion(locality, nil)

                    case .address:
                        
                        guard let address = result["formatted_address"] as? String else {
                            completion(nil, nil)
                            return
                        }
                        completion(address, nil)
                    }
                    
                }else{
                    completion(nil, nil)
                }

            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getAudioURL( with reference: DocumentReference,
                   completion: @escaping (_ image: URL?, _ error: Error?) -> Void)  {
        
        let storageReference = Storage.storage().reference(forURL: "gs://trello-2704d.appspot.com/audio_place/" + reference.documentID)
        
        storageReference.downloadURL { (hardUrl, error) in
            completion(hardUrl, error)
        }
    }
    
    func getFilteredPlaces(with categories: [PlaceCategory],
                           prices: [Int],
                           completionHandler: @escaping (_ tours: [PlaceData]?, _ error: Error?) -> Void) {
            
        let db = Firestore.firestore()
        let docRef = db.collection("Place")
        var query = docRef.order(by: "name")
        
        if !categories.isEmpty {
            query = query.whereField("category", in: categories.compactMap { $0.rawValue })
        }
        
        if !prices.isEmpty {
            query = query.whereField("price", in: prices)
        }

        query.getDocuments() { (querySnapshot, error) in
            if let response = querySnapshot {
                var places = [PlaceData]()
                for document in response.documents {
                    let place = PlaceData(document.data())
                    places.append(place)
                }
                completionHandler(places, nil)
            } else {
                completionHandler(nil, error)
            }
            
        }
    }
}
