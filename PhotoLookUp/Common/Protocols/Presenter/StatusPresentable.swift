//
//  StatusPresentable.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 02.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import Foundation

protocol ErrorPresentableProtocol {
    func showError(_ error: NetworkError)
    func showError(message: String)
}
