//
//  BaseTargetType.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 02.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import Moya

protocol BaseTargetType: TargetType {}

extension BaseTargetType {
    
    public var baseURL: URL {
        return URL(string: "https://api.flickr.com")!
    }
    
    public var path: String {
        return "/services/rest"
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var validate: Bool {
        return true
    }
}
