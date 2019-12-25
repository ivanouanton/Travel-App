//
//  ViewFactory.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class ViewFactory{
    
    static func createSearchVC() -> SearchViewController{
        let vc = SearchViewController()
        let presenter = SearchPresenter(view: vc)
        vc.presenter = presenter
        return vc
    }
    
    static func createHomeVC() -> HomeViewController{
        let vc = HomeViewController()
        let presenter = HomePresenter(view: vc)
        vc.presenter = presenter
        return vc
    }
    
    static func createProfileVC() -> ProfileViewController{
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        let presenter = ProfilePresenter(view: vc)
        vc.presenter = presenter
        return vc
    }
    
    static func createSettingsVC() -> SettingsViewController{
        let vc = SettingsViewController()
        let presenter = SettingsPresenter(view: vc)
        vc.presenter = presenter
        return vc
    }
    
    static func createToursVC(with preferenses: [Int:Int]) -> ToursViewController{
        let vc = ToursViewController()
        let presenter = ToursPresenter(view: vc)
        presenter.filter = preferenses
        vc.presenter = presenter
        return vc
    }
    
    static func createAuthVC() -> AuthViewController{
        let storyboard = UIStoryboard(name: "Authorisation", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
        return vc
    }
}

