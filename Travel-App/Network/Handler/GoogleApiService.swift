//
//  GoogleApiService.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/25/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import Moya

enum GoogleApiService{
    case getRout(origin: String, destination: String, mode: String = "driving", points: String = "")
}

extension GoogleApiService: TargetType{
    var baseURL: URL {
        return URL(string: "https://maps.googleapis.com/maps/api")!
    }
    
    var path: String {
        switch self {
        case .getRout:
            return "/directions/json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRout:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {

        case .getRout(let origin, let destination, let mode, let points):
            var parameters = [String: String]()
            parameters["origin"] = origin
            parameters["destination"] = destination
            parameters["mode"] = mode
            parameters["points"] = points
            parameters["key"] = Defaults.apiKey
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
