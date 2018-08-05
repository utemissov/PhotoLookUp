//
//  ErrorShowingProtocol.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 02.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import Foundation

typealias VoidCompletion = () -> Void

protocol ErrorShowingProtocol {
    func showError(message: String, completion: VoidCompletion?)
}
