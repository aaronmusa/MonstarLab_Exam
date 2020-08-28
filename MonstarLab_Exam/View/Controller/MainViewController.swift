//
//  MainViewController.swift
//  MonstarLab_Exam
//
//  Created by Aaron Musa on 8/28/20.
//  Copyright © 2020 Aaron Musa. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    lazy var viewModel: MainViewModel = {
        return MainViewModel(repository: Repository.shared, delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getData()
    }
}

extension MainViewController: BaseViewModelDelegate {
    func didChangeState(state: State) {
        switch state {
        case .loading:
            showLoadingIndicator()
        case .success( _):
            DispatchQueue.main.async {
                self.dismissLoadingIndicator()
                self.tableView.reloadData()
            }
        case .error(let message):
            if let message = message {
                dismissLoadingIndicator()
                showAlert(message: message)
            }
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let row = indexPath.row
        
        cell.mainTitleLabel.text = viewModel.titleOfItemAt(row)
        if let url = URL(string: viewModel.thumbnailUrlOfItemAt(row)) {
            cell.colorImageView.loadImage(with: url)
        } else {
            cell.colorImageView.image = UIImage()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.showDetail, sender: viewModel.itemAt(indexPath.row))
    }
}
