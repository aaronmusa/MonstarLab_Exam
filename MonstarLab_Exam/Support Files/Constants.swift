//
//  Constants.swift
//  MonstarLab_Exam
//
//  Created by Aaron Musa on 8/28/20.
//  Copyright © 2020 Aaron Musa. All rights reserved.
//

import UIKit

typealias SuccessTaskHandler = ((Data, URLResponse?) -> Void)
typealias ErrorHandler = ((ErrorResponse) -> Void)

let screenHeight = UIScreen.main.bounds.height
let screenWidth = UIScreen.main.bounds.width

let baseUrl = "https://jsonplaceholder.typicode.com/"

struct Endpoint {
    static let photos = "photos"
}

enum State {
    case loading
    case success(String?)
    case error(String?)
}

struct Segue {
    static let showDetail = "ShowDetail"
}
