//
//  Configuration.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/24/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import Foundation

enum Defaults {

    static let location = Location(latitude: 41.903728, longitude: 12.493304)
    static let kMapStyle = """
    [
      {
        "featureType": "poi",
        "elementType": "all",
        "stylers": [
          { "visibility": "off" }
        ]
      }
    ]
    """
    static let apiKey = "AIzaSyD7MIVfHWK-1btctxDDtqgelOaNv3NP15I"

}
