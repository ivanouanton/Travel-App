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
    
    func getRoute(with positions: [GeoPoint],
                  completionHandler: @escaping (_ routes: String?, _ error: Error?) -> Void){
        
        let origin = positions.first!
        let destination = positions.last!
        var wayPoints = ""
        for point in positions {
            wayPoints = wayPoints.count == 0 ? "\(point.latitude),\(point.longitude)" : "\(wayPoints)%7C\(point.latitude),\(point.longitude)"
        }
        
        let strOrigin = "\(origin.latitude),\(origin.longitude)"
        let strDestination = "\(destination.latitude),\(destination.longitude)"
        
        NetworkProvider.shared.getMoyaProvider().request(.getRout(origin: strOrigin, destination: strDestination, points: wayPoints)) { result in
            switch result{
            case .success(let response):
                if let json : [String:Any] = try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String: Any]{
                    guard let routes = json["routes"] as? NSArray else {
                        return
                    }
                    if (routes.count > 0) {
                        let overview_polyline = routes[0] as? NSDictionary
                        let dictPolyline = overview_polyline?["overview_polyline"] as? NSDictionary
                        let routes = dictPolyline?.object(forKey: "points") as? String

                        completionHandler(routes, nil)
                    }
                }else{
                    completionHandler(nil, nil)
                }

            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    
    }
}
