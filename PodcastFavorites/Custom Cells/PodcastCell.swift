//
//  PodcastCell.swift
//  PodcastFavorites
//
//  Created by Maitree Bain on 12/17/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {

    @IBOutlet weak var podcastImage: UIImageView!
    
    @IBOutlet weak var podcastNameLabel: UILabel!
    
    @IBOutlet weak var podcastArtistName: UILabel!
    
    func configureCell(for podcast: Podcasts) {
        
        podcastNameLabel.text = podcast.collectionName
        podcastArtistName.text = podcast.artistName
        
        guard let imageURL = podcast.artworkUrl60 else {
            return
        }
        
        podcastImage.getImage(for: imageURL) { [weak self] (result) in
            
            switch result {
            case .failure(let appError):
                print("no image found: \(appError)")
                DispatchQueue.main.async {
                    self?.podcastImage.image = UIImage(systemName: "cloud")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.podcastImage.image = image
                    
                }
            }
        }
    }
    
    
}
