//
//  SplashScreenPresenter.swift
//  Travel-App
//
//  Created by Антон Иванов on 1/7/20.
//  Copyright © 2020 companyName. All rights reserved.
//

class SplashScreenPresenter{
    weak var view: SplashScreenViewController?
    
    init(view: SplashScreenViewController) {
        self.view = view
    }
    
    func checkAuth() {
        UserDefaultsService.shared.getData(for: .isLoggedIn)
    }
}
