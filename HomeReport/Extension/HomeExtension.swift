//
//  HomeExtension.swift
//  HomeReport
//
//  Created by Apple on 05.08.2022.
//

import Foundation
import CoreData

extension Home {
    
    func getHomesByStatus(isForSale: Bool,
                          filterBy: NSPredicate?,
                          sortBy: [NSSortDescriptor],
                          moc: NSManagedObjectContext) -> [Home] {
        
        let request: NSFetchRequest<Home> = Home.fetchRequest()
        
        var predicates = [NSPredicate]()
        let statusPredicate = NSPredicate(format: "isForSale = %@", NSNumber(value: isForSale))
        predicates.append(statusPredicate)
        if let additionalPredicate = filterBy {
            predicates.append(additionalPredicate)
        }
        let predicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
        request.predicate = predicate
        
        request.sortDescriptors = sortBy.isEmpty ? nil : sortBy
        
        do {
            let homes = try moc.fetch(request)
            return homes
        } catch let error as NSError {
            fatalError("Failed fetch Home with error: \(error.localizedDescription)")
        }
    }
}
