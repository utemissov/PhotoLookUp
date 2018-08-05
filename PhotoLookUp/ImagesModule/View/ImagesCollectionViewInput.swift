//
//  ImageCollectionViewInput.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 01.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import Foundation

protocol ImagesCollectionViewInput: BaseViewInputProtocol {
    var isSearching: Bool { get }
    var imageUrls: [URL] { get set }
    
    func showSearchView()
    func hideSearchView()
    func reloadData()
    func setLayout(to delegate: ImagesLayoutInputDelegate)
    func hideCancelButton()
    func showCancelButton()
    func scrollToItem(at index: Int, isHorizontalLayout: Bool, animated: Bool)
}
