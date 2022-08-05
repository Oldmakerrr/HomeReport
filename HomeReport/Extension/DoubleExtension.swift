//
//  DoubleExtension.swift
//  HomeReport
//
//  Created by Apple on 05.08.2022.
//

import Foundation

extension Double {
    
    var currencyFormatter: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self))
    }
    
}
