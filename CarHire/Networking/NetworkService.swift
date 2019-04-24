//
//  NetworkService.swift
//  CarHire
//
//  Created by SS on 4/22/19.
//  Copyright © 2019 SergiySachuk. All rights reserved.
//

import UIKit

class NetworkService {
    
    //Singleton
    static let shared = NetworkService()
    
    private init(){}
    
    typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    //MARK: - Generic get request
    
    func get<T: Decodable>(url: URL?,
                           headers: [String: String],
                           completion: @escaping(_ result: Result<T, Error>) -> Void) {
        
        guard let url = url else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    completion(.failure(NetworkError.dataParsingError))
                    return
                }
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responseObject))
                    return
                }
            }
            completion(.failure(NetworkError.genericError))
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
            .resume()
    }
    
    func loadImage(urlString: String, completion: @escaping(_ image: UIImage?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let completionHandler: NetworkCompletionHandler = { (data, _, _) in
            if let data = data {
                if let image = UIImage(data: data) {
                    completion(image)
                    return
                }
            }
            completion(nil)
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: completionHandler)
            .resume()
    }
    
    
    //MARK: - Helper methods
    
    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
    
    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }
    
}
