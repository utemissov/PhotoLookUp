//
//  ImageSizes.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 05.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import Foundation

struct ImageSizes {
    let sizes: [Label: URL]
}

extension ImageSizes {
    
    init?(json: JSON) {
        var sizes: [Label: URL] = [:]
        guard let jsonSizes = json["size"] as? [JSON] else { return nil}
        jsonSizes.forEach { json in
            guard let labelString = json["label"] as? String,
                let labelEnum = Label(rawValue: labelString),
                let source = json["source"] as? String,
                let url = URL(string: source) else { return }
            sizes[labelEnum] = url
        }
        self.sizes = sizes
    }
    
}

enum Label: String {
    case square = "Square"
    case largeSquare = "Large Square"
    case thumbnail = "Thumbnail"
    case small = "Small"
    case small320 = "Small 320"
    case medium = "Medium"
    case medium640 = "Medium 640"
    case medium800 = "Medium 800"
    case large = "Large"
    case original = "Original"
}
