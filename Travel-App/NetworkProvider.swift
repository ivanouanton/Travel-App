//
//  NetworkProvider.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/8/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import Moya
import Alamofire

class CustomServerTrustPoliceManager: ServerTrustPolicyManager {
    
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return .disableEvaluation
    }
    
    public init() {
        super.init(policies: [:])
    }
}

class NetworkProvider {
    static let shared = NetworkProvider()
    
    private init () {
    }
    
    private var configuration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 5
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return configuration
    }
    
    func getMoyaProvider() -> MoyaProvider<GoogleApiService> {
        
        let manager = Manager(
            configuration: configuration,
            serverTrustPolicyManager: CustomServerTrustPoliceManager()
        )
        return MoyaProvider<GoogleApiService>(manager: manager, plugins: [NetworkLoggerPlugin(verbose: true)])
    }
    
}
