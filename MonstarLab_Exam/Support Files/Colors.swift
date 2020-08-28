//
//  Colors.swift
//  MonstarLab_Exam
//
//  Created by Aaron Musa on 8/28/20.
//  Copyright © 2020 Aaron Musa. All rights reserved.
//

import UIKit

struct Color {
    static var customBackground: UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        }
        
        return .white
    }
    
    static var customLabel: UIColor {
        if #available(iOS 13.0, *) {
            return .label
        }
        
        return .black
    }
}
