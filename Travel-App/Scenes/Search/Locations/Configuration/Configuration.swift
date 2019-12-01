//
//  Configuration.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/24/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import Foundation

enum Defaults {

    static let location = Location(latitude: 53.478797, longitude: -2.241419)
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
    static let apiKey = "AIzaSyDsWUb4qF5MuVhNOUDmm2YTQvuEPBmEiQc"

}
