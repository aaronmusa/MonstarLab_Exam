//
//  MainViewController.swift
//  MonstarLab_Exam
//
//  Created by Aaron Musa on 8/28/20.
//  Copyright © 2020 Aaron Musa. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
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
        
    }
}
