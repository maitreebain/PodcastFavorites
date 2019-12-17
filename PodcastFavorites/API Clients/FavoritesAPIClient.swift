//
//  FavortiesAPIClient.swift
//  PodcastFavorites
//
//  Created by Maitree Bain on 12/17/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import Foundation

struct FavoritesAPIClient {
    
    static func getFavorites(completion: @escaping (Result<[FavoritesDataLoad], AppError>) -> ())  {
        
        let favoritesEndpointUrl = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: favoritesEndpointUrl) else {
            completion(.failure(.badURL(favoritesEndpointUrl)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            
            switch result{
                case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                    return
                case .success(let data):
                    
                    do {
                        let favorites = try JSONDecoder().decode([FavoritesDataLoad].self, from: data)
                        
                        completion(.success(favorites))
                    } catch {
                        completion(.failure(.decodingError(error)))
                    }
            }
        }
    }
    
    static func postFavorites(favorite: FavoritesDataLoad, completion: @escaping (Result<Bool, AppError>) -> ()) {
        
        let endpointUrl = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: endpointUrl) else {
            completion(.failure(.badURL(endpointUrl)))
            return
        }
        
        do {
            let data = try JSONEncoder().encode(favorite)
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = data
            
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                    
                    switch result{
                    case .failure(let appError):
                        completion(.failure(.networkClientError(appError)))
                    case .success:
                        completion(.success(true))
                    }
                }
                
            } catch {
                completion(.failure(.encodingError(error)))
            }
    }
    
}
