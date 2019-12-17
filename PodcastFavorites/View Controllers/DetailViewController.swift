//
//  PodcastsDetailController.swift
//  PodcastFavorites
//
//  Created by Maitree Bain on 12/17/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var detailCollectionName: UILabel!
    
    @IBOutlet weak var detailArtistName: UILabel!
    
    var podcast: Podcasts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadData(for: podcast!)
    }
    
    func loadData(for podcast: Podcasts) {
        
        detailCollectionName.text = podcast.collectionName
        detailArtistName.text = podcast.artistName
        detailImage.getImage(for: podcast.artworkUrl600) { [weak self] (result) in
            
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
                DispatchQueue.main.async {
                    self?.detailImage.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.detailImage.image = image
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
        
        let addedFavorite = Podcasts(collectionId: podcast.collectionId, trackId: podcast.trackId, favoritedBy: "Mai", artistName: podcast.artistName, collectionName: podcast.collectionName, artworkUrl60: podcast.artworkUrl60, artworkUrl600: podcast.artworkUrl600, favoritedId: podcast.favoritedId)
        
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
 
    func favoritesLoadData(for favorite: Podcasts) {
        
        detailCollectionName.text = favorite.collectionName
        detailArtistName.text = favorite.favoritedBy
        detailImage.getImage(for: favorite.artworkUrl600) { [weak self] (result) in
            
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
                DispatchQueue.main.async {
                    self?.detailImage.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.detailImage.image = image
                }
            }
        }
    }
    
}
