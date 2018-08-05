//
//  ImagesModuleConfigurator.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 02.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import UIKit

class ImagesModuleInitializer: NSObject {
    
    @IBOutlet weak var initialNavigationController: UINavigationController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let configurator = ImagesModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: initialNavigationController.viewControllers.first)
    }
    
    
}
