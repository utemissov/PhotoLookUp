//
//  ImageCollectionViewOutput.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 01.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

protocol ImagesCollectionViewOutput {
    func searchButtonTapped()
    func cancelButtonTapped(at index: Int)
    func viewLoaded()
    func search(text: String)
    func loadMore()
    func didSelectItem(at index: Int)
}
