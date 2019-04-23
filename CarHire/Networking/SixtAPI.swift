//
//  SixtAPI.swift
//  CarHire
//
//  Created by SS on 4/22/19.
//  Copyright © 2019 SergiySachuk. All rights reserved.
//

import Foundation

struct SixtAPI {
    
    struct urls {
        static let baseURL = URL(string: "https://cdn.sixt.io/codingtask")
        static let carsListURL = SixtAPI.urls.baseURL?.appendingPathComponent("/cars")
    }
    
    static func fetchCars(completion: @escaping (_ result: Result<[Car],Error>) -> Void){
        let url = SixtAPI.urls.carsListURL
        let headers : [String : String] = [:]
        NetworkService.shared.get(url: url, headers: headers) { result in
            completion(result)
        }
    }
    
}
