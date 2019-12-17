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
    
}
