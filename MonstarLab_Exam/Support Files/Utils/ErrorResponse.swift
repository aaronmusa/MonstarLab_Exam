//
//  ErrorResponse.swift
//  MonstarLab_Exam
//
//  Created by Aaron Musa on 8/28/20.
//  Copyright © 2020 Aaron Musa. All rights reserved.
//

import Foundation

struct ErrorResponse {
    let code: Int
    let message: String?
    let userInfo: [String: Any]
}
