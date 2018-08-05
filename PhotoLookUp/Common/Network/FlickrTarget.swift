//
//  FlickrTarget.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 02.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import Moya

enum Flickr: TargetType {
    case searchImages(by: String, page: Int, perPage: Int)
    case loadSizes(id: String)
}

extension Flickr: AnyTargetConvertible {
    
    var any: AnyTarget {
        return AnyTarget(self)
    }
    
    var key: String {
        return "66e2a2c4bdfdb5a83923b03c2f901a69"
    }
    
    var baseURL: URL {
        return URL(string: "https://api.flickr.com")!
    }
    
    var path: String {
        return "/services/rest"
    }
    
    var task: Task {
        switch self {
        case .searchImages(let text, let page, let perPage):
            let parameters: [String: Any] = [
                "method":"flickr.photos.search",
                "api_key": key,
                "text": text,
                "page": page,
                "per_page": perPage,
                "format": "json",
                "nojsoncallback": 1
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .loadSizes(let id):
            let parameters: [String: Any] = [
                "method":"flickr.photos.getSizes",
                "api_key": key,
                "photo_id": id,
                "format": "json",
                "nojsoncallback": 1
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var validationType: ValidationType {
        return ValidationType.none
    }
    
}
