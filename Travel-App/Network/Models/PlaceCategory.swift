//
//  PlaceCategory.swift
//  Travel-App
//
//  Created by Anton Ivanov on 1/30/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit

enum PlaceCategory: String {
    case parks = "parks"
    case culturalsites = "culturalsites"
    case museums = "museums"
    case shopping = "shopping"
    case cityviews = "cityviews"
    case restaurants = "restaurants"
    case churches = "churches"
    
    init?(_ category: String){
        self.init(rawValue: category)
    }
    
    static let categories: [PlaceCategory] = [.parks, .culturalsites, .museums, .shopping, .cityviews, .restaurants, .churches]
}

extension PlaceCategory {
    func getImage() -> UIImage {
        
        let imageName: String
        
        switch self {
        case .parks:
            imageName = "landmark"
        case .culturalsites:
            imageName = "landmark"
        case .museums:
            imageName = "landmark"
        case .shopping:
            imageName = "landmark"
        case .cityviews:
            imageName = "landmark"
        case .restaurants:
            imageName = "landmark"
        case .churches:
            imageName = "landmark"
        }
        
        return UIImage(named: imageName)!
    }
    
    func getMarker() -> UIImage {
        
        let imageName: String
        
        switch self {
        case .parks:
            imageName = "PiazzasAndParks"
        case .culturalsites:
            imageName = "CulturalSites"
        case .museums:
            imageName = "MuseumandGalleryes"
        case .shopping:
            imageName = "Shopping"
        case .cityviews:
            imageName = "CityViews"
        case .restaurants:
            imageName = "RestaurentsNadCafes"
        case .churches:
            imageName = "Churches"
        }
        
        return UIImage(named: imageName)!
    }
    
    func getColor() -> UIColor {
        let colorName: String
        
        switch self {
        case .parks:
            colorName = "yellow"
        case .culturalsites:
            colorName = "blue"
        case .museums:
            colorName = "violet"
        case .shopping:
            colorName = "orange"
        case .cityviews:
            colorName = "emerald"
        case .restaurants:
            colorName = "green"
        case .churches:
            colorName = "red"
        }
        
        return UIColor(named: colorName)!
    }
    
    func getName() -> String {
        
        switch self {
        case .parks:
            return "Piazzas & Parks"
        case .culturalsites:
            return "Cultural Sites"
        case .museums:
            return "Museum & Galleries"
        case .shopping:
            return "Shopping"
        case .cityviews:
            return "City Views"
        case .restaurants:
            return "Restaurants & Cafes"
        case .churches:
            return "Churches"
        }
    }
}

extension PlaceCategory: Equatable {
    
    static func == (lhs: PlaceCategory, rhs: PlaceCategory) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
