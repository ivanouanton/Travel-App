//
//  ProfilePresenter.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import Foundation

class ProfilePresenter{
    weak var view: ProfileViewProtocol!
    
    required init(view: ProfileViewProtocol) {
        self.view = view
    }
}

extension ProfilePresenter: ProfilePresenterProtocol{
    func getUserData() {
        self.view.showLoader(true)
        let userGroup = DispatchGroup()
        let profileManager = FirebaseProfileManager.shared
        var placesModelData = Array<PlaceCardModel>()

        userGroup.enter()
        profileManager.getAuthUserData { (user, image, error) in
            
            if let image = image {
                self.view.showUserImage(image)
            }
            
            if let user = user {
                let fullName = user.name + " " + user.surname
                let information: [(key: String, value: String)] = [("Language", "English"), ("Home address", user.address ?? "")]
                self.view.showUserData(with: fullName, information: information)
                
                guard let places = user.places else {
                    self.view.showLoader(false)
                    return
                }
                
                for id in places {
                    userGroup.enter()
                    PlaceManager.shared.getPlaceCardModel(with: id) { (placeData, error) in
                        if let place = placeData {
                            placesModelData.append(place)
                        }
                        userGroup.leave()
                    }
                }
            }
            
            guard error == nil else {
                print(error!.localizedDescription)
                self.view.showLoader(false)
                return
            }
            
            userGroup.leave()
        }
        
        userGroup.notify(queue: .main) {
            self.view.showLoader(false)
            self.view.showRecentPlaces(with: placesModelData)
        }
    }
}

