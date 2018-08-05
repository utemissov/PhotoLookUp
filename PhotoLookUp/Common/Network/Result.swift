//
//  Result.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 02.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import Foundation

enum Result<A> {
    case success(A)
    case error(NetworkError)
    
    init(_ value: A?, or error: NetworkError) {
        if let value = value {
            self = .success(value)
        } else {
            self = .error(error)
        }
    }
}
