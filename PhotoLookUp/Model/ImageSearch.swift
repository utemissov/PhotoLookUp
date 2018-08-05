//
//  ImageSearch.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 02.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import Foundation

struct ImageSearch {
    let id: String
    let title: String
}

extension ImageSearch {
    
    init?(json: JSON) {
        guard let id = json["id"] as? String,
            let title = json["title"] as? String else { return nil }
        self.id = id
        self.title = title
    }
    
}
