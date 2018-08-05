//
//  AnyTarget.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 02.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import Moya

enum AnyTarget: BaseTargetType {
    
    case target(TargetType)
    
    public init(_ target: TargetType) {
        self = AnyTarget.target(target)
    }
    
    var baseURL: URL {
        return target.baseURL
    }
    
    var path: String {
        return target.path
    }
    
    var task: Task {
        return target.task
    }
    
    var method: Moya.Method {
        return target.method
    }
    
    var headers: [String : String]? {
        return target.headers
    }
    
    public var target: TargetType {
        switch self {
        case .target(let target): return target
        }
    }
}

protocol AnyTargetConvertible {
    var any: AnyTarget { get }
}

extension AnyTargetConvertible where Self: TargetType {
    var any: AnyTarget {
        return AnyTarget(self)
    }
}
