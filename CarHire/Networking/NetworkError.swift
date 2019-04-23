//
//  NetworkError.swift
//  CarHire
//
//  Created by SS on 4/20/19.
//  Copyright © 2019 SergiySachuk. All rights reserved.
//

import Foundation

public enum NetworkError : String, Error {
    case invalidUrl = "Invalid URL."
    case dataParsingError = "Error parsing data"
    case decodingFailed = "Error decoding data."
    case genericError = "General network error."
}

extension NetworkError : LocalizedError {
    public var errorDescription: String? {
        return self.rawValue
    }
}




