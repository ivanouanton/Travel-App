//
//  ViewFactory.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

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
}

