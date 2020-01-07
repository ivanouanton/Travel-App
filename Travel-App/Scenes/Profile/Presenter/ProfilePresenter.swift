//
//  ProfilePresenter.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

class ProfilePresenter{
    weak var view: ProfileViewProtocol!
    
    required init(view: ProfileViewProtocol) {
        self.view = view
    }
}

extension ProfilePresenter: ProfilePresenterProtocol{
    func getUserData() {
        let profileManager = FirebaseProfileManager.shared
        
        profileManager.getAuthUserData { (user, image, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let image = image {
                self.view.showUserImage(image)
            }
            
            if let user = user {
                let fullName = user.name + " " + user.surname
                var information: [(key: String, value: String)] = [("Language", "English"), ("Home address", user.address ?? "")]
                self.view.showUserData(with: fullName, information: information)
            }
        }
    }
}

