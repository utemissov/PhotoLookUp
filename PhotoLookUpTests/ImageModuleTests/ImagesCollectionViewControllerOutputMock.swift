//
//  ImagesCollectionViewControllerOutputMock.swift
//  PhotoLookUpTests
//
//  Created by Алем Утемисов on 06.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import Foundation
@testable import PhotoLookUp

class ImagesCollectionViewControllerOutputMock: ImagesCollectionViewOutput {
    
    var searchText: String = ""
    
    func searchButtonTapped() {
        
    }
    
    func cancelButtonTapped(at index: Int) {
        
    }
    
    func viewLoaded() {
        
    }
    
    func search(text: String) {
        searchText = text
    }
    
    func loadMore() {
        
    }
    
    func didSelectItem(at index: Int) {
        
    }
    
    
}
