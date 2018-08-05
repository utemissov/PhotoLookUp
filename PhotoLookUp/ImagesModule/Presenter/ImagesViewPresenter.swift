//
//  GridViewPresenter.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 02.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import Foundation

class ImagesViewPresenter: ImagesCollectionViewOutput {

    weak var view: ImagesCollectionViewInput!
    var interactor: ImagesInteractorInput!
    var imagesControllerLayouts: [ImagesCollectionLayouts: ImagesLayoutInputDelegate] = [:]
    
    fileprivate var canLoadMore: Bool = true
    fileprivate var isLoadingMore: Bool = false
    
    private var images: [ImageSizes] = []
    private var currentLayout: ImagesCollectionLayouts = .grid
    
    func searchButtonTapped() {
        if view.isSearching {
            view.hideSearchView()
        } else {
            view.showSearchView()
        }
    }
    
    func viewLoaded() {
        view.showActivityIndicator()
        if let layout = imagesControllerLayouts[currentLayout] {
            view.setLayout(to: layout)
        }
        view.hideCancelButton()
        interactor.searchImages(by: "Blendle", size: 20)
    }
    
    func search(text: String) {
        view.showActivityIndicator()
        canLoadMore = true
        interactor.searchImages(by: text, size: 20)
    }
    
    func loadMore() {
        guard canLoadMore && !view.imageUrls.isEmpty && !isLoadingMore else { return }
        isLoadingMore = true
        interactor.loadMore(size: 20)
    }
    
    func didSelectItem(at index: Int) {
        view.showCancelButton()
        currentLayout = .fullScreen
        if let layout = imagesControllerLayouts[currentLayout] {
            view.setLayout(to: layout)
        }
        let urls = images.compactMap { $0.sizes[Label.large] ?? $0.sizes[Label.largeSquare] }
        view.imageUrls = urls
        view.reloadData()
        view.scrollToItem(at: index, isHorizontalLayout: currentLayout == .fullScreen, animated: false)
    }
    
    func cancelButtonTapped(at index: Int) {
        view.hideCancelButton()
        currentLayout = .grid
        if let layout = imagesControllerLayouts[currentLayout] {
            view.setLayout(to: layout)
        }
        let urls = images.compactMap { $0.sizes[Label.largeSquare] }
        view.imageUrls = urls
        view.scrollToItem(at: index, isHorizontalLayout: false, animated: false)
        view.reloadData()
    }
    
}

extension ImagesViewPresenter: ImagesInteractorOutput {
    
    func add(images: [ImageSizes]) {
        view.hideActivityIndicator()
        self.images.append(contentsOf: images)
        let urls: [URL]
        switch currentLayout {
        case .fullScreen:
            urls = images.compactMap { $0.sizes[Label.large] ?? $0.sizes[Label.largeSquare] }
        case .grid:
            urls = images.compactMap { $0.sizes[Label.largeSquare]  }
        }
        view.imageUrls.append(contentsOf: urls)
        view.reloadData()
        isLoadingMore = false
    }
    
    func set(images: [ImageSizes]) {
        view.hideActivityIndicator()
        self.images = images
        let urls: [URL]
        switch currentLayout {
        case .fullScreen:
            urls = images.compactMap { $0.sizes[Label.large]  }
        case .grid:
            urls = images.compactMap { $0.sizes[Label.largeSquare]  }
        }
        view.imageUrls = urls
        view.reloadData()
        isLoadingMore = false
    }

    func lastPageLoaded() {
        canLoadMore = false
    }
    
    func showError(_ error: NetworkError) {
        view.hideActivityIndicator()
        view.showError(message: error.localizedDescription, completion: nil)
    }
    
    func showError(message: String) {
        view.hideActivityIndicator()
        view.showError(message: message, completion: nil)
    }
    
}

enum ImagesCollectionLayouts {
    case grid
    case fullScreen
}
