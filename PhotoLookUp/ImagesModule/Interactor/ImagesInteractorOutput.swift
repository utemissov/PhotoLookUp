//
//  ImagesInteractorOutput.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 02.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

protocol ImagesInteractorOutput: class, ErrorPresentableProtocol {
    func add(images: [ImageSizes])
    func set(images: [ImageSizes])
    func lastPageLoaded()
}
