//
//  FavoritesViewController.swift
//  PodcastFavorites
//
//  Created by Maitree Bain on 12/17/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesTableView: UITableView!
    
    var favorite = [Podcasts]() {
        didSet {
            DispatchQueue.main.async {
                self.favoritesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let favoritesDetailController = segue.destination as? DetailViewController,
            let indexPath = favoritesTableView.indexPathForSelectedRow else {
                fatalError("no segue found")
        }
        let selectedFavorite = favorite[indexPath.row]
        
        favoritesDetailController.podcast = selectedFavorite
    }

    func loadData() {
        
        FavoritesAPIClient.getFavorites { (result) in
            
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let favorite):
                self.favorite = favorite
            }
        }
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as? FavoritesCell else {
            fatalError("cell not conforming to favorites cell")
        }
        let selectedFavorite = favorite[indexPath.row]
        
        cell.configureCel(for: selectedFavorite)
        
        return cell
    }
    
}
