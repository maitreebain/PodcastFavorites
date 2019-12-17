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
    
    var podcasts: Podcasts?
    
    var favorite: FavoritesDataLoad?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData(for: podcasts!)
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
        
        let addedFavorite = FavoritesDataLoad(trackId: favorite!.trackId, favoritedBy: favorite!.favoritedBy, collectionName: favorite!.collectionName, artworkUrl600: favorite!.artworkUrl600)
    }
    
}
