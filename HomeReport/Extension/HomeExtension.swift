//
//  HomeExtension.swift
//  HomeReport
//
//  Created by Apple on 05.08.2022.
//

import Foundation
import CoreData

extension Home {
    
    func getHomesByStatus(isForSale: Bool, moc: NSManagedObjectContext) -> [Home] {
        let request: NSFetchRequest<Home> = Home.fetchRequest()
        request.predicate = NSPredicate(format: "isForSale = %@", NSNumber(value: isForSale))
        do {
            let homes = try moc.fetch(request)
            return homes
        } catch let error as NSError {
            fatalError("Failed fetch Home with error: \(error.localizedDescription)")
        }
    }
}
