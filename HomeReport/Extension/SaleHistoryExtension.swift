//
//  SaleHistoryExtension.swift
//  HomeReport
//
//  Created by Apple on 05.08.2022.
//

import Foundation
import CoreData

extension SaleHistory {
    
    func soldHistoryData(for home: Home, moc: NSManagedObjectContext) -> [SaleHistory] {
        let soldHistoryRequest: NSFetchRequest<SaleHistory> = SaleHistory.fetchRequest()
        soldHistoryRequest.predicate = NSPredicate(format: "home = %@", home)
        do {
            let soldHistory = try moc.fetch(soldHistoryRequest)
            return soldHistory
        } catch let error as NSError {
            fatalError("Failed create Sold History with error:  \(error.localizedDescription)")
        }
    }
    
}
