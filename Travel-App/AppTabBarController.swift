//
//  AppTabBarController.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/15/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class AppTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:
            UIColor(named: "onyx")!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:
            UIColor(named: "smokyTopaz")!], for: .selected)
        
        let search = ViewFactory.createSearchVC()
        search.tabBarItem = UITabBarItem(title: "Search",
                                         image: UIImage(named: "mapTabBar")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                         selectedImage: UIImage(named: "mapTabBarSelected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        
        let home = ViewFactory.createHomeVC()
        home.tabBarItem = UITabBarItem(title: "Search",
                                         image: UIImage(named: "home")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                         selectedImage: UIImage(named: "homeSelected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))

        
        
        let viewControllerList = [search, home]
        
        viewControllers = viewControllerList
    }
}

