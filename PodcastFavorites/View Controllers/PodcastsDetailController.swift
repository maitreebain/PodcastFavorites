//
//  PodcastsDetailController.swift
//  PodcastFavorites
//
//  Created by Maitree Bain on 12/17/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

class PodcastsDetailController: UIViewController {

    @IBOutlet weak var podcastImage: UIImageView!
    
    @IBOutlet weak var podcastCollectionName: UILabel!
    
    @IBOutlet weak var podcastArtistName: UILabel!
    
    var podcast: Podcasts?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData(for: podcast!)
    }
    
    func loadData(for podcast: Podcasts) {
        
        podcastCollectionName.text = podcast.collectionName
        podcastArtistName.text = podcast.artistName
        podcastImage.getImage(for: podcast.artworkUrl600) { [weak self] (result) in
            
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
                DispatchQueue.main.async {
                    self?.podcastImage.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.podcastImage.image = image
                }
            }

}
}
    
    @IBAction func favorited(_ sender: UIBarButtonItem) {
        
        sender.isEnabled = false
        
        guard let podcast = podcast else {
            print("favorite could not be unwrapped")
            return
        }
        
        let addedFavorite = FavoritesDataLoad(trackId: podcast.trackId, favoritedBy: "Mai", collectionName: podcast.collectionName, artworkUrl600: podcast.artworkUrl600)
        
        FavoritesAPIClient.postFavorites(favorite: addedFavorite) { [weak self] (result) in
            
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Failed to Post", message: "\(appError)")
                    sender.isEnabled = true
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Favorite added!", message: "\(addedFavorite.collectionName) added to your favorites")
            }
        }
    }
    
}
}
