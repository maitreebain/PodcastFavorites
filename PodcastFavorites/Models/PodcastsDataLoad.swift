//
//  PodcastsDataLoad.swift
//  PodcastFavorites
//
//  Created by Maitree Bain on 12/17/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import Foundation

struct PodcastsDataLoad: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let collectionId: Int
    let trackId: Int
    let artistName: String
    let collectionName: String
    let artworkUrl60: String
    let artworkUrl600: String
}
