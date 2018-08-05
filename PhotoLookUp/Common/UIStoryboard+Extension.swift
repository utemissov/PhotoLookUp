//
//  UIStoryboard+Extension.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 01.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func viewController<T: UIViewController>(of type: T.Type) -> T? {
        return instantiateViewController(withIdentifier: String(describing: type)) as? T
    }
    
}
