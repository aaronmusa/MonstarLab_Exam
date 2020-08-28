//
//  MainViewModel.swift
//  MonstarLab_Exam
//
//  Created by Aaron Musa on 8/28/20.
//  Copyright © 2020 Aaron Musa. All rights reserved.
//

import Foundation

protocol BaseViewModelDelegate: class {
    func didChangeState(state: State)
}

class MainViewModel {
    let repository: RepositoryProtocol
    weak var delegate: BaseViewModelDelegate?
    
    private var items = [Item]()
    var numberOfItems: Int {
        return items.count
    }
    
    init(repository: RepositoryProtocol, delegate: BaseViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    func getData() {
        delegate?.didChangeState(state: .loading)
        repository.getDataFromServer(with: Endpoint.photos, successHandler: { items in
            self.items = items
            self.delegate?.didChangeState(state: .success(nil))
        }, errorHandler: { message in
            self.delegate?.didChangeState(state: .error(message))
        })
    }
    
    // Data Transformations
    func titleOfItemAt(_ index: Int) -> String {
        return items[safe: index]?.title ?? ""
    }
    
    func thumbnailUrlOfItemAt(_ index: Int) -> String {
        return items[safe: index]?.thumbnailUrl ?? ""
    }
    
    func itemAt(_ index: Int) -> Item? {
        return items[safe: index]
    }
}
