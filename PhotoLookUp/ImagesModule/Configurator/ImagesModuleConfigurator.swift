//
//  ImagesModuleConfigurator.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 02.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import UIKit

class ImagesModuleConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController?) {
        if let viewController = viewInput as? ImagesCollectionViewController {
            configure(viewController: viewController)
        }
    }
    
    func configure(viewController: ImagesCollectionViewController) {
        let imagesGridLayout = ImagesGridLayout()
        imagesGridLayout.delegate = viewController
        
        let imagesFullScreenLayout = ImagesFullScreenLayout()
        imagesFullScreenLayout.delegate = viewController
        
        let presenter = ImagesViewPresenter()
        
        presenter.view = viewController
        presenter.imagesControllerLayouts[.grid] = imagesGridLayout
        presenter.imagesControllerLayouts[.fullScreen] = imagesFullScreenLayout
        
        viewController.output = presenter
        
        let network = NetworkService()
        let interactor = ImagesInteractor()
        interactor.output = presenter
        interactor.networkService = network
        
        presenter.interactor = interactor
    }
    
}
