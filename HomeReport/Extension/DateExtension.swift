//
//  DateExtension.swift
//  HomeReport
//
//  Created by Apple on 05.08.2022.
//

import Foundation

extension Date {
    
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
    
}
