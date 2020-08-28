//
//  DetailViewModel.swift
//  MonstarLab_Exam
//
//  Created by Aaron Musa on 8/28/20.
//  Copyright © 2020 Aaron Musa. All rights reserved.
//

import Foundation

class DetailViewModel {
    let item: Item
    
    init(item: Item) {
        self.item = item
    }
    
    // Data Transformations
    func imageUrlOfItem() -> String {
        return item.url
    }
}
