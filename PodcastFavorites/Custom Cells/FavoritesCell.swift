//
//  FavoritesCell.swift
//  PodcastFavorites
//
//  Created by Maitree Bain on 12/17/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {

    @IBOutlet weak var favoritesImage: UIImageView!
    
    @IBOutlet weak var favoritesTitle: UILabel!
    
    @IBOutlet weak var favoritedBy: UILabel!
    
    
    func configureCel(for favorite: FavoritesDataLoad) {
        
        favoritesTitle.text = favorite.collectionName
        favoritedBy.text = favorite.favoritedBy
        
        favoritesImage.getImage(for: favorite.artworkUrl600) { [weak self] (result) in
            
            switch result {
            case .failure(let appError):
                print("appError: \(appError)")
                DispatchQueue.main.async {
                    self?.favoritesImage.image = UIImage(systemName: "star.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.favoritesImage.image = image
                }
            }
        }
    }
    
    
}
