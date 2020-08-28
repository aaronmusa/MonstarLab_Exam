//
//  Item.swift
//  MonstarLab_Exam
//
//  Created by Aaron Musa on 8/28/20.
//  Copyright © 2020 Aaron Musa. All rights reserved.
//

import Foundation

struct Item: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
