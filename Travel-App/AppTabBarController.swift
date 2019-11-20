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
        
        let search = UINavigationController(rootViewController: ViewFactory.createSearchVC())
        search.tabBarItem = UITabBarItem(title: "Search",
                                         image: UIImage(named: "map-location-def")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                         selectedImage: UIImage(named: "map-location")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        
        let home = UINavigationController(rootViewController: ViewFactory.createHomeVC())
        home.tabBarItem = UITabBarItem(title: "Home",
                                         image: UIImage(named: "home-def")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                         selectedImage: UIImage(named: "home")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        
        let profile = UINavigationController(rootViewController: ViewFactory.createHomeVC())
        profile.tabBarItem = UITabBarItem(title: "Profile",
                                       image: UIImage(named: "avatar-def")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                       selectedImage: UIImage(named: "avatar")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))

        let settings = UINavigationController(rootViewController: ViewFactory.createHomeVC())
        settings.tabBarItem = UITabBarItem(title: "Settings",
                                          image: UIImage(named: "tools-def")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                          selectedImage: UIImage(named: "tools")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        
        let viewControllerList = [search, home, profile, settings]
        
        viewControllers = viewControllerList
    }
}

