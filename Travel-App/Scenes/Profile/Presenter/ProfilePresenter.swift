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
        
    }
}

