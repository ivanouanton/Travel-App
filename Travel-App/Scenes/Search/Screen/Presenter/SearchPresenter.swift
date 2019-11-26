//
//  SearchPresenter.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import Foundation
import FirebaseFirestore


class SearchPresenter{
    
    var places = [String:PlaceData]()
    
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
}
