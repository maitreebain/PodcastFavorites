//
//  FavoritesDataLoad.swift
//  PodcastFavorites
//
//  Created by Maitree Bain on 12/17/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import Foundation

struct FavoritesDataLoad: Codable {
    let trackId: Int
    let favoritedBy: String
    let collectionName: String
    let artworkUrl600: String
}
