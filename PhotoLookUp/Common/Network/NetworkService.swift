//
//  NetworkService.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 02.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import Moya

typealias JSON = [String: Any]

protocol NetworkServiceType {
    func load(target: AnyTargetConvertible, completion: @escaping (Result<JSON>) -> Void)
}

final class NetworkService: NetworkServiceType {
    
    let provider = MoyaProvider<AnyTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func load(target: AnyTargetConvertible, completion: @escaping (Result<JSON>) -> Void) {
        provider.request(target.any, callbackQueue: DispatchQueue.main, progress: nil) { result in
            switch result {
            case .success(let response):
                if let jsonObject = try? JSONSerialization.jsonObject(with: response.data, options: []),
                    let json = jsonObject as? JSON {
                    completion(.success(json))
                } else {
                    completion(.error(.incorrectJSON))
                }
            case .failure:
                completion(.error(.networkFail))
            }
        }
    }

}
