//
//  AppDelegate.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/15/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase
import FirebaseFirestore
import IQKeyboardManagerSwift
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()

        ApplicationDelegate.shared.application(application,didFinishLaunchingWithOptions: launchOptions)

        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID

        IQKeyboardManager.shared.enable = true

        GMSServices.provideAPIKey(Defaults.apiKey)
        GMSPlacesClient.provideAPIKey(Defaults.apiKey)
        
        window = UIWindow(frame: UIScreen.main.bounds)
                
        if let isLoginIn =  UserDefaultsService.shared.getData(for: .isLoggedIn) as? Bool,
            isLoginIn == true{
            self.window?.rootViewController = AppTabBarController()
        }else {
            let navigationController = UINavigationController()
            let rootViewController = ViewFactory.createAuthVC()
            navigationController.setViewControllers([rootViewController], animated: false)
            self.window?.rootViewController = navigationController
        }
        
        self.window?.makeKeyAndVisible()
        
        return true
    }
      
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return ApplicationDelegate.shared.application(application,
                                                         open: url,
                                                         sourceApplication: sourceApplication,
                                                         annotation: annotation)
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return ApplicationDelegate.shared.application(application, open: url, options: options)
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
           guard let eventSubtype = event?.subtype else {
               return
           }
           
           switch eventSubtype {
               
           case .remoteControlPlay:
               TPGAudioPlayer.sharedInstance().isPlaying = true
           case .remoteControlPause:
               TPGAudioPlayer.sharedInstance().isPlaying = false
           case .remoteControlNextTrack:
               TPGAudioPlayer.sharedInstance().skipDirection(skipDirection: SkipDirection.forward, timeInterval: kTestTimeInterval, offset: TPGAudioPlayer.sharedInstance().currentTimeInSeconds)
           case .remoteControlPreviousTrack:
               TPGAudioPlayer.sharedInstance().skipDirection(skipDirection: SkipDirection.backward, timeInterval: kTestTimeInterval, offset: TPGAudioPlayer.sharedInstance().currentTimeInSeconds)
               
           default: break
           }
       }
}

