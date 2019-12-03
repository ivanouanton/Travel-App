//
//  LocationService.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/24/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import Foundation

enum LocationServiceError: Error {
    case notAuthorizedToRequestLocation
}

protocol LocationService {
    
    // MARK: - Type Aliases
    
    typealias FetchLocationCompletion = (Location?, LocationServiceError?) -> Void
    
    // MARK: - Methods
    
    func fetchLocation(completion: @escaping FetchLocationCompletion)
    
}
