//
//  DetailViewController.swift
//  MonstarLab_Exam
//
//  Created by Aaron Musa on 8/28/20.
//  Copyright © 2020 Aaron Musa. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    // Outlets
    @IBOutlet weak var itemImageView: WebImageView!
    
    // Variables
    var viewModel: DetailViewModel!
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: viewModel.imageUrlOfItem()) {
            itemImageView.loadImage(with: url)
        }
    }
}
