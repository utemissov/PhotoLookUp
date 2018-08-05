//
//  BaseViewController.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 02.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, ActivityIndicatorProtocol, ErrorShowingProtocol {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator?.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
        }
    }
    
    func showError(message: String, completion: VoidCompletion?) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: completion)
    }

}
