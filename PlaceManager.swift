//
//  PlaceManager.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/8/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseStorage

class PlaceManager {
    static let shared = PlaceManager()

    private let imagesCache = NSCache<NSString, UIImage>()

    init() {}
    
    
    func getRoute(with origin: GeoPoint,
                  destination: GeoPoint,
                  completionHandler: @escaping (_ routes: [Any]?, _ error: Error?) -> Void){
        
        let strOrigin = "\(origin.latitude),\(origin.longitude)"
        let strDestination = "\(destination.latitude),\(destination.longitude)"
        
        NetworkProvider.shared.getMoyaProvider().request(.getRout(origin: strOrigin, destination: strDestination)) { result in
            switch result{
            case .success(let response):
                do {
                    let json = try JSONSerialization.jsonObject(with: response.data,
                                                                options : .allowFragments) as? [String : AnyObject]
                    
                    let routes = (json?["routes"] as? Array) ?? []
                    completionHandler(routes, nil)
               }
               catch {
                   print("ERROR: not working")
                completionHandler(nil, nil)
               }
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    
    }
}
