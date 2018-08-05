//
//  ImagesConfiguratorTests.swift
//  PhotoLookUpTests
//
//  Created by Алем Утемисов on 06.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import XCTest
@testable import PhotoLookUp

class ImagesConfiguratorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConfigureModuleForViewController() {
        
        //given
        let viewController = ImagesCollectionViewController()
        let configurator = ImagesModuleConfigurator()
        
        //when
        configurator.configureModuleForViewInput(viewInput: viewController)
        
        //then
        XCTAssertNotNil(viewController.output, "ImagesCollectionViewController is nil after configuration")
        XCTAssertTrue(viewController.output is ImagesViewPresenter, "output is not ImagesViewPresenter")
        
        let presenter: ImagesViewPresenter = viewController.output as! ImagesViewPresenter
        XCTAssertNotNil(presenter.view, "view in ImagesViewPresenter is nil after configuration")
        
        XCTAssertNotNil(presenter.imagesControllerLayouts[.grid], "grid layout is nil after configuration")
        XCTAssertNotNil(presenter.imagesControllerLayouts[.fullScreen], "fullScreen layout is nil after configuration")
        
        let interactor: ImagesInteractor = presenter.interactor as! ImagesInteractor
        XCTAssertNotNil(interactor.output, "output in ImagesInteractor is nil after configuration")
    }
    
}
