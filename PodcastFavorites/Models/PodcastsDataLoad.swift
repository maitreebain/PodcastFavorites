//
//  PodcastsDataLoad.swift
//  PodcastFavorites
//
//  Created by Maitree Bain on 12/17/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import Foundation

struct PodcastsDataLoad: Codable {
    let results: [Podcasts]
}

struct Podcasts: Codable {
    let collectionId: Int?
    let trackId: Int
    let favoritedBy: String?
    let artistName: String?
    let collectionName: String
    let artworkUrl60: String?
    let artworkUrl600: String
    let favoritedId: Int?
}
