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

   required init(view: PlaceInfoViewProtocol) {
       self.view = view
   }
    
    func checkVisit(_ place: PlaceCardModel) {
        FirebaseProfileManager.shared.getAuthUserData { (user, image, error) in
            guard let contains = user?.places?.contains(place.id),
                contains == true else {
                    self.view.setBeenStatus(with: false)
                    return
            }
            
            self.view.setBeenStatus(with: true)
        }
    }
}
