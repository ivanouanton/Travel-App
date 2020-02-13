//
//  PlaceInfoPresenter.swift
//  Travel-App
//
//  Created by Anton Ivanov on 2/13/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import Foundation

class PlaceInfoPresenter: PlaceInfoPresenterProtocol {
    
   weak var view: PlaceInfoViewProtocol!
    private var isVisited = false
    private var places = [String]()
    private var id: String?

   required init(view: PlaceInfoViewProtocol) {
       self.view = view
   }
    
    func checkVisit(_ place: PlaceCardModel) {
        FirebaseProfileManager.shared.getAuthUserData { (user, image, error) in
            
            self.places = user?.places ?? []
            self.id = place.id
            
            if self.places.contains(place.id) {
                self.isVisited = true
                self.view.setBeenStatus(with: true)
            } else {
                self.isVisited = false
                self.view.setBeenStatus(with: false)
                return
            }
        }
    }
    
    func didPressedIsVisited() {
        
        if isVisited {
            self.places = self.places.filter { $0 != id }
        } else {
            guard let id = self.id else { return }
            self.places.append(id)
        }
        
        FirebaseProfileManager.shared.updateUserPlaces(self.places) { (success, error) in
            if success {
                self.isVisited = !self.isVisited
                self.view.setBeenStatus(with: self.isVisited)
            } else {
                self.view.showDefaultAlert(with: error?.localizedDescription ?? "Error")
            }
        }
    }
}
