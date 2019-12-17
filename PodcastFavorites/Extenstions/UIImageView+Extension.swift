//
//  UIImageView+Extension.swift
//  PodcastFavorites
//
//  Created by Maitree Bain on 12/17/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

extension UIImageView {
    func getImage(for urlString: String, completion: @escaping (Result<UIImage, AppError>) -> ()) {
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .blue
        activityIndicator.startAnimating()
        activityIndicator.center = center
        addSubview(activityIndicator)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { [weak activityIndicator] (result) in
          DispatchQueue.main.async {
            activityIndicator?.stopAnimating()
          }
          switch result {
          case .failure(let appError):
            completion(.failure(.networkClientError(appError)))
          case .success(let data):
            if let image = UIImage(data: data) {
              completion(.success(image))
            }
          }
        }
        
    }
}
