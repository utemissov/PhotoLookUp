//
//  ImagesInteractorInput.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 02.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import Foundation

protocol ImagesInteractorInput {
    func loadMore(size: Int)
    func searchImages(by text: String, size: Int)
}
