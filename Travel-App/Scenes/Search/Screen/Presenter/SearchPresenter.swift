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
    
    var places = [String:PlaceData]()
    private let imagesCache = NSCache<NSString, UIImage>()
    
    weak var view: SearchViewProtocol!
    let locationManager: LocationManager
    
    required init(view: SearchViewProtocol) {
        self.view = view
        self.locationManager = LocationManager()
    }
}

extension SearchPresenter: SearchPresenterProtocol{
    func showModalView(with id: String) {
        guard let data = places[id] else {return}
        var placeImage: UIImage?
        
        let aGroup = DispatchGroup()
        
        if let imageRef = data.image {
            aGroup.enter()
            self.getImage(with: imageRef.parent.collectionID,
                          documentID: imageRef.documentID) { (image, error) in
                            placeImage = image
                            aGroup.leave()
                            self.view.showModal(with: data, image: image)
            }
        }
        
        aGroup.notify(queue: DispatchQueue.main){
            self.view.showModal(with: data, image: placeImage)
        }
         
    }
    
    func fetchUserLocation() {
        self.locationManager.fetchLocation { (location, error) in
            if let location = location{
                self.view.didChangeMyLocation(location)
            }
        }
    }
    
    func getPlaces(){
        let db = Firestore.firestore()
        
        let docRef = db.collection("Place")
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = PlaceData(document.data())

                    self.places[document.documentID] = data
                    
                    self.view.addPlace(document.documentID, place: data)
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
        
        if let cachedImage = imagesCache.object(forKey: documentID as NSString) {
            completionHandler(cachedImage, nil)
        }else{
            imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    completionHandler(nil, error)
                } else {
                    let image = UIImage(data: data!)
                    self.imagesCache.setObject(image!, forKey: documentID as NSString)
                    completionHandler(image, nil)
                }
            }
        }
    }
    
}
