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
        self.view.showModal(with: data)
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
    
    private func getImage(with link: DocumentReference?,
                          completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> Void){
        guard let islandRef = link else{return}
        let db = Storage.storage().reference().child(islandRef.parent.collectionID).child(islandRef.documentID)
        let collectionRef = db.child(islandRef.parent.collectionID)
        let imageRef = collectionRef.child(islandRef.documentID)
        
        if let cachedImage = imagesCache.object(forKey: islandRef.path as NSString) {
            completionHandler(cachedImage, nil)
        }else{
            imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    completionHandler(nil, error)
                } else {
                    let image = UIImage(data: data!)
                    self.imagesCache.setObject(image!, forKey: islandRef.path as NSString)
                    completionHandler(image, nil)
                }
            }
        }
    }
    
}
