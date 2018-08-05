//
//  ImageLoaderServiceType.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 05.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import Foundation

protocol ImageLoaderServiceType {
    func load(by ids: String..., completion: ([Data]) -> Void)
}
