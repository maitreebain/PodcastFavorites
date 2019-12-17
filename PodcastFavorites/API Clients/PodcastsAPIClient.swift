//
//  PodcastsAPIClient.swift
//  PodcastFavorites
//
//  Created by Maitree Bain on 12/17/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import Foundation

struct PodcastsAPIClient {
    
    static func getPodcast(for userSearch: String, completion: @escaping (Result<[Podcasts], AppError>) -> ()) {
        
        let podcastEndpointUrl = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(userSearch)"
        
        guard let url = URL(string: podcastEndpointUrl) else {
            completion(.failure(.badURL(podcastEndpointUrl)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                
                do {
                    let podcastData = try JSONDecoder().decode(PodcastsDataLoad.self, from: data)
                    let podcasts = podcastData.results
                    
                    completion(.success(podcasts))
                }
                catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    
    
}
