//
//  NetworkError.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 02.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case incorrectJSON
    case networkFail
    case serverError(reason: String)
    case unknownServerError
}
