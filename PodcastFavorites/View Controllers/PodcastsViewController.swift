//
//  ViewController.swift
//  PodcastFavorites
//
//  Created by Maitree Bain on 12/16/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

class PodcastsViewController: UIViewController {

    @IBOutlet weak var podcastTableView: UITableView!
    
    @IBOutlet weak var podcastsSearchBar: UISearchBar!
    
    var podcasts = [Podcasts](){
        didSet {
            DispatchQueue.main.async{
            self.podcastTableView.reloadData()
        }
        }
    }
    
    var searchQuery = "swift" {
        didSet {
            self.searchBarQuery()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        podcastTableView.delegate = self
        podcastTableView.dataSource = self
        podcastsSearchBar.delegate = self
        loadData()
        searchBarQuery()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let podcastsDetailController = segue.destination as? DetailViewController,
            let indexPath = podcastTableView.indexPathForSelectedRow else {
                fatalError("no segue found")
        }
        let podcastSelected = podcasts[indexPath.row]
        
        podcastsDetailController.podcast = podcastSelected
        
    }
    
    func loadData() {
        
        PodcastsAPIClient.getPodcast(for: searchQuery) { (result) in
            
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let podcasts):
                self.podcasts = podcasts
            }
        }
    }
    
    func searchBarQuery() {
        podcasts = podcasts.filter{ $0.collectionName.lowercased().contains(searchQuery.lowercased())}
    }

    
}

extension PodcastsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as? PodcastCell else {
            fatalError("cell doesn't conform to Podcast cell")
        }
        let selectedPodcast = podcasts[indexPath.row]
        
        cell.configureCell(for: selectedPodcast)
        
        return cell
    }
}

extension PodcastsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
            guard let searchText = searchBar.text else {
                print("missing search text")
                return
            }
            searchQuery = searchText
        loadData()
        }
    
    }
