//
//  GoogleApiService.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/25/19.
//  Copyright © 2019 companyName. All rights reserved.
//

let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(Defaults.apiKey)"


import Moya

enum RestService{
    case getRout(origin: String, destination: String)
}

extension RestService: TargetType{
    var baseURL: URL {
        return URL(string: "https://maps.googleapis.com/maps/api")!
    }
    
    var path: String {
        switch self {
        case .getRout(let origin, let destination):
            return "/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(Defaults.apiKey)"
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

        case .getRout:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
