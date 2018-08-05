//
//  ImagesInteractor.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 02.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import Foundation

class ImagesInteractor: ImagesInteractorInput {
    
    var networkService: NetworkServiceType!
    weak var output: ImagesInteractorOutput!
    
    private var searchText = ""
    private var currentPage = 0
    
    private lazy var debouncedSearch = debounce(interval: 500, queue: .global(qos: .background)) {[weak self] text, perPage in
        self?.startSearching(by: text, perPage: perPage)
    }
    
    func loadMore(size: Int) {
        guard !searchText.isEmpty else { return }
        currentPage += 1
        search(by: searchText, page: currentPage, perPage: size) {[weak self] result in
            switch result {
            case .success(let searchedImages):
                self?.getSourceURLs(from: searchedImages, completion: { (result) in
                    switch result {
                    case .success(let images):
                        self?.output.add(images: images)
                    case .error(let error):
                        self?.output.showError(error)
                    }
                })
            case .error(let error):
                self?.output.showError(error)
            }
        }
    }
    
    func searchImages(by text: String, size perPage: Int) {
        debouncedSearch(text, perPage)
    }
    
    private func startSearching(by text: String, perPage: Int) {
        guard !text.isEmpty else {
            output.set(images: [])
            return
        }
        currentPage = 0
        searchText = text
        search(by: text, page: 0, perPage: perPage) { [weak self] result in
            switch result {
            case .success(let searchedImages):
                self?.getSourceURLs(from: searchedImages, completion: { (result) in
                    switch result {
                    case .success(let images):
                        self?.output.set(images: images)
                    case .error(let error):
                        self?.output.showError(error)
                    }
                })
            case .error(let error):
                self?.output.showError(error)
            }
        }
    }
    
    private func search(by text: String, page: Int = 0, perPage: Int, completion: @escaping (Result<[ImageSearch]>) -> Void ) {
        let target = Flickr.searchImages(by: text, page: page, perPage: perPage)
        networkService.load(target: target) { [weak self] (result) in
            switch result {
            case .success(let json):
                guard let photosJSON = json["photos"] as? JSON,
                    let photoArray = photosJSON["photo"] as? [JSON] else {
                        completion(Result.error(NetworkError.incorrectJSON))
                        return
                }
                let totalPages = photosJSON["pages"] as? Int ?? 0
                let currentPage = photosJSON["page"] as? Int ?? 0
                
                self?.currentPage = currentPage
                if currentPage >= totalPages {
                    self?.output?.lastPageLoaded()
                }
                
                let photos = photoArray.compactMap { ImageSearch(json: $0) }
                completion(Result.success(photos))
            case .error(let error):
                completion(Result.error(error))
            }
        }
    }
    
    private func getSourceURLs(from images: [ImageSearch], completion: @escaping (Result<[ImageSizes]>) -> Void ) {
        let dispatchGroup = DispatchGroup()
        
        var resultImages: [ImageSizes] = []
        var error: NetworkError?
        
        for image in images {
            dispatchGroup.enter()
            let target = Flickr.loadSizes(id: image.id)
            self.networkService.load(target: target) { (result) in
                switch result {
                case .success(let json):
                    guard let sizesJSON = json["sizes"] as? JSON,
                        let imageSizes = ImageSizes(json: sizesJSON) else {
                            completion(Result.error(NetworkError.incorrectJSON))
                            return
                    }
                    resultImages.append(imageSizes)
                case .error(let err):
                    error = err
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .global(qos: .background)) {
            if let error = error, resultImages.isEmpty {
                completion(Result.error(error))
            } else {
                completion(Result.success(resultImages))
            }
        }
    }
    
    
    
}

func debounce(interval: Int, queue: DispatchQueue, action: @escaping ((String, Int) -> Void)) -> (String, Int) -> Void {
    var lastFireTime = DispatchTime.now()
    let dispatchDelay = DispatchTimeInterval.milliseconds(interval)
    
    return { text, perPage in
        lastFireTime = DispatchTime.now()
        let dispatchTime: DispatchTime = DispatchTime.now() + dispatchDelay
        
        queue.asyncAfter(deadline: dispatchTime) {
            let when: DispatchTime = lastFireTime + dispatchDelay
            let now = DispatchTime.now()
            if now.rawValue >= when.rawValue {
                action(text, perPage)
            }
        }
    }
}
