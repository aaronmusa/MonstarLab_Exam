//
//  Repository.swift
//  MonstarLab_Exam
//
//  Created by Aaron Musa on 8/28/20.
//  Copyright © 2020 Aaron Musa. All rights reserved.
//

import Foundation

protocol RepositoryProtocol {
    
}

class Repository: RepositoryProtocol {
    
    static let shared = Repository()
    
    private init() {}
    

}
