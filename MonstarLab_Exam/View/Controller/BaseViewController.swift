//
//  BaseViewController.swift
//  MonstarLab_Exam
//
//  Created by Aaron Musa on 8/28/20.
//  Copyright © 2020 Aaron Musa. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.showDetail, let item = sender as? Item, let destinationVc = segue.destination as? DetailViewController {
            
            destinationVc.viewModel = DetailViewModel(item: item)
        }
    }
    
    // Methods
    func showLoadingIndicator() {
        guard view.subviews.contains(activityIndicator) == false else { return }
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func dismissLoadingIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}

