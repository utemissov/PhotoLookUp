//
//  ImagesVCTests.swift
//  PhotoLookUpTests
//
//  Created by Алем Утемисов on 01.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import XCTest
@testable import PhotoLookUp

class ImageVCTests: XCTestCase {
    
    var sut: ImagesCollectionViewController!
    var outputMock: ImagesCollectionViewControllerOutputMock!
    var layoutMock: ImagesLayoutInputMock!
    
    override func setUp() {
        super.setUp()
        outputMock = ImagesCollectionViewControllerOutputMock()
        layoutMock = ImagesLayoutInputMock()
        sut = UIStoryboard.main.viewController(of: ImagesCollectionViewController.self)!
        sut.output = outputMock
        sut.collectionViewDelegate = layoutMock
        _ = sut.view
    }

    
    func testImagesVC_SearchBarDelegate_Set() {
        XCTAssertTrue(sut! is UISearchBarDelegate)
    }
    
    func testImagesVC_CollectionViewDataSource_Set() {
        XCTAssertTrue(sut! is UICollectionViewDataSource)
    }
    
    func testImagesVC_SearchesText() {
        let text = "Hello World!"
        sut.output.search(text: text)
        XCTAssertEqual(text, outputMock.searchText)
    }
    
    func testImagesVC_LayoutSetupCalled() {
        layoutMock.isSetupCalled = false
        sut.setLayout(to: layoutMock)
        XCTAssertTrue(layoutMock.isSetupCalled)
    }
    
}

class ImagesLayoutInputMock: ImagesLayoutInputDelegate {
    var isSetupCalled: Bool = false
    
    func setup(collectionView: UICollectionView) {
        isSetupCalled = true
    }
}
