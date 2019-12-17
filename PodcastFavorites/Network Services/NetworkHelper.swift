//
//  NetworkHelper.swift
//  PodcastFavorites
//
//  Created by Maitree Bain on 12/17/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import Foundation

class NetworkHelper {
    
    static let shared = NetworkHelper()
    
    private var session: URLSession
    
    private init() {
        session = URLSession(configuration: .default)
    }
    
    func performDataTask(with request: URLRequest, completion: @escaping (Result<Data, AppError>) -> ()) {
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            if let error = error {
                completion(.failure(.networkClientError(error)))
                return
            }
            
            switch urlResponse.statusCode {
                case 200...299: break
                default:
                  completion(.failure(.badStatusCode(urlResponse.statusCode)))
                  return
            }
            
            completion(.success(data))
            
        }
        dataTask.resume()
    }
}
