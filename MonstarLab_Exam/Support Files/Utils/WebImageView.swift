//
//  WebImageView.swift
//  MonstarLab_Exam
//
//  Created by Aaron Musa on 8/28/20.
//  Copyright © 2020 Aaron Musa. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    var imageURL: URL!

    let activityIndicator = UIActivityIndicatorView()
    
    func loadImage(with url: URL) {
    
        activityIndicator.color = .darkGray
        image = nil
        imageURL = url
        
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        
        let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let _ = error {
                    DispatchQueue.main.async(execute: {
                        self.activityIndicator.stopAnimating()
                    })
                }
                
                if let data = data, let response = response, let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode < 300, let image = UIImage(data: data) {
                    
                    if self.imageURL == url {
                        DispatchQueue.main.async {
                            self.image = image
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            }.resume()
    }
}
