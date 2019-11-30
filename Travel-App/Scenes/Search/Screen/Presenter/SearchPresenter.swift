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
    var categories = [String:Category]()
    private let imagesCache = NSCache<NSString, UIImage>()
    private let categoriesCache = NSCache<NSString, NSString>()
    private let categoryImagesCache = NSCache<NSString, UIImage>()


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
            if let cachedImage = imagesCache.object(forKey: imageRef.documentID as NSString) {
                placeImage = cachedImage
                aGroup.leave()
            }else{
                self.getImage(with: imageRef.parent.collectionID,
                              documentID: imageRef.documentID) { (image, error) in
                                placeImage = image
                                aGroup.leave()
                                self.imagesCache.setObject(image!, forKey: imageRef.documentID as NSString)
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
                self.view.didChangeMyLocation(location)
            }
        }
    }
    
    func getPlaces(){
        let db = Firestore.firestore()
        let aGroup = DispatchGroup()

        let docRef = db.collection("Place")
        aGroup.enter()
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = PlaceData(document.data())

                    self.places[document.documentID] = data
                }
            }
            aGroup.leave()
        }
        
        
        let categoryDocRef = db.collection("Category")
        aGroup.enter()
        categoryDocRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = Category(document.data())
                    self.categories[document.documentID] = data
                    
                    if let _ = self.categoryImagesCache.object(forKey: data.img.documentID as NSString) {
                    }else{
                        aGroup.enter()
                        self.getImage(with: data.img.parent.collectionID,
                                      documentID: data.img.documentID) { (image, error) in
                                        if let image = image{
                                            self.categoryImagesCache.setObject(image, forKey: document.documentID as NSString)
                                        }
                                        aGroup.leave()
                        }
                    }
                }
                self.view.setFilter(with: self.categories)
            }
            aGroup.leave()
        }
        
        aGroup.notify(queue: DispatchQueue.main){
            for (id, place) in self.places {
                let cachedImage = self.categoryImagesCache.object(forKey: place.categoryId as NSString)
                self.view.addPlace(id, place: place, markerImg: cachedImage)
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
    

